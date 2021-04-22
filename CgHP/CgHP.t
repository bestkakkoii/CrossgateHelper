//初始化
function CgHP_init()
    m_hwnd = windowgetmyhwnd()
    var HWND = m_hwnd
    rc = strformat("%s%s", sysgetpath(5), "CgHP/")
    //創建主菜單
    SetMenu(AESdecrypt("f99169451ab79d69577fcf56dbf4a571"), AESdecrypt("a203decbf2dfe59f55ad8f4421fcd75e1975f52820d267ac1edcc52c7a31b42e54ddbf7f67036f5d6a8eb4b14145b818f6f758189bc96990280c2169caf530304ad3cf77d4f02fb255ccebe463b3176d"))
    SetThemeAppProperties()
    SetTargetArray()
    //SET STYLE
    init(HWND)
    //創建進度條
    barhwnd[0] = msctls_progress32(HWND, 2, 2, 175, 20, 0, "static31")
    barhwnd[1] = msctls_progress32(HWND, 180, 2, 175, 20, 1, "static33")
    barhwnd[2] = msctls_progress32(HWND, 2, 24, 175, 20, 0, "static32")
    barhwnd[3] = msctls_progress32(HWND, 180, 24, 175, 20, 1, "static34")
    //創建滾動條(UPDOWN)
    scrollhwnd[0] = CreateScrollbar(HWND, 110, 100)
    scrollhwnd[1] = CreateScrollbar(HWND, 110, 125)
    scrollhwnd[2] = CreateScrollbar(HWND, 135, 115)
    scrollhwnd[3] = CreateScrollbar(HWND, 135, 135)
    scrollhwnd[4] = CreateScrollbar(HWND, 135, 155)
    scrollhwnd[5] = CreateScrollbar(HWND, 135, 175)
    scrollhwnd[6] = CreateScrollbar(HWND, 135, 195)
    windowsetsize(HWND, 360, 538)
    windowsetpos(HWND, 641, 0)
    windowhide(controlgethandle("static50"))
    for(var i = 0; i < 2; i++)
        windowhide(controlgethandle("rb" & i))
        windowhide(controlgethandle("re" & i))
    end
    if(!fileexist("./AccountSetting"))
        foldercreate("./AccountSetting")
    end
    if(!fileexist("./Record"))
        foldercreate("./Record")
    end
    SetStatus(11)
    //資源更新
    var content = httpgetpage("https://www.lovesa.cc/updates/version.txt", "utf-8")
    var precontent = filereadini("CgHP", "version", ".\\Resource\\System.ini")
    if(precontent != content || precontent == "")
        updateflag = true
        controldomodal("Updater")
    end
    //大漠插件免註冊
    var result = dllcall(rc & "bcReg.dll", "int", "JjKbUOxUcJGGkgs", "char *", rc & "bcdll.dll", "int", 1)
    if(result)
        bc = com("bc.kakoii")
        for(var i = 0; i < 2; i++)
            CRK[i] = com("bc.kakoii")
        end
        traceprint(bc.Ver())
    else
        msgbox(AESdecrypt("28e90d3c381341601b1926fb8e7624032814f6925007e13a529de7392dc6305e"), 4)
        return TerminateProcess(GetCurrentProcess())
    end
    //大漠VIP註冊
    var bcreg = bc.Reg(AESdecrypt("b11a39e748d2984ae0d472a49e093164c3f5fe9f5eec21bb4792d3d15ea18d14bbe168824b22e4444d9177ae36722f41"), "4r")
    traceprint("bcreg_" & bcreg)    
    var bcIP = ""
    if(bcreg != 1)
        for(var i = 0; i < 9; i++)
            bcIP = GetDmIp(i)
            bcreg = bc.RegEx(AESdecrypt("b11a39e748d2984ae0d472a49e093164c3f5fe9f5eec21bb4792d3d15ea18d14bbe168824b22e4444d9177ae36722f41"), "4r", bcIP)
            if(i == 9 && bcreg != 1)
                GetRegbcdllError(bcreg)
            elseif(bcreg == 1)
                break
            end
        end
        bcIP = null
    end
    //檢查UAC
    if(bc.CheckUAC())
        bc.SetUAC(0)
    end
    threadbegin("RegDll", HWND)
end
function init(HWND)
    for(var i = 0; i < 3; i++)
        var handle = controlgethandle("tab" & i)
        if(i == 0)
            SetWindowLongA(handle, GetWindowLongA(handle) + TCS_BUTTONS)
        else
            SetWindowLongA(handle, GetWindowLongA(handle) + TCS_BUTTONS + TCS_FLATBUTTONS)
            windowsendmessage(handle, TCM_SETEXTENDEDSTYLE, 0, TCS_EX_FLATSEPARATORS)
        end
        SetWindowThemeEx(handle)
    end
    //分組框
    for(var i = 0; i < 20; i++)
        var handle = controlgethandle("group" & i)
        SetWindowLongA(handle, 1442971911)
        SetWindowThemeEx(handle)
    end
    for(var i = 0; i < 68; i++)
        SetWindowThemeEx(controlgethandle("check" & i))
    end
    for(var i = 0; i < 39; i++)
        SetWindowThemeEx(controlgethandle("button" & i))
    end
    for(var i = 0; i < 8; i++)
        SetWindowThemeEx(controlgethandle("combobox" & i))
    end
    for(var i = 0; i < 7; i++)
        SetWindowThemeEx(controlgethandle("co" & i))
        SetWindowThemeEx(controlgethandle("col" & i))
    end
    for(var i = 0; i < 3; i++)
        SetWindowThemeEx(controlgethandle("pco" & i))
    end
    for(var i = 0; i < 8; i++)
        SetWindowThemeEx(controlgethandle("switch" & i))
    end
    SetWindowThemeEx(SysTreeView32(HWND))
    SetWindowLongA(controlgethandle("list0"), GetWindowLongA(controlgethandle("list0")) - WS_BORDER)
    SetWindowLongA(controlgethandle("gridscript"), GetWindowLongA(controlgethandle("gridscript")) - WS_BORDER)
    SetWindowLongA(controlgethandle("gridmap"), GetWindowLongA(controlgethandle("gridmap")) - WS_BORDER)
    for(var i = 0; i < 2; i++)
        SetWindowLongA(controlgethandle("rb" & i), 1442967296)
        SetWindowThemeEx(controlgethandle("rb" & i))
    end
    for(var i = 0; i < 8; i++)
        gridsetrowheight("gridscript", i, 18)
        for(var j = 0; j < 3; j++)
            gridsetreadonly("gridscript", i, j)
        end
    end
    SetWindowThemeEx(controlgethandle("gridscript"))
    for(var i = 0; i < 20; i++)
        gridsetrowheight("gridmap", i, 18)
        for(var j = 0; j < 2; j++)
            gridsetreadonly("gridmap", i, j)
        end
    end
    SetWindowThemeEx(controlgethandle("gridmap"))
end
//關閉
function CgHP_close()
    if(bchwnd > 0)
        var ret = msgbox(AESdecrypt("4843a28fecb7f881a6a1519951caf0d54e0bbc17c48e5ad782fbe6d92d80c0fc") & "\r\n" & AESdecrypt("245db813db57f91bd503bed53b1f6009263a2df6fe62c1bcb3442404f930dbc2"), 5)
        //traceprint(ret)
        if(ret == 1)
            bc.SetWindowState(StairFinderHwnd, 0)
            ClearGameDat()
            TerminateProcess(GetProcessID(bchwnd))
            TerminateProcess(GetCurrentProcess())
        end
    else
        bc.SetWindowState(StairFinderHwnd, 0)
        TerminateProcess(GetCurrentProcess())
    end
end
//消息路由
var SetThemeHwnd_array = array()
function CgHP_pretranslatemessage(hwnd, message, wParam, lParam, time, x, y)
    //Theme
    if(arrayfindvalue(SetThemeHwnd_array, hwnd) == "")
        SetWindowThemeEx(hwnd)
    end
    //Treeview
    if(message == 515)
        if(hwnd == TreeViewhwnd)
            var Current_focus = windowsendmessage(TreeViewhwnd, TVM_GETNEXTITEM, 9, 0)
            if(Current_focus > 0 && ScriptOnOff == false)
                threadbegin("treeviewmenu", Current_focus)
            end
        end
    end
    //MAINMENU
    select(wParam)
        case 1000
        icochange()
        bc.SetWindowState(m_hwnd, 2)
        case 1001
        if(loginstate)
            PushAnnounce(bchwnd, strformat("<系統提示>登記帳號:%s 人物名稱:%s", GetAccountID(bchwnd), GetMyName(bchwnd))) 
            PushAnnounce(bchwnd, strformat("<系統提示>您的到期時間為:%s", WebInformation[2])) 
        end
        case 1002
        openprocessex("https://lovesa.cc/", "")
        case 1003
        threadclose(mainID, 1)
        threadclose(submainID, 1)
        TerminateProcess(GetProcessID(StairFinderHwnd))
        bc.Delay(100)
        ClearGameDat()
        TerminateProcess(GetProcessID(bchwnd))
        bc.Delay(100)
        TerminateProcess(GetCurrentProcess())
        case 1004
        ClearGameDat()
        TerminateProcess(GetProcessID(bchwnd))
        SetProcessInit(bchwnd)
        case 1005
        if(ALLREGSTATE)
            controlopenwindow("info", true)
        end
        case 1006
        if(ALLREGSTATE)
            controlopenwindow("mk", true)
        end
        case 1007
    end
    if(message == 515)//GRID_DBCLICK
        if(hwnd == controlgethandle("gridmap") && loginstate && LoginPreCheck && bchwnd > 0)
            var r_row, r_col
            gridgetfocusitem("gridmap", r_row, r_col) 
            if(r_row != 0)
                var content = gridgetcontent("gridmap", r_row, 1)
                if(content != "")
                    if(threadgetstatus(FINDROUTEID))
                        threadclose(FINDROUTEID)
                        threadbegin("SetMovementEx", array(east, south, bchwnd))
                    end
                    var tmpXYarray
                    strsplit(content, ",", tmpXYarray)
                    var XYarray = array()
                    XYarray[0] = bchwnd
                    XYarray[1] = tmpXYarray[0]
                    XYarray[2] = tmpXYarray[1]
                    FINDROUTEID = threadbegin("SetRoute", XYarray)
                end
            end
            //TAB_DBCLICK
        elseif(hwnd == controlgethandle("tab0"))
            if(tabgetcursel("tab0") == 1)
                select(gridmapOnOff)
                    case true
                    bc.MoveWindow(controlgethandle("gridmap"), 6, 71)
                    gridmapOnOff = false
                    case false
                    bc.MoveWindow(controlgethandle("gridmap"), 380, 102)
                    gridmapOnOff = true
                end
            end
        end
    end
    return false
end
//消息過程
function CgHP_windowproc(message, wParam, lParam)
    /////////////////////////////////////////////////////////////Scrollbar_Proc
    if(message == 277 && wParam == 0 && lParam)
        if(GetScrollSet(0) && tabgetcursel("tab1") == 2)
            if(walkdelay < 100)
                walkdelay = walkdelay + 1
            elseif(walkdelay < 200)
                walkdelay = walkdelay + 10
            else
                walkdelay = walkdelay + 100
            end
            staticsettext("static44", strformat("%d", walkdelay))
        end
    elseif(message == 277 && wParam == 1 && lParam)
        if(GetScrollSet(0) && tabgetcursel("tab1") == 2)
            if(walkdelay > 0 && walkdelay <= 100)
                walkdelay = walkdelay - 1
            elseif(walkdelay <= 200)
                walkdelay = walkdelay - 10
            elseif(walkdelay > 200)
                walkdelay = walkdelay - 100
            end
            staticsettext("static44", strformat("%d", walkdelay))
        end
    end
    ///////////////////////////////////
    if(message == 277 && wParam == 0)
        if(GetScrollSet(1) && tabgetcursel("tab1") == 2)
            if(walklen < 99)
                walklen = walklen + 1
            end
            staticsettext("static45", strformat("%d", walklen))
        end
    elseif(message == 277 && wParam == 1) 
        if(GetScrollSet(1) && tabgetcursel("tab1") == 2)
            if(walklen > 0)
                walklen = walklen - 1
            end
            staticsettext("static45", strformat("%d", walklen))
        end
    end
    ///////////////////////////////////////////////////////////
    if(message == 277 && wParam == 0)
        if(GetScrollSet(2) && tabgetcursel("tab2") == 0 && tabgetcursel("tab0") == 3)
            if(HPLIMIT < 100)
                HPLIMIT = HPLIMIT + 1
            end
            checksettext("check55", strformat("血量＜ %d％", HPLIMIT))
        end
    elseif(message == 277 && wParam == 1) 
        if(GetScrollSet(2) && tabgetcursel("tab2") == 0 && tabgetcursel("tab0") == 3)
            if(HPLIMIT > 0)
                HPLIMIT = HPLIMIT - 1
            end
            checksettext("check55", strformat("血量＜ %d％", HPLIMIT))
        end
    end
    ///////////////////////////////////////////////////////////
    if(message == 277 && wParam == 0)
        if(GetScrollSet(3) && tabgetcursel("tab2") == 0 && tabgetcursel("tab0") == 3)
            if(MPLIMIT < 100)
                MPLIMIT = MPLIMIT + 1
            end
            checksettext("check56", strformat("魔力＜ %d％", MPLIMIT))
        end
    elseif(message == 277 && wParam == 1) 
        if(GetScrollSet(3) && tabgetcursel("tab2") == 0 && tabgetcursel("tab0") == 3)
            if(MPLIMIT > 0)
                MPLIMIT = MPLIMIT - 1
            end
            checksettext("check56", strformat("魔力＜ %d％", MPLIMIT))
        end
    end
    ///////////////////////////////////////////////////////////
    if(message == 277 && wParam == 0)
        if(GetScrollSet(4) && tabgetcursel("tab2") == 0 && tabgetcursel("tab0") == 3)
            if(GROUPLIMIT < 5)
                GROUPLIMIT = GROUPLIMIT + 1
            end
            checksettext("check57", strformat("隊伍人數＜ %d", GROUPLIMIT))
        end
    elseif(message == 277 && wParam == 1) 
        if(GetScrollSet(4) && tabgetcursel("tab2") == 0 && tabgetcursel("tab0") == 3)
            if(GROUPLIMIT > 0)
                GROUPLIMIT = GROUPLIMIT - 1
            end
            checksettext("check57", strformat("隊伍人數＜ %d", GROUPLIMIT))
        end
    end
    ///////////////////////////////////////////////////////////
    if(message == 277 && wParam == 0)
        if(GetScrollSet(5) && tabgetcursel("tab2") == 0 && tabgetcursel("tab0") == 3)
            if(NORMALLIMIT < 300)
                NORMALLIMIT = NORMALLIMIT + 1
            end
            checksettext("check58", strformat("平時超時%d分鐘", NORMALLIMIT))
        end
    elseif(message == 277 && wParam == 1) 
        if(GetScrollSet(5) && tabgetcursel("tab2") == 0 && tabgetcursel("tab0") == 3)
            if(NORMALLIMIT > 0)
                NORMALLIMIT = NORMALLIMIT - 1
            end
            checksettext("check58", strformat("平時超時%d分鐘", NORMALLIMIT))
        end
    end
    ///////////////////////////////////////////////////////////
    if(message == 277 && wParam == 0)
        if(GetScrollSet(6) && tabgetcursel("tab2") == 0 && tabgetcursel("tab0") == 3)
            if(COMBATLIMIT < 300)
                COMBATLIMIT = COMBATLIMIT + 1
            end
            checksettext("check59", strformat("戰鬥超時%d分鐘", COMBATLIMIT))
        end
    elseif(message == 277 && wParam == 1) 
        if(GetScrollSet(6) && tabgetcursel("tab2") == 0 && tabgetcursel("tab0") == 3)
            if(COMBATLIMIT > 0)
                COMBATLIMIT = COMBATLIMIT - 1
            end
            checksettext("check59", strformat("戰鬥超時%d分鐘", COMBATLIMIT))
        end
    end
end
function GetScrollSet(type)
    var x, y
    mousegetpoint(x, y)
    var wndx, wndy
    var ret = windowscreentoclient(m_hwnd, x, y, wndx, wndy)
    //traceprint(strformat("%s %s %s", ret, wndx, wndy))
    if(ret && type == 0)
        if(wndx > 110 && wndx < 127 && wndy >= 100 && wndy <= 117)
            return true
        end
    elseif(ret && type == 1)
        if(wndy >= 120 && wndy <= 150)
            return true
        end
    elseif(ret && type == 2)
        if(wndy >= 115 && wndy <= 132)
            return true
        end
    elseif(ret && type == 3)
        if(wndy >= 135 && wndy <= 152)
            return true
        end
    elseif(ret && type == 4)
        if(wndy >= 155 && wndy <= 172)
            return true
        end
    elseif(ret && type == 5)
        if(wndy >= 175 && wndy <= 192)
            return true
        end
    elseif(ret && type == 6)
        if(wndy >= 195 && wndy <= 212)
            return true
        end
    end
    return false
end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//TAB0
function tab0_selectchange()
    var cursel = tabgetcursel("tab0")
    select(cursel)
        case 0//一般功能
        case 1//地圖功能
        bc.SetWindowState(StairFinderHwnd, 7)
        for(var i = 0; i < 2; i++)
            bc.SetWindowState(controlgethandle("rb" & i), 7)
            bc.SetWindowState(controlgethandle("re" & i), 7)
        end
        bc.SetWindowState(controlgethandle("static50"), 7)
        if(!gridmapOnOff)
            bc.MoveWindow(controlgethandle("gridmap"), 6, 71)
        end
        case 2//掛機功能
        bc.MoveWindow(controlgethandle("tab1"), 7, 76)
        if(tabgetcursel("tab1") == 2)
            bc.SetWindowState(scrollhwnd[0], 7)
            bc.SetWindowState(scrollhwnd[1], 7)
            windowsetfocus(controlgethandle("tab1"))
        end
        case 3//其他設定
        bc.MoveWindow(controlgethandle("tab2"), 7, 76)
        case 4//腳本
        TreeViewClear()
        TreeViewSetContent()
        windowshow(TreeViewhwnd)
    end
    if(cursel != 1)
        bc.MoveWindow(controlgethandle("gridmap"), 380, 102)
        for(var i = 0; i < 2; i++)
            bc.SetWindowState(controlgethandle("rb" & i), 6)
            bc.SetWindowState(controlgethandle("re" & i), 6)
        end
        bc.SetWindowState(controlgethandle("static50"), 6)
    end
    if(cursel != 2)
        bc.MoveWindow(controlgethandle("tab1"), 364, 49)
        bc.SetWindowState(scrollhwnd[0], 6)
        bc.SetWindowState(scrollhwnd[1], 6)
    end
    if(cursel != 3)
        bc.MoveWindow(controlgethandle("tab2"), 752, 49)
    end
    if(cursel != 4)
        bc.SetWindowState(TreeViewhwnd, 6)
    end
    if(tabgetcursel("tab0") != 3)
        for(var i = 2; i < 7; i++)
            bc.SetWindowState(scrollhwnd[i], 6)
        end
    elseif(tabgetcursel("tab0") == 3 && tabgetcursel("tab2") == 0)
        for(var i = 2; i < 7; i++)
            bc.SetWindowState(scrollhwnd[i], 6)
        end
    end
end
//TAB1
function tab1_selectchange()
    if(tabgetcursel("tab1") == 2)
        bc.SetWindowState(scrollhwnd[0], 7)
        bc.SetWindowState(scrollhwnd[1], 7)
        windowsetfocus(controlgethandle("tab1"))
    else
        bc.SetWindowState(scrollhwnd[0], 6)
        bc.SetWindowState(scrollhwnd[1], 6)
    end
end
//TAB2
function tab2_selectchange()
    if(tabgetcursel("tab2") == 0)
        for(var i = 2; i < 7; i++)
            bc.SetWindowState(scrollhwnd[i], 7)
        end
    else
        for(var i = 2; i < 7; i++)
            bc.SetWindowState(scrollhwnd[i], 6)
        end
    end
end
//MainSerCombobox
function combobox0_selectchange()
    ComboServer()
    combosetcursel("combobox1", 0)
end
//快速回點
function check1_click()
    checksetstate("check1", false)
    if(bchwnd > 0 && LoginPreCheck)
        var ret = msgbox(AESdecrypt("53eceec78b7c055b040d85b4cc0e46db"), 5)
        if(ret == 1)
            ReturnBase(bchwnd)
        end
    end
end
//快速原登
function check2_click()
    checksetstate("check2", false)
    if(bchwnd > 0 && LoginPreCheck)
        var ret = msgbox(AESdecrypt("5e17eee2e2678e435af5e402a7e31607"), 5)
        if(ret == 1)
            LogOut(bchwnd)
        end
    end
end
//快速傳送
function check3_click()
    checksetstate("check3", false)
    controldomodal("form2")
end
//啟動魔力
function button0_click()
    if(bcpath != "")
        controlenable("button0", false)
        RunGame()
    end
end
//快速登陸
function check4_click()
end
//隱藏魔力
function check10_click()
    var HWND = bchwnd
    select(checkgetstate("check10"))
        case true
        if(bc.GetWindowState(HWND, 3))
            bc.SetWindowState(HWND, 5)
        end
        bc.SetWindowState(HWND, 6)
        case false
        bc.SetWindowState(HWND, 5)
        bc.SetWindowState(HWND, 7)
    end
end
//屏蔽聲音
function check6_click()
    Mute(bchwnd)
end
//自動驗證
function check7_click()
end
//世界頻道
function switch6_click()
    checksetstate("switch6", false)
    if(bchwnd > 0)
        bc.SendString2(bchwnd, AESdecrypt("a319c0651219c8fbb99891a230417a70"))
        bc.KeyPress(13)
    end
end
//整理背包
function check14_click()
    checksetstate("check14", false)
    BackpakeArrange(bchwnd)
end
//恢復次數
function check15_click()
    checksetstate("check15", false)
    if(bchwnd > 0)
        bc.SendString2(bchwnd, AESdecrypt("ba26da48d7e2871e8ebcf990a08689af"))
        bc.KeyPress(13)
    end
end
//自動競技
function check16_click()
end
//聊窗切換
function check17_click()
    checksetstate("check17", false)
    if(bchwnd > 0)
        bc.KeyDown(17)
        bc.KeyPress(36)
        bc.KeyUp(17)
        bc.KeyPress(8)
    end
end
//獵殺進度
function check19_click()
    checksetstate("check19", false)
    if(bchwnd > 0)
        bc.SendString2(bchwnd, "/hunt")
        bc.KeyPress(13)
    end
end
//日任進度
function check20_click()
    checksetstate("check20", false)
    if(bchwnd > 0)
        bc.SendString2(bchwnd, "/日任進度")
        bc.KeyPress(13)
    end
end
//隨身倉庫
function check18_click()
    checksetstate("check18", false)
    SetBankPageOn(bchwnd)
end
//隨身卡時
function check23_click()
    checksetstate("check23", false)
    if(bchwnd > 0)
        bc.SendString2(bchwnd, AESdecrypt("8adc5c32de357394dd5823e432a2263a"))
        bc.KeyPress(13)
    end
end
//自動喚出倉庫道具且打開倉庫
function SetBankPageOn(HWND)
    if(LoginPreCheck)
        var tmp = -1
        for(var i = 19; i > -1; i--)
            var ret = strfind(itemName[i], AESdecrypt("42de097c03f6af34deaae52f749e4d05"))
            if(i == 0 && ret == -1)
                bc.SendString2(HWND, AESdecrypt("9ed4873c01479194a37ce1abf782c77a"))
                bc.KeyPress(13)
                bc.Delay(1000)
                ret = strfind(itemName[i], AESdecrypt("42de097c03f6af34deaae52f749e4d05"))
                if(ret == -1)
                    return false
                end
            end
            if(ret >= 0)
                tmp = i
                break
            end
        end
        if(tmp != -1)
            UseItem(HWND, tmp)
            bc.Delay(500)
            SetBankPage(HWND, 0)
        end
    end
end
//走路遇敵
function check24_click()
    checksetstate("check29", false)
    var HWND = bchwnd
    if(!checkgetstate("check24"))
        threadclose(AutoWalkID, 1)
        threadbegin("SetMovementEx", array(east, south, HWND))
    else
        if(!threadgetstatus(AutoWalkID))
            threadclose(AutoWalkExID, 1)
            wmdata(HWND, #00462EA2, AESdecrypt("98cdc4feff2f09851447efa1863f836a"))
            AutoWalkID = threadbegin("AutoWalk", HWND)
        end
    end
end
//快速遇敵
function check29_click()
    checksetstate("check24", false)
    SuperAutoWalk(bchwnd)
end
function SuperAutoWalk(HWND)
    if(!checkgetstate("check29"))
        threadclose(AutoWalkExID, 1)
        wmdata(HWND, #00462EA2, AESdecrypt("98cdc4feff2f09851447efa1863f836a"))
        threadbegin("SetMovementEx", array(east, south, HWND))
    else
        if(!threadgetstatus(AutoWalkExID))
            threadclose(AutoWalkID)
            wmdata(HWND, #00462EA2, AESdecrypt("6d056bc88d714d9477eb9bd423368c48"))
            AutoWalkExID = threadbegin("AutoWalkEx", HWND)
        end
    end
end
//加入隊伍
function button1_click()
    if(bchwnd > 0 && LoginPreCheck)
        GroupJoin(bchwnd, 1)
    end
end
//離開隊伍
function button2_click()
    if(bchwnd > 0 && LoginPreCheck)
        GroupJoin(bchwnd, 0)
    end
end
//販售物品
function button3_click()
    if(bchwnd > 0 && LoginPreCheck)
        NPC_sellitem(bchwnd)
    end
end
//開關血條
function button4_click()
    if(bchwnd > 0 && LoginPreCheck)
        bc.KeyDown(17)
        bc.KeyPress(122)
        bc.KeyUp(17)
        bc.KeyPress(8)
    end
end
//觀戰
function button5_click()
    if(bchwnd > 0 && LoginPreCheck)
        bc.KeyDown(17)
        bc.KeyPress(75)
        bc.KeyUp(17)
        bc.KeyPress(8)
    end
end
//面板歸位
function button6_click()
    if(bchwnd > 0 && LoginPreCheck)
        bc.KeyDown(17)
        bc.KeyPress(123)
        bc.KeyUp(17)
        bc.KeyPress(8)
    end
end
//儲存設置
function button7_click()
    if(bchwnd > 0 && LoginPreCheck)
        var ret = msgbox(AESdecrypt("10c11f16296babe9c6ffd644a44893e124989bcdf91fe3fb3e70998f034d0468730377dde081b1379b0551ca7396cd02"), 5)
        if(ret == 1)
            SaveSet(bchwnd)
        end
    end
end
//讀取設置
function button8_click()
    if(ALLREGSTATE)
        LoadSet()
    end
end
//鎖圖列表
function list0_doubleclicked()
    listdeletetext("list0", listgetcursel("list0"))
    arrayclear(maplock)
    var size = listgetcount("list0")
    for(var i = 0; i < size; i++)
        arraypush(maplock, listgettext("list0", i))
    end
end
//鎖圖添加
function button19_click()
    var size = listgetcount("list0")
    var precheck = array()
    for(var i = 0; i < size; i++)
        precheck[i] = listgettext("list0", i)
    end
    var content = editgettext("edit9")
    if(arrayfindvalue(precheck, content) == "")
        if(content != "")
            listinserttext("list0", content, 0)
            arraypush(maplock, content)
        end
    end
end
//鎖圖讀地圖名
function button20_click()
    if(bchwnd > 0 && loginstate)
        editsettext("edit9", GetMap(bchwnd))
    end
end
//隊伍
function switch2_click()
    if(bchwnd > 0)
        hotkeybutton(79)
    end
end
//決鬥
function switch0_click()
    if(bchwnd > 0)
        hotkeybutton(85)
    end
end
//交名
function switch3_click()
    if(bchwnd > 0)
        hotkeybutton(80)
    end
end
//交易
function switch4_click()
    if(bchwnd > 0)
        hotkeybutton(70)
    end
end
//家族
function switch5_click()
    if(bchwnd > 0)
        hotkeybutton(219)
    end
end
//聊天
function switch1_click()
    if(bchwnd > 0)
        hotkeybutton(73)
    end
end
//戰鬥99秒
function check28_click()
    SetTimeExtension(bchwnd)
end
//技能下拉框
function co0_selectchange()
    SetColContent(0)
end
function co1_selectchange()
    SetColContent(1)
    GetSkillLV(bchwnd)
    bc.Delay(10)
    coselect[1] = combogetcursel("co1")
    if(skillmaxexp[coselect[1] - 3] != 483400)
        staticsettext("static9", strformat("%d/%d", skillexp[coselect[1] - 3], skillmaxexp[coselect[1] - 3]))
        staticsettext("static11", expdifferance[coselect[1] - 3])
    else
        staticsettext("static9", strformat("%d/ ----- ", skillexp[coselect[1] - 3]))
        staticsettext("static11", 0)
    end
end
function co2_selectchange()
    SetColContent(2)
end
function co3_selectchange()
    SetColContent(3)
end
function co4_selectchange()
    SetColContent(4)
end
function co5_selectchange()
    SetColContent(5)
end
function co6_selectchange()
    SetColContent(6)
end
//選擇目標按鈕
function button11_click()
    form1caption = 0
    var ret = controldomodal("form1")
    SetTargetButtonText(11, ret)
end
function button12_click()
    form1caption = 1
    var ret = controldomodal("form1")
    SetTargetButtonText(12, ret)
end
function button13_click()
    form1caption = 2
    var ret = controldomodal("form1")
    SetTargetButtonText(13, ret)
end
function button14_click()
    form1caption = 3
    var ret = controldomodal("form1")
    SetTargetButtonText(14, ret)
end
function button15_click()
    form1caption = 4
    var ret = controldomodal("form1")
    SetTargetButtonText(15, ret)
end
function button9_click()
    form1caption = 5
    var ret = controldomodal("form1")
    SetTargetButtonText(9, ret)
end
function button10_click()
    form1caption = 6
    var ret = controldomodal("form1")
    SetTargetButtonText(10, ret)
end
function button24_click()
    form1caption = 7
    var ret = controldomodal("form1")
    SetTargetButtonText(24, ret)
end
function button16_click()
    form1caption = 8
    var ret = controldomodal("form1")
    SetTargetButtonText(16, ret)
end
function button17_click()
    form1caption = 9
    var ret = controldomodal("form1")
    SetTargetButtonText(17, ret)
end
function button18_click()
    form1caption = 10
    var ret = controldomodal("form1")
    SetTargetButtonText(18, ret)
end
//自動丟棄
function check21_click()
    if(checkgetstate("check21"))
        checksetstate("check21", false)
        form0caption = 0
        var ret = controldomodal("form0")
        if(!ret)
            checksetstate("check21", false)
        else
            if(arraysize(dropitem) > 0)
                checksetstate("check21")
            end
        end
    end
end
//自動戰鬥
function check30_click()
    AutoCombatOnOff(bchwnd)
end
//移動窗口
function button25_click()
    SetWindowMove(0)
end
function button26_click()
    SetWindowMove(1)
end
function button27_click()
    SetWindowMove(2)
end
function button28_click()
    SetWindowMove(3)
end
function button29_click()
    SetWindowMove(4)
end
function button30_click()
    SetWindowMove(5)
end
//超級加速
function check13_click()
    var HWND = bchwnd
    if(checkgetstate("check13"))
        //加速
        wmint(HWND, #00E7FD74, 0, combogetcursel("combobox3"))
        wmdata(HWND, #00516506, AESdecrypt("706d4bbfa6b6209784baedc2361b9a80c96a91f0f6bc198a68d57aab10e65338"))
    else
        wmdata(HWND, #00516506, AESdecrypt("ffbbe23c0643d102deb98439f9c98efa9551d8dc0bb0e76a783141ea913c1496"))
    end
end
//超級加速下拉框
function combobox3_selectchange()
    var countsp = 0
    superspeedstate = combogetcursel("combobox3")
    var HWND = bchwnd
    wmint(HWND, #00E7FD74, 0, superspeedstate)//加速寫入
    var superspeed = GetSuperSpeed(HWND)
    if(superspeed > 0)
        countsp = (16.67 * (16.67 / superspeed))
    end
    buttonsettext("group1", strformat("SP:%d(%d)", countsp, GetWalkSpeed(HWND)))
end
//技能等級對應敵人數目
function check35_click()
    checksetstate("check34", false)//取消道具技
end
//手動設置尋路
function rb1_click()
    if(threadgetstatus(FINDROUTEID))
        threadclose(FINDROUTEID)
        threadbegin("SetMovementEx", array(east, south, bchwnd))
    end
end
function rb0_click()
    var x = editgettext("re0")
    var y = editgettext("re1")
    if(x > 0 && y > 0)
        if(threadgetstatus(FINDROUTEID))
            threadclose(FINDROUTEID)
            threadbegin("SetMovementEx", array(east, south, bchwnd))
        end
        FINDROUTEID = threadbegin("SetRoute", array(bchwnd, x, y))
    end
end
///設置列表
function button32_click()
    form0caption = 1
    var ret = controldomodal("form0")
    //traceprint(ret)
    SetEditForm0(ret, 1, "edit17")
end
function button33_click()
    form0caption = 2
    var ret = controldomodal("form0")
    SetEditForm0(ret, 2, "edit18")
end
function button34_click()
    form0caption = 3
    var ret = controldomodal("form0")
    SetEditForm0(ret, 3, "edit19")
end
function button35_click()
    form0caption = 4
    var ret = controldomodal("form0")
    SetEditForm0(ret, 4, "edit20")
end
function button36_click()
    var target = editgettext("edit21")
    if(target >= 0 && target <= 5)
        SetUseNormalSkill(bchwnd, target)
    end
end
//強關所有找樓梯
function button37_click()
    threadbegin("ForceTerminateStairFinder", null)
end
function ForceTerminateStairFinder()
    var result = enum("CgStairFinder.exe", 2)
    var ret, hwnd = array()
    var size = strsplit(result, "|", ret)
    for(var i = 0; i < size; i++)
        TerminateProcess(ret[i])
    end
    threadbegin("RunCgStairFinder", null)
end
//平時超時
function check58_click()
    if(checkgetstate("check58") && !combatstate)
        NormalTickCount = bc.GetTime()
    else
        NormalTickCount = 0
        NormalDuration = 0
    end
end
function button38_click()
    form0caption = 5
    var ret = controldomodal("form0")
    SetEditForm0(ret, 5, "edit22", 1)
end
var g_hwnd = 0
function timer0_ontime()
    if(bchwnd > 0)
        ReadMemory(g_hwnd)
    end
end
//自動窗口排列
function button39_click()
    threadbegin("SetWindowArrange", "")
end
function button31_click()
    controldomodal("form3")
end