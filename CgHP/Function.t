///固定功能////
function EnableControl(bool)
    controlenable("check7", bool)
    controlenable("check14", bool)
    controlenable("check15", bool)
    controlenable("check16", bool)
    controlenable("check17", bool)
    controlenable("check18", bool)
    controlenable("check19", bool)
    controlenable("check20", bool)
    controlenable("check21", bool)
    controlenable("check22", bool)
    controlenable("check23", bool)
    controlenable("check24", bool)
    controlenable("check27", bool)
    controlenable("check28", bool)
    controlenable("check29", bool)
    controlenable("check30", bool)
end
//錯誤訊息解析
function GetRegbcdllError(bcreg)
    select(bcreg)
        case -1
        msgbox(AESdecrypt("3a317a706c157adeb76389ed048bf6f9e6f5fadb36b5be28184672f6750286f1d11f7697ceceafff95bd17f0348fe83e"), 4)
        case -2
        msgbox(AESdecrypt("df4996ec5798cf7411795691f413c979e903c999e1aad964fd751c7567d8419c"), 4)
        case 0
        msgbox(AESdecrypt("32bcd636a760127376eef38df406b193"), 4)
        case 4
        msgbox(AESdecrypt("afc356ae621eba5631d4e1106ed67ed2c109ab830e6919c2822727fabc943405"), 4)
        case 5
        msgbox(AESdecrypt("c7ff40b1981c51408b00a7756d3b59f9761f54245b26e1ce4ddbe89ddeab0c0ba99e7511ad2c2a69b92116beaafc62e3"), 4)
        case 6
        msgbox(AESdecrypt("d712dac1187fb8622801c97a25ef38f0"), 4)
        case 7
        msgbox(AESdecrypt("9b22d68d7092fcd84dc212ed552889ee37b142142bf3f53fc4f79d2dd3a6735fc109ab830e6919c2822727fabc943405"), 4)
        case 8
        msgbox(AESdecrypt("d726db8b3f6e03e71c575e5a474329e8877dbccf94ae24f093c86f1d6fa64094c109ab830e6919c2822727fabc943405"), 4)
        case 77
        msgbox(AESdecrypt("e0a7b14b26b0408809c0b556eff371100c8426ad834e95e4a8650feb4265a682984b4a784412dd18192ef0cedf181d6f"), 4)
        case -8
        msgbox(AESdecrypt("3e55c7fcd667017427ae59a67362637b0a74b6166e88cd1594d92bd4d09a6a85"), 4)
        case -9
        msgbox(AESdecrypt("9250ca65b121453a88f057454ce503bfb92d0aab9a95b30b723160573f91e795"), 4)
    end
    if(!bcreg)
        TerminateProcess(GetCurrentProcess())
    end
end
//設置主狀態文字
function SetStatus(num)
    var STATUSWORD = ""
    select(num)
        case 0
        STATUSWORD = AESdecrypt("cebcaf40e784739bd6d34b6f4eb9ceb9")//"開啟魔力中．．"
        case 1
        STATUSWORD = AESdecrypt("2da70f467b69f53fa44995a40381791a")//"選擇伺服器"
        case 2
        STATUSWORD = AESdecrypt("e6240f2e7e6fdf97ab511ed27c177bc2")//"選擇分伺服器"
        case 3
        STATUSWORD = AESdecrypt("6fb208f7238654fe8e5fb31b9ca0e685")//"選擇人物中"
        case 4
        STATUSWORD = AESdecrypt("0a29f458dc6f4a1b1bef9217e0435278")//"平時"
        case 5
        STATUSWORD = AESdecrypt("363bb03c175961db7e17f2d2b06fd969")//"戰鬥中"
        case 6
        STATUSWORD = AESdecrypt("343cb04c5f132dee42500846711bd7c3")//"斷線"
        case 7
        STATUSWORD = AESdecrypt("ef111188c4c1c82ff3212a0c86c967ef")//"未開啟魔力"
        case 8
        STATUSWORD = AESdecrypt("b37b0fbdd7f10bdc1f2ae70717c6d96d")//"鎖定遊戲中．．"
        case 9
        STATUSWORD = AESdecrypt("8270579039402c2ef35f9860cf35bc92")//"登入"
        case 10
        STATUSWORD = AESdecrypt("c6ce6e7bfd9c870bbb199c8e8302c3c2")//"魔力無響應．．"
        case 11
        STATUSWORD = AESdecrypt("510d9bf6a5b1296b50bd2dfc8d2ea69b")//"檢查更新中．．"
        case 12
        STATUSWORD = ""
        case 13
        STATUSWORD = AESdecrypt("1bab36636a7558fce25e3b46323521f238b79f27385b2882d58187d6242fb761")//"小幫手初始化中．．"
        case 14
        STATUSWORD = AESdecrypt("052494ae37019ae4f3cfd40fd32ff17a38b79f27385b2882d58187d6242fb761")//"重新啟動魔力中．．"
        case 15
        STATUSWORD = AESdecrypt("41b603963a393b0637bc89b90df1627d")//"選擇魔力目錄．．"
    end
    if(STATUSWORD != STATUSWORDSAVED)
        staticsettext("static26", STATUSWORD)
        STATUSWORDSAVED = STATUSWORD
    end
end
//取得DM IP
function GetDmIp(num)
    select(num)
        case 8
        return AESdecrypt("23669a8a4faff0b0fb524304cdab5c9f")
        case 7
        return AESdecrypt("913ff1e723f003a0a6a1db00f2493592")
        case 6
        return AESdecrypt("7949ced264383446e78c649853d75964")
        case 5
        return AESdecrypt("1c9efeadbe29de2a7cfd0854d64f0ea1")
        case 4
        return AESdecrypt("421fbd70a4a150cbe554a2aa0931c4f5")
        case 3
        return AESdecrypt("1a2f60e18f807aa650ca90226e5a65f2")
        case 2
        return AESdecrypt("7fd3826063444d1f3345b96f79024525")
        case 1
        return AESdecrypt("ebf7d0eb67441874aeb18d8b09bf30f4")
        case 0
        return AESdecrypt("a376329bd1cf39fcab39c1f7a819d5dbs")
    end
end
//允許開關轉換
var SwitchSave = 0
function checkswitcher(HWND)
    var switcher = rmint(HWND, #00F4C484, 0)
    if(SwitchSave != switcher)
        if(switcher == 0)
            checksetstate("switch0", false)
            checksetstate("switch1", false)
            checksetstate("switch2", false)
            checksetstate("switch3", false)
            checksetstate("switch4", false)
            checksetstate("switch5", false)
        elseif(switcher == 1)
            checksetstate("switch0", false)
            checksetstate("switch1", false)
            checksetstate("switch2", true)
            checksetstate("switch3", false)
            checksetstate("switch4", false)
            checksetstate("switch5", false)
        else
            var result = cbin(switcher)
            if(result[4] == 1)
                checksetstate("switch0")
            else
                checksetstate("switch0", false)
            end
            if(result[3] == 1)
                checksetstate("switch1", true)
            else
                checksetstate("switch1", false)
            end
            if(switcher % 2 != 0)
                checksetstate("switch2", true)
            else
                checksetstate("switch2", false)
            end
            if(result[2] == 1)
                checksetstate("switch3", true)
            else
                checksetstate("switch3", false)
            end
            if(result[1] == 1)
                checksetstate("switch4", true)
            else
                checksetstate("switch4", false)
            end
            if(result[0] == 1)
                checksetstate("switch5", true)
            else
                checksetstate("switch5", false)
            end
        end
        SwitchSave = switcher
    end
end
//關閉主要線程
function CloseAllThread(HWND)
    threadclose(AutoWalkID, 1)
    threadclose(AutoWalkExID, 1)
    wmdata(HWND, #00462EA2, AESdecrypt("98cdc4feff2f09851447efa1863f836a"))
    threadclose(HeartBeatID)
    threadclose(FreeProcessMemoryID)
end
//設置技能下拉框內容
function SetColContent(num)
    if(loginstate)
        coselect[num] = combogetcursel("co" & num)
        combodeleteall("col" & num)
        if(coselect[num] != 0 && coselect[num] != 1 && coselect[num] != 2)
            for(var i = 0; i < 11; i++)
                if(skillLVname[coselect[num] - 3][i] != "")
                    comboaddtext("col" & num, skillLVname[coselect[num] - 3][i])
                end
            end
            combosetcursel("col" & num, 0)
        else
            combosetcursel("col" & num, 0)
        end
    end
end
//初始化技能下拉框
function Restoreco()
    for(var i = 0; i < 7; i++)
        combodeleteall("co" & i)
        combodeleteall("col" & i)
        comboinsertitem("co" & i, 0, "攻擊")
        comboinsertitem("co" & i, 1, "防禦")
        comboinsertitem("co" & i, 2, "逃跑")
        comboinsertitem("co" & i, 3, "技能1")
        comboinsertitem("co" & i, 4, "技能2")
        comboinsertitem("co" & i, 5, "技能3")
        comboinsertitem("co" & i, 6, "技能4")
        comboinsertitem("co" & i, 7, "技能5")
        comboinsertitem("co" & i, 8, "技能6")
        comboinsertitem("co" & i, 9, "技能7")
        comboinsertitem("co" & i, 10, "技能8")
        comboinsertitem("co" & i, 11, "技能9")
        comboinsertitem("co" & i, 12, "技能10")
        comboinsertitem("co" & i, 13, "技能11")
        comboinsertitem("co" & i, 14, "技能12")
        comboinsertitem("co" & i, 15, "技能13")
        comboinsertitem("co" & i, 16, "技能14")
        combosetcursel("co" & i, 0)
    end
    for(var i = 0; i < 3; i++)
        combodeleteall("pco" & i)
        comboinsertitem("pco" & i, 0, "技能1")
        comboinsertitem("pco" & i, 1, "技能2")
        comboinsertitem("pco" & i, 2, "技能3")
        comboinsertitem("pco" & i, 3, "技能4")
        comboinsertitem("pco" & i, 4, "技能5")
        comboinsertitem("pco" & i, 5, "技能6")
        comboinsertitem("pco" & i, 6, "技能7")
        comboinsertitem("pco" & i, 7, "技能8")
        comboinsertitem("pco" & i, 8, "技能9")
        comboinsertitem("pco" & i, 9, "技能10")
        combosetcursel("pco" & i, 0)
    end
end
//判斷登入及頁面狀態
function GetStatusInfo(HWND)
    var log0 = rmint(HWND, #00D15718, 2)
    var log1 = rmint(HWND, #0072BA24, 2)
    var log2 = rmint(HWND, #00C0CBD4, 2)
    if(!log0 && log1 == 0 && log2 == 0)
        loginstate = false
    else
        loginstate = true
    end
    statueL[0] = rmint(HWND, #00F66AAB, 0)//1728149761  //2248251392-2248251400
    statueL[1] = rmint(HWND, #0061B9CB, 0)
    statueL[2] = rmint(HWND, #00F66AFD, 2)
    statueL[3] = rmint(HWND, #00F66BE9, 0)//1375731712 || 1325400064
    statueL[4] = rmstring(HWND, #0061BAE1, 50)
    subserverpagecheck = rmint(HWND, #00549E6C, 0)
    //traceprint(strformat("%s %s %s %s %s %s", loginstate, statueL[0], statueL[1], statueL[2], statueL[3], statueL[4]))
    if(statueL[1] == 769 && statueL[2] == 1)
        if(statueL[3] == 1375731712 || statueL[3] == 1325400064)
            if(statueL[0] == 1728149761 || statueL[0] > 2248251392 && statueL[0] < 2248251400)
                if(!loginstate)
                    SetStatus(9)
                    if(checkgetstate("check12"))
                        if(OneTime)
                            FindMutant(HWND)
                            bc.Delay(10)
                            OneTime = false
                        end
                    end
                end
            end
        end
    elseif(statueL[0] == 100352 && statueL[1] == 1 && statueL[2] == 0 && statueL[3] >= 1124073472)
        SetStatus(1)
    elseif(statueL[0] == 100352 && statueL[1] == 1 && statueL[2] == 1)
        if(statueL[3] == 1811939328 || statueL[3] == 1124073472 || statueL[3] <= 0 || statueL[3] >= 1157627904)
            SetStatus(2)
        end
    elseif(statueL[0] == 82176 && statueL[1] == 591872 && statueL[2] == 0)
        if(statueL[3] == 855638017 || statueL[3] == 1090519041)
            SetStatus(3)
        end
    elseif(statueL[4] == AESdecrypt("a07be38bd75e211f547b90a42defb403deab75a763e3c05d8614a3ad80dff9c4"))
        wmint(HWND, #00D15718, 2, 0)
        SetStatus(6)
        if(statueL[0] == 39936)
            wmint(HWND, #0061BAE1, 0, 0)
        end
    end
end
//自動登入
function SetAutoLogin(HWND)
    //traceprint(strformat("%s %s %s %s %s", statueL[0], statueL[1], statueL[2], statueL[3], AESdecrypt("a07be38bd75e211f547b90a42defb403deab75a763e3c05d8614a3ad80dff9c4")))
    if(statueL[1] == 769 && statueL[2] == 1)
        if(statueL[3] == 1375731712 || statueL[3] == 1325400064)
            if(statueL[0] == 1728149761 || statueL[0] > 2248251392 && statueL[0] < 2248251400)
                var account = rmstring(HWND, #009271B8, 50)
                var password = rmstring(HWND, #009274A0, 50)
                if(strlen(account) > 6 && strlen(password) > 6)
                    LogIn(account, password, 1)
                end
            end
        end
    elseif(statueL[0] == 100352 && statueL[1] == 1 && statueL[2] == 0 && statueL[3] >= 1124073472)
        SetMainServer(combogetcursel("combobox0"))
        bc.MoveTo(0, 0)
    elseif(statueL[0] == 100352 && statueL[1] == 1 && statueL[2] == 1)
        if(statueL[3] == 1811939328 || statueL[3] == 1124073472 || statueL[3] <= 0 || statueL[3] >= 1157627904)
            //開啟伺服器線程
            連線ID = threadbegin("連線中等待", null)
            bc.MoveTo(0, 0)
            SetSubserver(combogetcursel("combobox1"))
            if(!threadgetstatus(連線ID2))
                連線ID2 = threadbegin("帳號已登入", null)
            end
        end
    elseif(statueL[0] == 82176 && statueL[1] == 591872 && statueL[2] == 0)
        if(statueL[3] == 855638017 || statueL[3] == 1090519041)
            if(threadgetstatus(連線ID))
                threadclose(連線ID)
            end
            if(threadgetstatus(連線ID2))
                threadclose(連線ID2)
            end
        end
        SetChmpSpot(combogetcursel("combobox2"))
    elseif(statueL[4] == AESdecrypt("a07be38bd75e211f547b90a42defb403deab75a763e3c05d8614a3ad80dff9c4"))
        bc.MoveTo(315, 275)
        bc.LeftDoubleClick()
    end
end
//選擇主分流
function SetMainServer(num)
    var col = 0
    if(num == 3)//卡蓮
        col = 1
        num = 0
    elseif(num == 4)//獅子
        col = 1
        num = 1 
    elseif(num == 5)//雙子
        col = 1
        num = 2 
    end
    var X = 155 + (100 * col)
    var Y = 120 + (30 * num)
    bc.MoveTo(X, Y)
    bc.LeftClick()
end
function 帳號已登入()
    bc.Delay(3000)
    var result = FindString(AESdecrypt("0d3117623981aa924dfdaec830a44581"), 0, 1)
    if(result == 1)
        press("OK", 1)
    end
    return false
end
function 連線中等待()
    bc.Delay(5000)
    var result = FindString(AESdecrypt("d60ae76137875bdb5a1852d7bc4f1fa6"), 0, 1)
    if(result == 1)
        press(AESdecrypt("f55ffd7d2f3de8c258e6104c60036a71"), 1)
    end
    return false
end
//選擇子分流
function SetSubserver(num)
    select(combogetcursel("combobox0"))
        case 0
        if(subserverpagecheck != 8)
            press(AESdecrypt("e53cea136b8dc2e0942d9ed4b4ca613f"), 1)
            return false
        end
        case 1
        if(subserverpagecheck != 21)
            press(AESdecrypt("e53cea136b8dc2e0942d9ed4b4ca613f"), 1)
            return false
        end
        case 2
        if(subserverpagecheck != 7)
            press(AESdecrypt("e53cea136b8dc2e0942d9ed4b4ca613f"), 1)
            return false
        end
        case 3
        if(subserverpagecheck != 0)
            press(AESdecrypt("e53cea136b8dc2e0942d9ed4b4ca613f"), 1)
            return false
        end
        case 4
        if(subserverpagecheck != 4)
            press(AESdecrypt("e53cea136b8dc2e0942d9ed4b4ca613f"), 1)
            return false
        end
        case 5
        if(subserverpagecheck != 2)
            press(AESdecrypt("e53cea136b8dc2e0942d9ed4b4ca613f"), 1)
            return false
        end
    end
    var col = 0
    if(num == 5)
        col = 1
        num = 0
    elseif(num == 6)
        col = 1
        num = 1 
    elseif(num == 7)
        col = 1
        num = 2
    end
    var X = 155 + (100 * col)
    var Y = 120 + (30 * num)
    bc.MoveTo(X, Y)
    bc.LeftDoubleClick()
end
//選擇腳色欄位
function SetChmpSpot(num)
    var X = 120, Y = 325
    if(num == 1)
        X = 425
        Y = 325
    end
    bc.MoveTo(X, Y)
    bc.LeftClick()
end
//設置子分流下拉框
function ComboServer()
    select(combogetcursel("combobox0"))
        case 0
        combodeleteall("combobox1")
        for(var i = 0; i < 8; i++)
            comboaddtext("combobox1", "櫻之舞" & (i + 1))
        end
        case 1
        combodeleteall("combobox1")
        for(var i = 0; i < 5; i++)
            comboaddtext("combobox1", "露比" & (i + 1))
        end
        case 2
        combodeleteall("combobox1")
        for(var i = 0; i < 4; i++)
            comboaddtext("combobox1", "歌姬" & (i + 1))
        end
        case 3
        combodeleteall("combobox1")
        for(var i = 0; i < 8; i++)
            comboaddtext("combobox1", "卡蓮" & (i + 1))
        end
        case 4
        combodeleteall("combobox1")
        for(var i = 0; i < 5; i++)
            comboaddtext("combobox1", "獅子" & (i + 1))
        end
        case 5
        combodeleteall("combobox1")
        for(var i = 0; i < 2; i++)
            comboaddtext("combobox1", "雙子" & (i + 1))
        end
    end
end
//背包整理
function BackpakeArrange(HWND)
    if(bchwnd > 0 && LoginPreCheck)
        bc.SendString2(HWND, "/r")
        bc.KeyPress(13)
    end
end
//NPC自動對話
function autoNPC(HWND)
    if(checkgetstate("check49"))
        NPC_hospital(HWND)
    end
    if(checkgetstate("check48"))
        NPC_recover(HWND)
    end
    if(checkgetstate("check50"))
        NPC_sellitem(HWND)
    end
    bc.Delay(1000)
    return false
end
//領取恢復
function NPC_recover(HWND)
    var result = FindString(AESdecrypt("9fc9d3d6d6b5f14054ac53c88af99d2d"), 2, 1)
    if(result)
        //p("OK")
        var addr = GetESCScreen(HWND)
        bc.Delay(300)
        DestoryNormalScreen(HWND, addr)
    end
    result = 0
    result = MemFindString(HWND, "要使用異界")
    if(result != 0)
        PressButton(HWND, "是")
        ClearFindStringResult(HWND, result)
    end
    result = 0
    result = MemFindString(HWND, "這裡是")
    if(result != 0)
        PressButton(HWND, "是")
        bc.Delay(500)
        if(press("OK", 1))
            ClearFindStringResult(HWND, result)
        end
    end
end
//醫院護士自動對話
function NPC_hospital(HWND)
    var result = FindString(AESdecrypt("8d09872b93a405e3a8f41568a20d1a02"), 2, 1)
    if(result)
        PressButton(HWND, 1)
        bc.Delay(700)
        result = FindString(AESdecrypt("4f08120a3455358829c0b1493823382c"), 2, 1)
        if(!result)
            PressButton(HWND, "是")
            bc.Delay(500)
        end
        PressButton(HWND, "確定")
        bc.Delay(500)
        PressButton(HWND, 2)
        bc.Delay(700)
        result = FindString(AESdecrypt("4f08120a3455358829c0b1493823382c"), 2, 1)
        if(!result)
            PressButton(HWND, "是")
            bc.Delay(500)
        end
        PressButton(HWND, "確定")
        bc.Delay(500)
        PressButton(HWND, 3)
        bc.Delay(700)
        result = FindString(AESdecrypt("4f08120a3455358829c0b1493823382c"), 2, 1)
        if(!result)
            PressButton(HWND, "是")
            bc.Delay(500)
        end
        PressButton(HWND, "確定")
        bc.Delay(1000)
        //p("cancel")
        bc.KeyPress(27)
        bc.Delay(300)
        bc.KeyPress(27)
    end
end
//商人全賣自動對話
function NPC_sellitem(HWND)
    var result = FindString(AESdecrypt("6382c65cbe9630b6bb6192e79a290931"), 1)
    if(result)
        FindString("賣")
        bc.Delay(700)
        press("all", 1)
        bc.Delay(700)
        press("OK", 1)
        bc.Delay(700)
        press("yes", 1)
        bc.Delay(700)
        press("cancel", 1)
        bc.Delay(700)
        PressButton(HWND, 0)
    end
end
//讀取設置經驗資訊
function SetRewardInfo(HWND)
    if(checkgetstate("check46"))
        bc.Delay(500)
        mainexp = rmint(HWND, #00F62808, 0)
        petexp = rmint(HWND, #00F62810, 0)
        receiveitem = traverse(HWND, #00F62824, 3, #01D, 3, 10)
        if(receiveitem[0] == "")
            PushAnnounce(HWND, strformat("人物經驗:%s戰寵經驗:%s", mainexp, petexp))
        elseif(receiveitem[1] == "")
            PushAnnounce(HWND, strformat("人物經驗:%s戰寵經驗:%s掉落:%s", mainexp, petexp, receiveitem[0]))
        elseif(receiveitem[2] == "")
            PushAnnounce(HWND, strformat("人物經驗:%s戰寵經驗:%s掉落:%s,%s", mainexp, petexp, receiveitem[0], receiveitem[1]))
        else
            PushAnnounce(HWND, strformat("人物經驗:%s戰寵經驗:%s掉落:%s,%s,%s", mainexp, petexp, receiveitem[0], receiveitem[1], receiveitem[2]))
        end
    end
end
//自動丟棄
function SetDropitem(HWND)
    var tmp = array()
    for(var i = 0; i < 20; i++)
        if(!combatstate)
            for(var j = 0; j < arraysize(dropitem); j++)
                if(itemName[i] == dropitem[j] && itemExist[i] > 0)
                    arraypush(tmp, i)
                end
            end
        end
    end
    if(arraysize(tmp) > 0 && !combatstate)
        var mx, my
        bc.GetCursorPos(mx, my)
        if(mx != 320 && my != 240)
            bc.MoveTo(320, 240)
        end
        for(var i = 0; i < arraysize(tmp); i++)
            PickItem(HWND, tmp[i])
            bc.Delay(15)
            bc.LeftClick()
            if(combatstate)
                break
            end
        end
    end
    arrayclear(tmp)
end
//戰鬥狀態檢測
function GetCombatStatus(HWND)
    if(rmint(HWND, #005988F4, 2))
        return 0
    end
    combatstatus[0] = rmint(HWND, #0059892C, 2)
    combatstatus[1] = rmint(HWND, #00598974, 2)
    combatstatus[2] = rmint(HWND, #00C1CD94, 2)
    if(combatstatus[0] == 0 && combatstatus[1] == 1 && combatstatus[2] == 0)//人物回合
        return 1
    elseif(combatstatus[0] == 0 && combatstatus[1] == 1 && combatstatus[2] == 1)//無寵物第一回合
        return 2
    elseif(combatstatus[0] == 1 && combatstatus[1] == 1 && combatstatus[2] == 2)//無寵物第二回合
        return 3
    elseif(combatstatus[0] == 1 && combatstatus[1] == 4 && combatstatus[2] == 3)//寵物回合
        return 4
    elseif(combatstatus[0] == 0 && combatstatus[1] == 4 && combatstatus[2] == 4)//騎寵回合
        return 5
    else
        return 0
    end
end
//移動遊戲窗口
function SetWindowMove(pos)
    select(pos)
        case 0
        bc.MoveWindow(bchwnd, 0, 0)
        case 1
        bc.MoveWindow(bchwnd, 641, 0)
        case 2
        bc.MoveWindow(bchwnd, 1281, 0)
        case 3
        bc.MoveWindow(bchwnd, 0, 507)
        case 4
        bc.MoveWindow(bchwnd, 641, 507)
        case 5
        bc.MoveWindow(bchwnd, 1281, 507)
    end
end
//自走遇敵
function AutoWalk(HWND)
    var East = int(bc.ReadFloatAddr(HWND, #0095C88C) / 64)
    var South = int(bc.ReadFloatAddr(HWND, #0095C890) / 64)
    var fEast = rmstring(HWND, #00A79140, 50)
    var fSouth = rmstring(HWND, #00A79150, 50)
    if(East == fEast && South == fSouth)
        East = East + rnd(0, 5)
        if(East < 0)
            East = 0
        end
        South = South + rnd(0, 5)
        if(South < 0)
            South = 0
        end
    end
    var type = 0
    while(bchwnd > 0)
        if(!combatstate && LoginPreCheck)
            if(checkgetstate("check53"))
                SetSpecialRouteWalk(HWND, East, South)
            else
                select(combogetcursel("combobox7"))
                    case 1
                    if(type == 0)
                        type = 1
                        SetMovement(HWND, East, South - walklen)
                    else
                        type = 0
                        SetMovement(HWND, East, South + walklen)
                    end
                    case 0
                    if(type == 0)
                        type = 1
                        SetMovement(HWND, East - walklen, South)
                    else
                        type = 0
                        SetMovement(HWND, East + walklen, South)
                    end
                end
            end
            bc.Delay(walkdelay)
        else
            bc.Delay(5000)
        end
    end
    checksetstate("check24", false)
    return false
end
//遇敵排除座標
function SetSpecialRouteWalk(HWND, x, y)
    var xarray = array()
    var yarray = array()
    var tmp = walklen
    for(var i = 0; i < walklen * 2 + 1; i++)
        arraypush(xarray, tmp)
        arraypush(yarray, tmp)
        tmp--
    end
    var fEast = rmstring(HWND, #00A79140, 50)
    var fSouth = rmstring(HWND, #00A79150, 50)
    var prex = x + xarray[rnd(0, walklen * 2)]
    var prey = y + yarray[rnd(0, walklen * 2)]
    if(prex != fEast && prey != fSouth && prex != fEast + 1 && prex != fEast - 1 && prey != fSouth + 1 && prey != fSouth - 1)
        SetMovement(HWND, prex, prey)
    else
        return false
    end
end
//進階自走
function AutoWalkEx(HWND)
    while(bchwnd > 0)
        if(!combatstate && LoginPreCheck)
            SetAutoWalkEx(HWND)
            bc.Delay(walkdelay)
        else
            bc.Delay(5000)
        end
    end
    checksetstate("check29", false)
    return false
end
//平時使用補品
var NormalUseItemFlag = false
function SetNormalUseItem(HWND)
    var petpos = GetPetPos(HWND)
    if(GetPercentage(mainHP, mainMAXHP) < editgettext("edit10") && checkgetstate("check43") && mainMAXHP != 0)
        var spot = GetPreitemSpot(3)
        UseItemSuper(HWND, spot, 0)
        if(GetPercentage(mainHP, mainMAXHP) < editgettext("edit10"))
            bc.Delay(1000)
        end
    end
    if(GetPercentage(mainMP, mainMAXMP) < editgettext("edit13") && checkgetstate("check44") && mainMAXMP != 0)
        var spot = GetPreitemSpot(4)
        UseItemSuper(HWND, spot, 0)
        if(GetPercentage(mainMP, mainMAXMP) < editgettext("edit13"))
            bc.Delay(1000)
        end
    end
    if(NormalUseItemFlag)
        if(GetPercentage(pethp[petpos], petmaxhp[petpos]) < editgettext("edit11") && checkgetstate("check43") && petmaxhp[petpos] != 0)
            var spot = GetPreitemSpot(3)
            UseItemSuper(HWND, spot, 0)
            if(GetPercentage(pethp[petpos], petmaxhp[petpos]) < editgettext("edit11"))
                bc.Delay(1000)
            end
        end
        if(GetPercentage(petmp[petpos], petmaxmp[petpos]) < editgettext("edit14") && checkgetstate("check44") && petmaxmp[petpos] != 0)
            var spot = GetPreitemSpot(4)
            UseItemSuper(HWND, spot, 0)
            if(GetPercentage(petmp[petpos], petmaxmp[petpos]) < editgettext("edit14"))
                bc.Delay(1000)
            end
        end
        NormalUseItemFlag = false
    end
end
//讀取地圖座標列表
function GetMapData()
    var mapdata
    var mapinfo = httpgetpage("https://www.lovesa.cc/updates/point.dat", "utf-8")
    var size = strsplit(mapinfo, "\r\n", mapdata)
    var mapdir = array()
    var tmparray = array()
    for(var i = 0; i < size; i++)
        mapdir[i] = array()
        strsplit(mapdata[i], ",", mapdir[i])
        tmparray[i] = array()
        tmparray[i]["地點"] = mapdir[i][3]
        tmparray[i]["坐標"] = strformat("%d,%d", mapdir[i][1], mapdir[i][2])
        if(!isarray(MAPINFO_array[mapdir[i][0]]))
            MAPINFO_array[mapdir[i][0]] = array()
        end
        MAPINFO_array[mapdir[i][0]][i] = tmparray[i]
    end
    arrayclear(mapdir)
    arrayclear(tmparray)
    size = null
    mapinfo = null
    mapdata = null
end
//設置地圖座標列表
function SetMapData(HWND)
    var mapID = GetMapID(HWND)
    if(arraysize(MAPINFO_array[mapID]) <= 0)
        gridsetsize("gridmap", 16, 2)
        for(var i = 0; i < 17; i++)
            if(i != 0)
                gridsetcontent("gridmap", i, 0, "")
                gridsetcontent("gridmap", i, 1, "")
            else
                gridsetcontent("gridmap", i, 0, "地點")
                gridsetcontent("gridmap", i, 1, "坐標")
            end
        end
    else
        gridfillarraydata("gridmap", MAPINFO_array[mapID])
    end
    var r_row, r_col
    gridgetsize("gridmap", r_row, r_col)
    if(r_row < 17)
        r_row = 17
        gridsetsize("gridmap", r_row, r_col)
    end
    for(var i = 0; i < r_row; i++)
        if(i != 0)
            var height = gridgetrowheight("gridmap", i)
            if(height != 18)
                gridsetrowheight("gridmap", i, 18)
            end
        else
            var height = gridgetrowheight("gridmap", i)
            if(height != 20)
                gridsetrowheight("gridmap", i, 20)
            end
        end
        for(var k = 0; k < 2; k++)
            gridsetreadonly("gridmap", i, k)
        end
    end
end
//紀錄足跡
function SetStepRecord(HWND)
    var mapID = GetMapID(HWND)
    if(east != eastsave || south != southsave)
        if(mapID > 0 && mapID < 100000)
            if(!fileexist(".//Record//" & mapID & ".txt"))
                filewriteex(".//Record//" & mapID & ".txt", "", 2)
            end
            fileaddtext(".//Record//" & mapID & ".txt", strformat("%s,%s ", east, south))
        end
    end
end
//加總回合/時間資訊
function SetCombatInfo()
    TotalRound++
    TotalDuration = TotalDuration + int(CombatDuration)
end
//安全密碼
function GetSecurityState(HWND)
    if(bchwnd > 0 && LoginPreCheck && OneTime2)
        var ret = rmstring(HWND, #00C32B61, 100)
        if(ret == AESdecrypt("80655ddc0735c5e72b5165a833e6f9402d43491e67646651272bfafb4fd7d31f"))
            SetSecurtyCodeFree(editgettext("edit12"), 1)
            wmstring(HWND, #00C32B61, 0)
            OneTime2 = false
        end
    end
    return false
end
//生產面板自動點選素材
function SetItemPos(HWND, name, intX, intY)
    //x - 210, y + 45
    var namearray
    var size = strsplit(name, ";", namearray)
    for(var i = 0; i < size; i++)
        var x = intX - 210
        var y = intY + 45
        var n = GetItemPos(namearray[i])
        //traceprint(strformat("%s:%s", n, namearray[i]))
        var nx = 0, ny = 0
        if(n >= 0 && n < 5)
            nx = n
            ny = 0
        elseif(n >= 5 && n < 10)
            nx = (n - 5)
            ny = 1
        elseif(n >= 10 && n < 15)
            nx = (n - 10)
            ny = 2
        elseif(n >= 15 && n < 20)
            nx = (n - 15)
            ny = 3
        elseif(n == -1)
            PushAnnounce(HWND, strformat("<製造>材料 %s 不足", namearray[i]))
            return false
        end
        var gx = x + nx * 50
        var gy = y + ny * 50
        bc.MoveTo(gx, gy)
        bc.LeftDoubleClick()
        press("runpro", 1)
    end
    return true
end
//判斷鎖定地圖
function GetMapLockInfo(HWND)
    if(arraysize(maplock) > 0)
        var map = GetMap(HWND)
        for(var i = 0; i < arraysize(maplock); i++)
            if(maplock[i] == map)
                return true
            end
        end
        checksetstate("check24", false)
        checksetstate("check29", false)
        threadclose(AutoWalkID, 1)
        threadclose(AutoWalkExID, 1)
        wmdata(HWND, #00462EA2, AESdecrypt("98cdc4feff2f09851447efa1863f836a"))
    end
end
//異常條件
function SetAbnormal(HWND)
    if(Abnormal)
        if(checkgetstate("check55"))
            if(GetPercentage(mainHP, mainMAXHP) < HPLIMIT)
                AbnormalAction(HWND, 0)
            end
        elseif(checkgetstate("check56"))
            if(GetPercentage(mainMP, mainMAXMP) < MPLIMIT)
                AbnormalAction(HWND, 1)
            end
        elseif(checkgetstate("check57"))
            if(GetTeamCount(HWND) < GROUPLIMIT)
                AbnormalAction(HWND, 2)
            end
        elseif(checkgetstate("check58"))
            if(NormalDuration / 60 > NORMALLIMIT)
                AbnormalAction(HWND, 3)
            end
        elseif(checkgetstate("check59"))
            if(CombatDuration / 60 > COMBATLIMIT)
                AbnormalAction(HWND, 4)
            end
        elseif(checkgetstate("check60"))
            if(GetBackpackState(0, 0, 1) == 1)
                AbnormalAction(HWND, 5)
            end
        end
    end
end
//觸發異常條件提示
function AbnormalAnnounce(HWND, type, content = "")
    select(type)
        case 0
        PushAnnounce(HWND, strformat("<異常設定>血量低於 %d ％ %s", HPLIMIT, content))
        case 1
        PushAnnounce(HWND, strformat("<異常設定>魔力低於 %d ％ %s", MPLIMIT, content))
        case 2
        PushAnnounce(HWND, strformat("<異常設定>隊伍人物少於 %d 人 %s", GROUPLIMIT, content))
        case 3
        PushAnnounce(HWND, strformat("<異常設定>平時超時 %d 分鐘 %s", NORMALLIMIT, content))
        NormalTickCount = bc.GetTime()
        case 4
        PushAnnounce(HWND, strformat("<異常設定>戰鬥超時 %d 分鐘 %s", COMBATLIMIT, content))
        case 5
        PushAnnounce(HWND, "<異常設定>道具欄滿")
    end
end
//異常條件觸發動作
function AbnormalAction(HWND, type)
    var tmp = false
    var content = ""
    if(checkgetstate("check61"))
        tmp = true
        checksetstate("check27")
        content = "自動逃跑"
    end
    if(checkgetstate("check62"))
        tmp = true
        checksetstate("check24", false)
        checksetstate("check29", false)
        threadclose(AutoWalkExID, 1)
        threadclose(AutoWalkID, 1)
        wmdata(HWND, #00462EA2, AESdecrypt("98cdc4feff2f09851447efa1863f836a"))
        threadbegin("SetMovementEx", array(east, south, HWND))
        content = strformat("%s 停止遇敵", content)
    end
    if(checkgetstate("check63"))
        tmp = true
        AbnormalAnnounce(HWND, type)
        Abnormal = false
        threadbegin("restoreAbnormal", null)
        LogOut(HWND)
        return false
    end
    if(checkgetstate("check64"))
        tmp = true
        ReturnBase(HWND)
        content = strformat("%s 回記錄點", content)
    end
    if(checkgetstate("check65") && ScriptOnOff)
        tmp = true
        SetScripStop()
        bc.Delay(100)
        gridsetfocusitem("gridscript", 1, 1)
        ScriptProcessID = threadbegin("ScriptProcess", array(HWND, 1))
        bc.Delay(100)
        if(threadgetstatus(ScriptProcessID))
            controlenable("button22", true)
            controlenable("button23", true)
            controlenable("button21", false)
            ScriptOnOff = true
        end
        content = strformat("%s 重行腳本", content)
    end
    if(tmp)
        AbnormalAnnounce(HWND, type, content)
        Abnormal = false
        threadbegin("restoreAbnormal", null)
    end
end
//暫停並初始化異常檢測條件
function restoreAbnormal()
    bc.Delay(60000)
    NormalTickCount = bc.GetTime()
    Abnormal = true
end
//檢測黑名單
function DetectDangerHuman(HWND)
    if(checkgetstate("check66"))
        var TmpHumanName = array()
        if(LoginPreCheck && HWND > 0)
            var tmp = array("GM", "Game", "Master", "GameMaster", "管理員", "gm")
            TmpHumanName = traverse(HWND, #0059924C, 60, #13C, 3, 100)
            if(isarray(TmpHumanName))
                for(var i = 0; i < arraysize(preHumanName); i++)
                    if(preHumanName[i] != "" && preHumanName[i] != " ")
                        for(var j = 0; j < 60; j++)
                            if(TmpHumanName[j] != "" && TmpHumanName[j] != " ")
                                if(strfind(TmpHumanName[j], preHumanName[i]) != -1)
                                    DangerHumanAction(HWND)
                                    return false
                                end
                            end
                        end
                    end
                end
                if(checkgetstate("check67"))
                    for(var i = 0; i < 7; i++)
                        for(var j = 0; j < 60; j++)
                            if(TmpHumanName[j] != "" && TmpHumanName[j] != " ")
                                if(strfind(TmpHumanName[j], tmp[i]) != -1)
                                    DangerHumanAction(HWND)
                                    return false
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
//黑名單動作
function DangerHumanAction(HWND)
    var sel = combogetcursel("combobox9")
    LogOut(HWND)
    traverseclear(HWND, #0059924C, 60, #13C)
    if(sel == 0)
        checksetstate("check0", false)
        checksetstate("check4", false)
    elseif(sel == 1)
        var tmp = combogetcursel("combobox0")
        if(tmp == 4)
            combosetcursel("combobox0", 0)
        else
            combosetcursel("combobox0", tmp + 1)
        end
        ComboServer()
        combosetcursel("combobox1", 0)
    end
    sel = null
end
//自動排列窗口
function SetWindowArrange()
    var sort = 0
    var result = bc.EnumWindowByProcess("bluecg.exe", null, "Blue", 2)
    var tmp = array()
    var size = strsplit(result, ",", tmp)
    if(isarray(tmp))
        for(var i = 0; i < size; i++)
            bc.SetWindowState(int(tmp[i]), 7)
            bc.SetWindowState(int(tmp[i]), 1)
            select(sort)
                case 0
                bc.MoveWindow(int(tmp[i]), 0, 0)       
                sort++
                case 1
                bc.MoveWindow(int(tmp[i]), 641, 0)
                sort++
                case 2
                bc.MoveWindow(int(tmp[i]), 1281, 0)
                sort++
                case 3
                bc.MoveWindow(int(tmp[i]), 0, 508)
                sort++
                case 4
                bc.MoveWindow(int(tmp[i]), 641, 508)
                sort++
                case 5
                bc.MoveWindow(int(tmp[i]), 1281, 508)
                sort = 0
            end
        end
    end
end