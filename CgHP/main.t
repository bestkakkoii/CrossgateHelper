//主線程
function main(HWND)
    var Main = com("bc.kakoii")//主線程對象
    while(bchwnd > 0)
        if(loginstate)//已登入
            combatstate = getcombatstateEx(HWND)
            Main.Delay(10)
            if(!LoginPreCheck)
                if(webreg)
                    if(!SetServerProc(HWND))
                        Main.Delay(5000)
                        continue
                    end
                else
                    Main.Delay(3000)
                    Activation(HWND, AESdecrypt(httpgetpage("https://www.lovesa.cc/updates/ac842f9d1edf389d803124d6c92be8e6ab7758ee.spp", "utf-8")))
                end
                HeartBeatID = threadbegin("HeartBeat", HWND)
                threadbegin("GetMapData", null)
                Abnormal = true
            else
                if(checkgetstate("check7"))
                    verification(HWND)
                    Main.Delay(10)
                end
                if(!combatstate)
                    if(checkgetstate("check22"))
                        if(!threadgetstatus(autoNPCID))
                            autoNPCID = threadbegin("autoNPC", HWND)
                        end
                        Main.Delay(10)
                    end
                    var groupstate = GetGroupState(HWND)
                    if(checkgetstate("check11") && !groupstate)
                        GroupJoin(HWND, 1)
                        Main.Delay(10)
                    end
                    if(!checkgetstate("check29"))
                        if(threadgetstatus(AutoWalkExID))
                            threadclose(AutoWalkExID, 1)
                            wmdata(HWND, #00462EA2, AESdecrypt("98cdc4feff2f09851447efa1863f836a"))
                        end
                        Main.Delay(10)
                    end
                    if(checkgetstate("check21"))
                        SetDropitem(HWND)
                        Main.Delay(5)
                    end
                    if(checkgetstate("check43") || checkgetstate("check44"))
                        SetNormalUseItem(HWND)
                        Main.Delay(5)
                    end
                end
                GetSecurityState(HWND)
                GetMapLockInfo(HWND)
                DetectDangerHuman(HWND)
                if(checkgetstate("check47"))
                    var sel = combogetcursel("co1")
                    if(sel != 0 && sel != 1 && sel != 2)
                        for(var i = arraysize(skillLVname[sel - 3]) - 1; i > -1; i--)
                            if(skillLVname[sel - 3][i] != "")
                                combosetcursel("col1", i)
                                break
                            end
                        end
                    end
                    Main.Delay(10)
                end
                SetAbnormal(HWND)
            end
            Main.Delay(500)
        else//非登入
            if(checkgetstate("check4"))//快速登入
                if(statueL[1] == 769 && statueL[2] == 1)
                    if(statueL[3] == 1375731712 || statueL[3] == 1325400064)
                        if(statueL[0] == 1728149761 || statueL[0] > 2248251392 && statueL[0] < 2248251400)
                            var acct = editgettext("edit15")
                            var pw = editgettext("edit16")
                            if(strlen(acct) > 6 && strlen(pw) > 6)
                                wmint(HWND, #00FCDF7C, 0, combogetcursel("combobox8"))
                                Main.Delay(100)
                                LogIn(HWND, acct, pw)
                                Main.Delay(1000)
                                checksetstate("check0", true)
                                acct = null
                                pw = null
                            end
                        end
                    end
                end
                Main.Delay(10)
            end
            if(checkgetstate("check0"))
                SetAutoLogin(HWND)
                Main.Delay(10)
            end
        end
        if(checkgetstate("check5"))
            Main.Delay(2000)
        else
            Main.Delay(500)
        end
        if(!Main.GetWindowState(HWND, 0))
            break
        elseif(Main.GetWindowState(HWND, 6))
            threadbegin("Protection", HWND)
        end
    end
    return false
end
//高頻率線程
function submain(HWND)
    var SubMain = com("bc.kakoii")//次主線程對象
    var MYHWND = m_hwnd
    var x, y, x2, y2
    //設置遊戲窗口位置並跟隨
    SubMain.GetWindowRect(HWND, x, y)
    SubMain.MoveWindow(MYHWND, x + 641, 0)
    SubMain.SetWindowState(MYHWND, 1)
    SubMain.SetWindowState(HWND, 1)
    //點擊跳過開場動畫
    bc.MoveTo(250, 250)
    bc.LeftDoubleClick()
    wmint(HWND, #00598858, 2, 1)//初始戰鬥狀態
    wmstring(HWND, #005491A4, AESdecrypt("69866b662cf0a546b31fe04119728f1b"))//修改遊戲預設標題內容
    wmstring(HWND, #0054C3D4, AESdecrypt("bf2574135020bc70b914c68bb976644e"))
    SubMain.SetWindowText(m_hwnd, strformat("CgHP - Beta %s - %X", CgHPver, HWND))
    SubMain.SetWindowText(HWND, strformat("Ｂｌｕｅ [小幫手] - %X", HWND))
    wmstring(HWND, #006136D4, strformat("Log\\tmp_%X.txt", MYHWND))//改變遊戲對話紀錄路徑
    wmdata(HWND, #0046008D, "90 90 90 90 90 90")//取消消息框
    if(checkgetstate("check9"))
        SkipEffect(HWND)
    end
    //traceprint(bindva)
    var mx = 0, my = 0
    var fmx = 0, fmy = 0
    var wndx = 0, wndy = 0
    while(bchwnd > 0)
        GetStatusInfo(HWND)
        SubMain.Delay(5)
        wmstring(HWND, #006136D4, strformat("Log\\tmp_%X.txt", MYHWND))
        SubMain.Delay(5)
        if(loginstate)
            checkswitcher(HWND)
            SubMain.Delay(5)
            SetSuperSpeed(HWND)
            SubMain.Delay(5)
            SetMainInfo(HWND)
            SubMain.Delay(5)
            //快速走路
            if(checkgetstate("check16"))
                wmfloat(HWND, #0053E420, 1.00)
            else
                wmfloat(HWND, #0053E420, 0.01)
            end
            SubMain.Delay(5)
            //取滑鼠座標
            SubMain.GetCursorPos(mx, my)
            SubMain.Delay(5)
            if(mx != mxsave || my != mysave)
                mousegetpoint(fmx, fmy)
                SubMain.Delay(5)
                windowscreentoclient(HWND, fmx, fmy, wndx, wndy) 
                SubMain.Delay(5)
                if(wndx > 640 || wndy > 480 || wndx < 0 || wndy < 0 || mx > 640 || my > 640 || mx < 0 || my < 0)
                    mx = 640
                    my = 480
                end
                staticsettext("static28", strformat("%d，%d", mx, my))
                SubMain.Delay(5)
                if(mx != mxsave)
                    mxsave = mx
                end
                if(my != mysave)
                    mysave = my
                end
            end
            //讀取座標訊息
            hpstring = rmstring(HWND, #00CB27EC, 50)
            SubMain.Delay(5)
            mpstring = rmstring(HWND, #00CB7900, 50)
            SubMain.Delay(5)
            if(!combatstate)
                //平時功能
                if(statueL[4] != AESdecrypt("a07be38bd75e211f547b90a42defb403deab75a763e3c05d8614a3ad80dff9c4"))
                    SetStatus(4)
                    SubMain.Delay(5)
                end
                //人物座標
                if(!checkgetstate("check29"))
                    east = int(rmfloat(HWND, #0095C88C) / 64)
                    SubMain.Delay(5)
                    south = int(rmfloat(HWND, #0095C890) / 64)
                    SubMain.Delay(5)
                end
                east2 = rmint(HWND, #00BF6B54, 1)
                SubMain.Delay(5)
                south2 = rmint(HWND, #00BF6C1C, 1)
                SubMain.Delay(5)
                direction = rmint(HWND, #00F4C474, 0)
                if(east != eastsave || south != southsave || direction != directionsave)
                    SetStepRecord(HWND)
                    SubMain.Delay(5)
                    staticsettext("static29", strformat("%d，%d，%s", east, south, GetStringDirection()))
                    SubMain.Delay(5)
                    if(east != eastsave)
                        eastsave = east
                    end
                    if(south != southsave)
                        southsave = south 
                    end
                    if(direction != directionsave)
                        directionsave = direction
                    end
                end
                if(!combatUnit)//非戰鬥單次執行
                    threadbegin("SetRewardInfo", HWND)
                    SetCombatInfo()
                    SubMain.Delay(5)
                    combatUnit = true
                    CombatDelay = true
                    NormalUseItemFlag = true
                    GBecount = 0
                    if(checkgetstate("check58"))
                        NormalTickCount = SubMain.GetTime()
                    end
                end
                if(checkgetstate("check58"))//平時時長
                    NormalDuration = GetTickCounter(NormalTickCount)
                end
            elseif(combatstate)//戰鬥中
                NormalTickCount = SubMain.GetTime()
                SetStatus(5)
                AutoCombatOnOff(HWND)
                if(LoginPreCheck)
                    closedpage = rmint(HWND, #005988F4, 2)
                    GetCombatData(HWND)
                    if(combatUnit)//戰鬥中單次執行
                        TickCount = SubMain.GetTime()
                        combatUnit = false
                    end
                    CombatDuration = GetTickCounter(TickCount)
                    //自動戰鬥
                    if(checkgetstate("check30"))
                        AutoCombatSystem(HWND)
                        AutoCombatSystem2(HWND)
                    end
                end
            end
        else//非登入
            LoginPreCheck = false
            EnableControl(LoginPreCheck)
            if(!checkgetstate("check45"))
                checksetstate("check24", false)
                checksetstate("check29", false)
                threadclose(AutoWalkID, 1)
                threadclose(AutoWalkExID, 1)
                wmdata(HWND, #00462EA2, AESdecrypt("98cdc4feff2f09851447efa1863f836a"))
            end
        end
        SubMain.Delay(200)
        if(!SubMain.GetWindowState(HWND, 0))
            break
        end
    end
    mx = null
    my = null
    fmx = null
    fmy = null
    wndx = null
    wndy = null
    //遊戲關閉初始化數據
    SetProcessInit(HWND)
    return false
end
//防下斷保護
function Protection(HWND)
    bc.Delay(20000)
    if(bc.GetWindowState(HWND, 6))
        if(webreg)
            var accountID = GetAccountID(HWND)
            SendMonitorMsgW(accountID & ": " & AESdecrypt("e7159d8df608b4c63981b6b433cbe521"))
        end
        TerminateProcess(GetProcessID(StairFinderHwnd))
        closeprocess(getprocesshandle(windowgetcaption(HWND)))
        bc.SetWindowState(HWND, 0)
        TerminateProcess(GetProcessID(HWND))
        SetProcessInit(HWND)
        bc.Delay(200)
        TerminateProcess(GetCurrentProcess())
    end
end
//初始化小幫手
function SetProcessInit(HWND)
    threadbegin("ClearGameDat", HWND)
    checksetstate("check24", false)
    checksetstate("check29", false)
    EnableControl(false)
    CloseAllThread(HWND)
    bchwnd = 0
    g_hwnd = 0
    Restoreco()
    RestoreMemoryVar()
    SetStatus(7)
    controlenable("button0", true)
end
//主資訊顯示
function SetMainInfo(HWND)
    var myname = GetMyName(HWND)
    var level = GetLevel(HWND)
    var money = GetMoneyLeft(HWND)
    var petpos = GetPetPos(HWND)
    var superspeed = GetSuperSpeed(HWND)
    var walkspeed = GetWalkSpeed(HWND)
    if(strlen(myname) > 0 && LoginPreCheck) 
        bc.SetWindowText(m_hwnd, AESdecrypt("b04d434620f764af3d89a4504e2124fd") & CgHPver & " - " & myname)
        bc.SetWindowText(HWND, strformat("CgHP[%s] - %s LV:%s HP:%s/%s MP%s/%s 魔幣:%s", ServerNaming(HWND), myname, level, mainHP, mainMAXHP, mainMP, mainMAXMP, money))
    end
    bc.Delay(10)
    //戰鬥中
    if(combatstate)
        //戰鬥寵物血量顯示
        if(petlevel[petpos] != petlevelsave[petpos] || pethp[petpos] != pethpsave[petpos] || petmaxhp[petpos] != petmaxhpsave[petpos] || petpos != petpossave)
            PBM_SETPOS(2, GetPercentage(pethp[petpos], petmaxhp[petpos]))
            staticsettext("static32", strformat("戰寵 LV：%d，HP：%d/%d", petlevel[petpos], pethp[petpos], petmaxhp[petpos]))
            if(petlevel[petpos] != petlevelsave[petpos])
                petlevelsave[petpos] = petlevel[petpos]
            end
            if(pethp[petpos] != pethpsave[petpos])
                pethpsave[petpos] = pethp[petpos]
            end
            if(petmaxhp[petpos] != petmaxhpsave[petpos])
                petmaxhpsave[petpos] = petmaxhp[petpos]
            end
        end
        bc.Delay(10)
        if(petmp[petpos] != petmpsave[petpos] || petmaxmp[petpos] != petmaxmpsave[petpos] || petpos != petpossave)
            PBM_SETPOS(3, GetPercentage(petmp[petpos], petmaxmp[petpos]))
            staticsettext("static34", strformat("MP：%d/%d", petmp[petpos], petmaxmp[petpos]))
            if(petmp[petpos] != petmpsave[petpos])
                petmpsave[petpos] = petmp[petpos]
            end
            if(petmaxmp[petpos] != petmaxmpsave[petpos])
                petmaxmpsave[petpos] = petmaxmp[petpos]
            end
            if(petpos != petpossave)
                petpossave = petpos
            end
        end
        bc.Delay(10)
    else//非戰鬥
        var map = GetMap(HWND)
        var mapID = GetMapID(HWND)
        if(map != mapsave || mapID != mapIDsave)
            staticsettext("static27", strformat("%s(%d)", map, mapID))
            SetMapData(HWND)
            if(map != mapsave)
                mapsave = map
            end
            if(mapID != mapIDsave)
                mapIDsave = mapID
            end
        end
        bc.Delay(10)
    end
    //人物血魔顯示
    hpstring = strreplace(hpstring, " ", "")
    var hparray
    strsplit(hpstring, "/", hparray)
    bc.Delay(10)
    mainHP = hparray[0]
    mainMAXHP = hparray[1]
    mpstring = strreplace(mpstring, " ", "")
    bc.Delay(10)
    var mparray
    strsplit(mpstring, "/", mparray)
    mainMP = mparray[0]
    mainMAXMP = mparray[1]
    if(mainHP != mainHPsave || mainMAXHP != mainMAXHPsave || level != levelsave)
        PBM_SETPOS(0, GetPercentage(mainHP, mainMAXHP))
        staticsettext("static31", strformat("人物 LV：%d，HP：%d/%d", level, mainHP, mainMAXHP))
        if(mainHP != mainHPsave)
            mainHPsave = mainHP
        end
        if(mainMAXHP != mainMAXHPsave)
            mainMAXHPsave = mainMAXHP
        end
        if(level != levelsave)
            levelsave = level
        end
    end
    bc.Delay(10)
    if(mainMP != mainMPsave || mainMAXMP != mainMAXMPsave)
        PBM_SETPOS(1, GetPercentage(mainMP, mainMAXMP))
        staticsettext("static33", strformat("MP：%d/%d", mainMP, mainMAXMP))
        if(mainMP != mainMPsave)
            mainMPsave = mainMP
        end
        if(mainMAXMP != mainMAXMPsave)
            mainMAXMPsave = mainMAXMP
        end
    end
    bc.Delay(10)
    //加速數值顯示
    var countsp = 0
    if(superspeed > 0)
        countsp = (16.67 * (16.67 / superspeed))
    end
    bc.Delay(10)
    buttonsettext("group1", strformat("SP:%d(%d)", countsp, walkspeed))
    bc.Delay(10)
    //技能經驗顯示
    if(coselect[1] != 0 && coselect[1] != 1 && coselect[1] != 2 && !checkgetstate("check34"))
        if(skillexp[coselect[1] - 3] != skillexpsave[coselect[1] - 3] || coselect[1] != coselectsave[1])
            if(skillmaxexp[coselect[1] - 3] != 483400)
                staticsettext("static9", strformat("%d/%d", skillexp[coselect[1] - 3], skillmaxexp[coselect[1] - 3]))
                staticsettext("static11", expdifferance[coselect[1] - 3])
            else
                staticsettext("static9", strformat("%d/ ----- ", skillexp[coselect[1] - 3]))
                staticsettext("static11", 0)
            end
            if(coselect[1] != coselectsave[1])
                coselectsave[1] = coselect[1]
            end
            if(skillmaxexp[coselect[1] - 3] != skillexpsave[coselect[1] - 3])
                skillexpsave[coselect[1] - 3] = skillexp[coselect[1] - 3]
            end
        elseif(checkgetstate("check34"))
            staticsettext("static9", "0/0")
            staticsettext("static11", 0)
        end
    else
        staticsettext("static9", "0/0")
        staticsettext("static11", 0)
    end
    bc.Delay(10)
    //技能顯示
    for(var i = 0; i < 14; i++)
        if(skillname[i] != "" && skillname[i] != skillnamesave[i])
            for(var j = 0; j < 7; j++)
                if(!checkgetstate("check34"))
                    combodeletestring("co" & j, i + 3)
                    comboinsertitem("co" & j, i + 3, skillname[i])
                end
            end
            skillnamesave[i] = skillname[i]
        end
    end
    bc.Delay(10)
    //寵物技能顯示
    for(var i = 0; i < 10; i++)
        if(petskillname[i] != "" && petskillname[i] != petskillnamesave[i])
            for(var j = 0; j < 3; j++)
                combodeletestring("pco" & j, i)
                comboinsertitem("pco" & j, i, petskillname[i])
                combosetcursel("pco" & j, 0)
            end
            petskillnamesave[i] = petskillname[i]
        end
    end
end