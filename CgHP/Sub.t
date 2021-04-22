//DLL註冊與資源擋案自動更新
function RegDll(HWND)
    sleep(1000, false)
    UpdaterExe()
    SetStatus(13)
    //
    bc.SetPath(rc)
    bc.SetDictPwd(AESdecrypt("bda4947e8998e453c1441faba0a21d02"))
    bc.SetDict(0, "bc.soft")
    bc.DmGuard(1, "memory2")
    //
    bc.SetWindowText(HWND, "CgHP - Beta " & CgHPver)
    cmd(rc & "tmpclean.bat", false)//清除TEMP檔案
    threadbegin("RunCgStairFinder", null)
    if(isregister("lw.lwsoft3.1"))//樂玩
        lw = com("lw.lwsoft3.1")
        traceprint(lw.ver())
    else
        regdll(rc & "lwHook.dll", true)
        if(isregister("lw.lwsoft3.1"))
            lw = com("lw.lwsoft3.1")
            traceprint(lw.ver())
        else
            msgbox(AESdecrypt("28e90d3c381341601b1926fb8e7624036f5016b35dc38b3099f8959c6aea59e2"), 4)
            return TerminateProcess(GetCurrentProcess())
        end
    end
    if(isregister("DL2.CStar"))//A*(C*)
        mf = com("DL2.CStar")
        traceprint(mf.Ver())
    else
        regdll(rc & "DL_Cstar2.dll", true)
        if(isregister("DL2.CStar"))
            mf = com("DL2.CStar")
            traceprint(mf.Ver())
        else
            msgbox(AESdecrypt("28e90d3c381341601b1926fb8e762403505688e3850cadc743e96ef5f4b67ff0"), 4)
            return TerminateProcess(GetCurrentProcess())
        end
    end
    //
    SetGamePath()
    timerregister("timer0", 1000)
    ALLREGSTATE = true//bcreg
    SetStatus(12)
    controlenable("button0", true)
    windowactivate(HWND)
end
//設置遊戲目錄
function SetGamePath()
    bcpath = filereadini("CgHP", "GamePath", ".\\Resource\\System.ini")
    if(bcpath == "")
        SetStatus(15)
        bcpath = filedialog(2)
        if(bcpath != "")
            if(fileexist(bcpath & "/bluecg.exe"))
                filewriteini("CgHP", "GamePath", bcpath, ".\\Resource\\System.ini")
                ClearGameDat()
            else
                msgbox("所選擇的資料夾錯誤，找不到檔案 bluecg.exe")
                filewriteini("CgHP", "GamePath", "", ".\\Resource\\System.ini")
                sleep(100, false)
                TerminateProcess(GetCurrentProcess())
            end
        else
            msgbox("請選擇正確的魔力寶貝目錄")
            sleep(100, false)
            TerminateProcess(GetCurrentProcess())
        end
    else
        if(fileexist(bcpath & "/bluecg.exe"))
            ClearGameDat()
        else
            msgbox("所選擇的資料夾錯誤，找不到檔案 bluecg.exe")
            filewriteini("CgHP", "GamePath", "", ".\\Resource\\System.ini")
            sleep(100, false)
            TerminateProcess(GetCurrentProcess())
        end
    end
end
//主程式自動更新
var webreg = false
function UpdaterExe()
    webreg = InitDllW(AESdecrypt("3394e8ad7e2dc6b727209c07f6577d7053861fa86eb0f28b549d01756a9541ac"), "水藍小幫手")
    if(!webreg)
        var tmp = AESdecrypt(httpgetpage("https://www.lovesa.cc/updates/mac.spp", "utf-8"))
        var tmparray = array()
        var size = strsplit(tmp, "\r\n", tmparray)
        for(var i = 0; i < size; i++)
            if(tmparray[i] != "")
                var size2 = strsplit(tmparray[i], "=", WebInformation)
                for(var j = 0; j < size2; j++)
                    if(WebInformation[1] == bc.GetMachineCodeNoMac())
                        if(timediff("s", bc.GetNetTime(), WebInformation[2]) < 0)
                            SetAnnoy()
                            return TerminateProcess(GetCurrentProcess()) 
                        end
                        return false
                    end
                end
            end
        end
        tmp = null
        bc.SetClipboard(bc.GetMachineCodeNoMac())
        msgbox(strformat("%s\r\n已將機器碼(%s)複製到剪貼版，多次出現此問題請至帳務區提出特殊通道申請，小幫手將自動關閉。", AESdecrypt("93d2732dad79612a5efac7fc77f560126f83df00ce9e0f2bd7aa3ca4f0330f1f58bb276a6d0928fa96e00ba512443b4b"), bc.GetMachineCodeNoMac()), 4)
        openprocessex("https://lovesa.cc/forum.php?mod=forumdisplay&fid=60", "")
        return TerminateProcess(GetCurrentProcess()) 
    end
    ////////////更新//////////////////
    UpdateFileExW(SubCgHPver, 1)
    //////////////////////////////////
end
//啟動遊戲
function RunGame()
    var path = strformat("%s%s", sysgetpath(5), AESdecrypt("c755146240cc7313e500fa67f1d07839"))
    var content = httpgetpage("https://www.lovesa.cc/updates/command.dat", "utf-8")//filereadex(rc & "mode0.dat")
    var setcontent = strformat("@echo off\r\ncd %s\r\n%s", bcpath, AESdecrypt(content))
    filewriteex(path, setcontent)//寫.bat
    SetStatus(0)
    if(cmd(path, false))//Run .bat
        bc.Delay(3000)
        while(bchwnd == 0)
            bc.Delay(100)
            bchwnd = windowfind("Blue", "Blue")
            var HWND = bchwnd
            g_hwnd = bchwnd
            if(bc.GetWindowState(HWND, 0))
                //traceprint("魔力 HWND :::: " & bchwnd)
                //SetStatus(8)
                var bindva = bc.BindWindowEx(HWND, "dx.graphic.2d.2", "dx2", "dx", "dx.public.down.cpu", 0)
                if(bindva)
                    GetHexAddr()
                    submainID = threadbegin("submain", HWND)
                    mainID = threadbegin("main", HWND)
                    SetStatus(12)
                    break
                else
                    arrayclear(content)
                    filedelete(path)
                    bc.SetWindowState(HWND, 0)
                end
            end
        end
    end
    arrayclear(content)
    filedelete(path)
    content = null
    setcontent = null
    path = null
end
//尋找並關閉互斥體
function FindMutant(HWND)
    var rett = lw.SetMemoryProcess(HWND, 1)//插件內存功能初始化
    var PID = information(HWND, 5)
    var CloseMutant_array = array()
    var obj = lw.objEnum()//枚舉
    var size = strsplit(obj, ",", CloseMutant_array)
    var objType = array()
    var objName = array()
    var objtmp = array()
    //
    for(var i = 0; i < size; i++)//設置內核對象名稱句柄數組
        objType[i] = lw.objGetType(CloseMutant_array[i]) 
        if(objType[i] == "Mutant")//指定Mutant互斥體
            arraypush(objName, lw.objGetName(CloseMutant_array[i]))
            arraypush(objtmp, CloseMutant_array[i])
        end
    end
    var namearray = array()
    for(var i = 0; i < 180; i++)//設置排除對象名單
        for(var j = 0; j < 20; j++)
            namearray[i] = "\\Sessions\\" & j & "\\BaseNamedObjects\\MidiMapper_modLongMessage_RefCnt"
            i++
            namearray[i] = "\\Sessions\\" & j & "\\BaseNamedObjects\\DirectMusicMasterClockMutex"
            i++
            namearray[i] = "\\Sessions\\" & j & "\\BaseNamedObjects\\DirectSound Administrator shared thread array(lock"
            i++
            namearray[i] = "\\Sessions\\" & j & "\\BaseNamedObjects\\DDrawDriverObjectListMutex"
            i++
            namearray[i] = "\\Sessions\\" & j & "\\BaseNamedObjects\\DDrawWindowListMutex"
            i++
            namearray[i] = "\\Sessions\\" & j & "\\BaseNamedObjects\\__DDrawCheckExclMode__"
            i++
            namearray[i] = "\\Sessions\\" & j & "\\BaseNamedObjects\\__DDrawExclMode__"
            i++
            namearray[i] = "\\Sessions\\" & j & "\\BaseNamedObjects\\SM0:" & PID & ":168:WilStaging_02"
            i++
            namearray[i] = "\\Sessions\\" & j & "\\BaseNamedObjects\\SM0:" & PID & ":64:WilError_03"
        end
    end
    var caddr = array()
    for(var k = 0; k < arraysize(objName); k++)
        var value = arrayfindvalue(namearray, objName[k])
        if(value == "" && objtmp[k] != "" && objtmp[k] > 0 && strlen(objName[k]) > 2)
            arraypush(caddr, objtmp[k])
        end
    end
    var E = 0
    for(var l = 0; l < arraysize(caddr); l++)
        if(!lw.objClose(caddr[l]))//使用插件Closehandle
            if(CloseHandle(HWND, caddr[l])) //使用遊戲Closehandle
                E++
            end       
        else
            E++
        end 
    end
    if(E == arraysize(caddr))
        bc.SetWindowText(bchwnd, bc.GetWindowTitle(bchwnd) & AESdecrypt("5a781d66d20cd0b5b8265d5a9e5bcc71c1f4856e84913df337973517e9d31d90"))
    else
        bc.SetWindowText(bchwnd, bc.GetWindowTitle(bchwnd) & AESdecrypt("f0034a51243aa2bd755f66f8b03f70db51db5be3e96bedc62491e03cdc5efb0c"))
    end
    arrayclear(caddr)
    arrayclear(namearray)
    arrayclear(objtmp)
    arrayclear(objName)
    arrayclear(objType)
    arrayclear(CloseMutant_array)
end
//啟動找樓梯程式
function RunCgStairFinder()
    StairProcesshandle = openprocess(AESdecrypt("aa14195e93f0084d183ee0462f1f67970e252cebd1edcc22df05ee772ce36948"))
    waitfor(StairProcesshandle, 10000)
    sleep(1000, false)
    StairFinderHwnd = getwndhwnd(StairProcesshandle)
    //traceprint("StairHwnd::" & StairFinderHwnd)
    if(StairFinderHwnd > 0)//嵌入本進程
        dllcall("user32.dll", "int", "SetParent", "int", StairFinderHwnd, "int", tabgetpagehandle("tab0", 1))
        SetWindowLongA(StairFinderHwnd, #0)
        bc.MoveWindow(StairFinderHwnd, 0, 8)
        windowsettop(StairFinderHwnd)
    end
end