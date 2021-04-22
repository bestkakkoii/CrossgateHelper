//網絡驗證
///////////////////////
//初始化登出狀態//切斷與伺服器連線
function ForceDisconnect(HWND)
    wmint(HWND, #00D0CEA0, 0, 0)
    wmint(HWND, #00D15718, 2, 0)
    wmint(HWND, #0072BA24, 2, 0)
    wmint(HWND, #00C0CBD4, 2, 0)
    loginstate = false
end
//自動登入網路驗證
function SetServerProc(HWND)
    var state = array()
    SignOut()
    bc.Delay(100)
    var accountID = rmstring(HWND, #009271B8, 200)
    state[0] = SignOnW(accountID, AESdecrypt("ded6c8c6c1e40e4b580e889917127e73"))
    bc.Delay(1000)
    if(state[0] != 1)
        accountID = rmstring(HWND, #009271B8, 200)
        state[1] = SignUpW(accountID, AESdecrypt("ded6c8c6c1e40e4b580e889917127e73"), accountID)
        bc.Delay(100)
        //traceprint("SignUp" & state[1])
        state[2] = SignOnW(accountID, AESdecrypt("ded6c8c6c1e40e4b580e889917127e73"))
        bc.Delay(100)
        if(state[2] != 1)
            SendMonitorMsgW(AESdecrypt("46d6996d0dc6960009e46d3bb46c94fb"))
            ForceDisconnect(HWND)
            threadbegin("SetAnnoy", null)
            return false
        end
    end
    //traceprint("Login State: " & state[0] & " with acct: " & accountID)
    var result = CheckUserW()
    if(result != "")
        var Server_key = GetUserKeyW()
        var global_keyEX = Ser_Decryption(Server_key, AESdecrypt("1e7ddeb64a73696dd3cb214a511bb2db8d0eddd6caeb7cf54c70b0b7e2b9e1d2"), AESdecrypt("8437e0cc099f206bbc20a4a1403b49ce"))
        var ret = DataDecryption(result, global_keyEX, AESdecrypt("fa17fb342f7c2658094d27fe54512379adcb2b70e10fb2cce3a1c666b5bf93fa"), AESdecrypt("cdbf9c8b2f2d36854bf1e917de06910e3c415ccccc0fda3cfc4f0d1a42c4a1f4"), 0)
        strsplit(ret, "|", WebInformation)
        if(strlen(WebInformation[2]) > 0)
            wmint(HWND, #00598858, 2, 1)//初始戰鬥狀態
            bc.Delay(10)
            var content = GetCustomMsg()
            bc.Delay(1000)
            if(content != 0)
                Activation(HWND, content)
                return true
            end
        end
    end
    return false
end
//初始化多項功能與代碼寫入
function Activation(HWND, content)
    var mapID = GetMapID(HWND)
    var accountID = GetAccountID(HWND)
    SetData(HWND, content)
    bc.Delay(10)
    SkipEffect(HWND)
    bc.Delay(10)
    SetMainInfo(HWND)
    bc.Delay(10)
    LoadSet(1)
    bc.Delay(10)
    SetMapLoad(mapID)
    LoginPreCheck = true
    EnableControl(true)
    if(webreg)
        PushAnnounce(HWND, GetPlacardW())
        PushAnnounce(HWND, strformat("您登記的帳號 %s 到期時間為:%s", accountID, WebInformation[2]))
    else
        PushAnnounce(HWND, strformat("歡迎使用水藍小幫手，目前使用版本為(%s)", strreplace(SubCgHPver, ".", "")))
        PushAnnounce(HWND, strformat("您登記的帳號 %s 到期時間為:%s", accountID, WebInformation[2]))
    end
    var code = editgettext("edit12")
    if(strlen(code) >= 6)
        SetSecurtyCodeFree(HWND, code)
    end
    code = null
    content = null
    SetMapData(HWND)
end
//取自定義數據
function GetCustomMsg(type = 0)
    var result = ""
    select(type)
        case 0
        result = GetCustomW(AESdecrypt("23d359303237912ecfa55fd155ca2e340c093b38f7a0c8d31b3f73492716f4e76a4b093496a44bed9208726a5a9a648d263af102a0d7b8a5de1b32345049ae9b"))//a-@XRNKY.FEazn4uDrUkagFp?Bf@DG8%#Z!v9FWnAhEzgr7kaM=sKpy.m@mZ?P5
    end
    if(result == "")
        return 0
    end
    var Server_key = GetUserKeyW()
    var global_keyEX = Ser_Decryption(Server_key, AESdecrypt("1e7ddeb64a73696dd3cb214a511bb2db8d0eddd6caeb7cf54c70b0b7e2b9e1d2"), AESdecrypt("8437e0cc099f206bbc20a4a1403b49ce"))
    var Data = DataDecryption(result, global_keyEX, AESdecrypt("fa17fb342f7c2658094d27fe54512379adcb2b70e10fb2cce3a1c666b5bf93fa"), AESdecrypt("cdbf9c8b2f2d36854bf1e917de06910e3c415ccccc0fda3cfc4f0d1a42c4a1f4"), 1)
    return Data
end
//到期提示 
function SetAnnoy()
    msgbox(AESdecrypt("f699f015aa12875b5a33f7b7b954193309bc897fd0d19ff2d8ab2c556c2e0783fedc247de1a5346cb3573d54b426149fa6cfd61612c4d05c87f752f6be93f79d"))
    openprocessex("https://lovesa.cc/", "")
end
//心跳線程與代碼檢測下斷防護
function HeartBeat(HWND)
    var time_left = 0
    var i = 0
    while(true)
        if(webreg)
            time_left = GetUserTime()
            if(time_left <= 0)
                SendMonitorMsgW(AESdecrypt("ccf25cfd1cf28006ba3f89acce53c9e9") & ":" & time_left)
            elseif(time_left > 0)
                var myname = GetMyName(HWND)
                var level = GetLevel(HWND)
                var money = GetMoneyLeft(HWND)
                var map = GetMap(HWND)
                var mapID = GetMapID(HWND)
                if(myname != "")
                    SetUserRemark(strformat("%s LV:%s HP:%s/%s MP:%s/%s 魔幣:%s 伺服器:%s 地圖:%s(%s) 坐標:%s,%s 時間:%s 版本:%s 累積戰鬥:%s分/%s回合", myname, level, mainHP, mainMAXHP, mainMP, mainMAXMP, money, ServerNaming(HWND), map, mapID, east, south, timeGetTime(HWND), SubCgHPver, TotalDuration / 60, TotalRound))
                end
            end
        end
        if(checkgetstate("check8"))
            bc.FreeProcessMemory(HWND)
        end
        bc.Delay(800000)
        if(bc.GetWindowState(bchwnd, 6))
            Protection(HWND)
        end
        SetVertifyData(HWND)
        var content = httpgetpage("https://www.lovesa.cc/updates/announce.txt", "utf-8")
        if(content != "")
            if(strfind(content, "|") != -1)
                var tmp
                var size = strsplit(content, "|", tmp)
                for(var j = 0; j < size; j++)
                    PushAnnounce(HWND, tmp[j])
                    bc.Delay(10)
                end
                content = null
                size = null
            end
        end
    end
    return false
end
//清除遊戲內彙編代碼存檔
function ClearGameDat()
    for(var i = 0; i < 10; i++)
        filedelete(strformat("%s/data/%d/guildmail.dat", bcpath, i))
    end
end
//驗證彙編代碼是否被修改
function SetVertifyData(HWND)
    if(LoginPreCheck)
        var tmp = null
        if(webreg)
            tmp = GetCustomMsg()
        else
            tmp = AESdecrypt(httpgetpage("https://www.lovesa.cc/updates/ac842f9d1edf389d803124d6c92be8e6ab7758ee.spp", "utf-8"))
        end
        if(bc.FindDataEx(g_hwnd, "00DF0000-00DFFFFF", tmp, 1, 1, 0) != "DF0000")
            if(webreg)
                var accountID = GetAccountID(HWND)
                SendMonitorMsgW(accountID & ": " & AESdecrypt("e7159d8df608b4c63981b6b433cbe521"))
            end
            TerminateProcess(GetProcessID(StairFinderHwnd))
            closeprocess(getprocesshandle(windowgetcaption(HWND)))
            bc.SetWindowState(HWND, 0)
            TerminateProcess(GetProcessID(HWND))
            SetProcessInit(HWND)
            bc.Delay(100)
            TerminateProcess(GetCurrentProcess())
        end
        tmp = null
    end
end
//網路驗證函數庫
function InitDllW(token, project)
    return dllcall(rc & "WebReg.dll", "long", "InitDllW", "wchar *", token, "wchar *", project)
end
function SignOnW(acct, pw)
    return dllcall(rc & "WebReg.dll", "long", "SignOnW", "wchar *", acct, "wchar *", pw)
end
function SignOnAutoW(acct, pw)
    return dllcall(rc & "WebReg.dll", "long", "SignOnAutoW", "wchar *", acct, "wchar *", pw)
end
function SignUpW(acct, pw, comment)
    return dllcall(rc & "WebReg.dll", "long", "SignUpW", "wchar *", acct, "wchar *", pw, "wchar *", comment) 
end
function GetCustomW(key)
    var result = 0
    dllcall(rc & "WebReg.dll", "long", "GetCustomW", "wchar *", key, "pwchar *", result, "long", 1024 * 12)
    return result
end
function UpdateFileExW(Ver, Auto = 0)
    return dllcall(rc & "WebReg.dll", "long", "UpdateFileExW", "wchar *", Ver, "long", Auto)
end
function SignOut()
    return dllcall(rc & "WebReg.dll", "long", "SignOut") 
end
function GetUserTime()
    return dllcall(rc & "WebReg.dll", "long", "GetUserTime")
end
function GetUserTimeEx()
    return dllcall(rc & "WebReg.dll", "long", "GetUserTimeEx") 
end
function GetUserKeyW()
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "GetUserKeyW", "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "GetUserKeyW", "pwchar *", result, "long", ret)
    return result
end
function CheckUserW()
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "CheckUserW", "pwchar *", result, "long", 1024 * 4)
    return result 
end
function GetUserRemark()
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "GetUserRemark", "pchar *", result, "long", 1024 * 4)
    return result 
end
function SetUserRemark(remark)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "SetUserRemark", "char *", remark)
    return result 
end
function SendMonitorMsgW(msg, title = "CgHPM")
    return dllcall(rc & "WebReg.dll", "long", "SendMonitorMsgW", "wchar *", title, "wchar *", msg)
end
function GetPlacardW()
    var result
    var ret = dllcall(rc & "WebReg.dll", "long", "GetPlacardW", "pwchar *", result, "long", 0)
    dllcall(rc & "WebReg.dll", "long", "GetPlacardW", "pwchar *", result, "long", ret)
    return result
end
function DataDecryption(Data, Key, prefix, suffix, dType)
    if(strlen(Key) == 0)
        return true
    end
    var Data1 = strsub(Data, strlen(prefix), strlen(Data) - strlen(suffix))
    var AES_Flag
    var presplitData
    if(dType == 1)
        AES_Flag = 取輔助API算法(Data1, presplitData)
    else
        AES_Flag = 取驗證API算法(Data1, presplitData)
    end
    var Data2 = strsub(Data1, strlen(presplitData), strlen(Data1))
    return Ser_Decryption(Data2, Key, AES_Flag)
end
function 取驗證API算法(str1, &splitData)
    var str = "AES|abkc3cRgxWXXpZ9\r\nDES|8XNqkecWzMPEm4y\r\nTEA|tRY5mCSucwfuqZN\r\nRC2|AvDkAyK4trvNd78\r\nRC5|3XcryZzgMzsNU4H\r\nRC6|AfBytuCytAfcuK9"
    var ret_arr
    var n = strsplit(str, "\r\n", ret_arr)
    for(var i = 0; i < n; i++)
        var tmp
        strsplit(ret_arr[i], "|", tmp)
        if(strncmp(str1, tmp[1], strlen(tmp[1])) == 0)
            splitData = tmp[1]
            return tmp[0]
        end
    end
end
function 取輔助API算法(str1, &splitData)
    var str = "AES|YMcfrBYV9fcZuv3\r\nDES|kDevnyVhTqqWwAs\r\nTEA|TgAdVCfdpxRVyPf\r\nRC2|wnZXcCf6dNhkTsV\r\nRC5|td7CYaMpgRyewu5\r\nRC6|x75xnvCRcs7pgNZ"
    var ret_arr
    var n = strsplit(str, "\r\n", ret_arr)
    for(var i = 0; i < n; i++)
        var tmp 
        strsplit(ret_arr[i], "|", tmp)
        if(strncmp(str1, tmp[1], strlen(tmp[1])) == 0)
            splitData = tmp[1]
            return tmp[0]
        end
    end
end
function Ser_Decryption(Data, Key, Flag)
    select(Flag)
        case "AES"
        return AesDecryptW(Data, Key)
        case "DES"
        return DesDecryptW(Data, Key)
        case "TEA"
        return TeaDecryptW(Data, Key)
        case "RC2"
        return Rc2DecryptW(Data, Key)
        case "RC5"
        return Rc5DecryptW(Data, Key)
        case "RC6"
        return Rc6DecryptW(Data, Key)
        case "BLOWFISH"
        return BlowfishDecryptW(Data, Key)
        default
        return Data
    end
end
function AesEncryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "AesEncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "AesEncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result
end
function AesDecryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "AesDecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "AesDecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function DesEncryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "DesEncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "DesEncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function DesDecryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "DesDecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "DesDecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function BlowfishEncryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "BlowfishEncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "BlowfishEncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function BlowfishDecryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "BlowfishDecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "BlowfishDecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function TeaEncryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "TeaEncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "TeaEncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function TeaDecryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "TeaDecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "TeaDecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function Rc2EncryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "Rc2EncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "Rc2EncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function Rc2DecryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "Rc2DecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "Rc2DecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function Rc5EncryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "Rc5EncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "Rc5EncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function Rc5DecryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "Rc5DecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "Rc5DecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function Rc6EncryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "Rc6EncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "Rc6EncryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function Rc6DecryptW(str, key)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "Rc6DecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "Rc6DecryptW", "wchar *", str, "wchar *", key, "pwchar *", result, "long", ret)
    return result 
end
function MD5W(str)
    var result = 0
    var ret = dllcall(rc & "WebReg.dll", "long", "MD5W", "wchar *", str, "pwchar *", result, "long", 0)
    ret = dllcall(rc & "WebReg.dll", "long", "MD5W", "wchar *", str, "pwchar *", result, "long", ret)
    return result 
end