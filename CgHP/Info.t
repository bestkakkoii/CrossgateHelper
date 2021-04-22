//資訊窗口
var scrollhwnd2 = array()
function info_init()
    var handle = controlgethandle("infotab", "info")
    var infohwnd = controlgetchildhwnd("info")
    scrollhwnd2[0] = CreateScrollbar(infohwnd, 589, 49, 33, 17, 1)
    scrollhwnd2[1] = CreateScrollbar(infohwnd, 670, 25)
    scrollhwnd2[2] = CreateScrollbar(infohwnd, 620, 45)
    scrollhwnd2[3] = CreateScrollbar(infohwnd, 620, 65)
    scrollhwnd2[4] = CreateScrollbar(infohwnd, 620, 85)
    bc.SetWindowSize(controlgetchildhwnd("info"), 711, 315)
    SetWindowLongA(controlgethandle("talklist0", "info"), GetWindowLongA(controlgethandle("talklist0", "info")) - WS_BORDER)
    SetWindowLongA(handle, GetWindowLongA(handle) + TCS_BUTTONS + TCS_FLATBUTTONS)
    windowsendmessage(handle, TCM_SETEXTENDEDSTYLE, 0, TCS_EX_FLATSEPARATORS)
    SetWindowThemeEx(handle)
    windowhide(controlgethandle("mailcombo0", "info"))
    windowhide(controlgethandle("mailcombo1", "info"))
    for(var i = 0; i < 3; i++)
        buttonsetpushlike("buttoninfo" & i, "info")
        SetWindowThemeEx(controlgethandle("buttoninfo" & i, "info"))
    end
    var infogrouphandle = controlgethandle("infogroup0", "info")
    SetWindowLongA(infogrouphandle, 1442971911)
    SetWindowThemeEx(infogrouphandle)
    infogrouphandle = controlgethandle("infogroup1", "info")
    SetWindowLongA(infogrouphandle, 1442971911)
    SetWindowThemeEx(infogrouphandle)
    gridsetrowheight("gridinfo0", 0, 17, "info")
    gridsetrowheight("gridinfo1", 0, 17, "info")
    windowhide(controlgethandle("talkcombo0", "info"))
    savetxsize = 0
    SetPreTalkHistory(bchwnd)
    stonevaluesave = 0
    itemAmountsave = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    WearNamesave = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
    for(var i = 0; i < 21; i++)
        if(i != 0)
            gridsetcontent("griditem0", i, 0, i, "info")
            gridsetrowheight("griditem0", i, 15, "info")
        else
            gridsetrowheight("griditem0", i, 18, "info")
        end
    end
    var wearpart = array("頭部", "身體", "右手", "左手", "鞋子", "飾品1", "飾品2", "水晶")
    for(var i = 0; i < 14; i++)
        if(i != 0)
            if(i < 9)
                gridsetcontent("griditem1", i, 0, wearpart[i - 1], "info")
            end
            gridsetrowheight("griditem1", i, 15, "info")
        else
            gridsetrowheight("griditem1", i, 18, "info")
        end
    end
    for(var i = 0; i < 21; i++)
        if(itemExist[i] > 0)
            gridsetcontent("griditem0", i + 1, 1, itemName[i], "info")
            gridsetrowheight("griditem0", i + 1, 15, "info")
        else
            gridsetcontent("griditem0", i + 1, 1, "", "info")
            gridsetrowheight("griditem0", i + 1, 15, "info")
        end
        if(itemExist[i] > 0)
            if(itemAmount[i] == 0 && itemExist[i] > 0)
                gridsetcontent("griditem0", i + 1, 2, itemAmount[i] + 1, "info")
            else
                gridsetcontent("griditem0", i + 1, 2, itemAmount[i], "info")
            end
            gridsetrowheight("griditem0", i + 1, 15, "info")
        else
            gridsetcontent("griditem0", i + 1, 2, "", "info")
            gridsetrowheight("griditem0", i + 1, 15, "info")
        end
    end
    for(var i = 0; i < 8; i++)
        if(WearExist[i] > 0)
            gridsetcontent("griditem1", i + 1, 1, WearName[i], "info")
            gridsetrowheight("griditem1", i + 1, 15, "info")
        else
            gridsetcontent("griditem1", i + 1, 1, "", "info")
            gridsetrowheight("griditem1", i + 1, 15, "info")
        end
    end
    var stonevalue = itemvalue()
    if(stonevalue != stonevaluesave)
        staticsettext("static49", strformat("%d", stonevalue), "info")
        stonevaluesave = stonevalue
    end
    var itemhandle0 = controlgethandle("griditem0", "info")
    var itemhandle1 = controlgethandle("griditem1", "info")
    bc.MoveWindow(itemhandle0, 295, 57)
    bc.MoveWindow(itemhandle1, 4, 57)
    windowhide(itemhandle0)
    windowhide(itemhandle1)
    SetWindowLongA(itemhandle0, GetWindowLongA(itemhandle0) - WS_BORDER)
    SetWindowLongA(itemhandle1, GetWindowLongA(itemhandle1) - WS_BORDER)
    timerregister("infoTimer", 1000, "info")
    for(var i = 0; i < arraysize(autotalklistarray); i++)
        if(autotalklistarray[i] != "")
            listaddtext("talklist0", autotalklistarray[i], "info")
        end
    end
    checksetstate("autotalk", AutoTalkCheck, "info")
end
//預讀對話歷史紀錄
function SetPreTalkHistory(HWND)
    if(HWND > 0)
        var path = windowgetpath(bchwnd)
        path = strreplace(path, "bluecg.exe", "")
        var filepath = path & rmstring(HWND, #006136D4, 100)
        var ret = filereadex(filepath)
        var dv	
        var size = strsplit(ret, "\r\n", dv)
        var listhwnd = controlgethandle("infotalkedit", "info")
        var TEXT = ""
        for(var i = 0; i < size; i++)
            TEXT = strformat("%s%s\r\n", TEXT, dv[i])
        end
        editsettext("infotalkedit", TEXT, "info")
        windowsendmessage(listhwnd, 277, 7, 0)
        savetxsize = size
    end
end
//消息路由
function info_pretranslatemessage(hwnd, message, wParam, lParam, time, x, y)
    if(message != 512 && message != 275 && message != 280 && message != 160 && message != 15 && message != 674 && message != 273)
        //traceprint(strformat("%s %s %s %s", hwnd, message, wParam, lParam))
    end
    if(wParam == 13)
        var edithwnd = controlgethandle("talkcombo0", "info")
        var hwnd_child = windowfindchild(edithwnd, "", "Edit")
        if(hwnd == hwnd_child)//發送對話combobox
            var checkString
            var String = combogettext("talkcombo0", "info")
            //
            if(String != "")
                if(combogetcursel("talkcombo1", "info") == 0)
                    bc.SendString2(bchwnd, String)
                    bc.KeyPress(13)
                    comboaddtext("talkcombo0", String, "info")
                    combosetcursel("talkcombo0", -1, "info")
                    combodeleteedit("talkcombo0", "info")
                elseif(combogetcursel("talkcombo1", "info") == 1)
                    String = "[GUILD]" & String
                    bc.SendString2(bchwnd, String)
                    bc.KeyPress(13)
                    String = strreplace(String, "[GUILD]", "")
                    comboaddtext("talkcombo0", String, "info")
                    combosetcursel("talkcombo0", -1, "info")
                    combodeleteedit("talkcombo0", "info")
                end
            end
        end
    elseif(wParam == 36)//清屏熱鍵
        bc.KeyPress(36)
    end
    if(message == 515)//GRID_DBCLICK使用物品
        if(hwnd == controlgethandle("griditem0", "info") && loginstate && bchwnd > 0)
            var r_row, r_col
            gridgetfocusitem("griditem0", r_row, r_col, "info")   
            if(r_row != 0)
                UseItem(bchwnd, r_row - 1)
                threadbegin("SetItemData", bchwnd)
            end
        elseif(hwnd == controlgethandle("griditem1", "info") && loginstate && bchwnd > 0)
            var r_row, r_col
            gridgetfocusitem("griditem1", r_row, r_col, "info")   
            if(r_row >= 1 && r_row <= 8)
                SetUnWearItem(bchwnd, r_row - 1)
                threadbegin("SetItemData", bchwnd)
            end
        end
    end
    if(message == 517)//RCLICK_POP_MENU
        if(hwnd == controlgethandle("griditem0", "info"))
            var r_row, r_col
            gridgetfocusitem("griditem0", r_row, r_col, "info")   
            if(r_row != 0)
                infopopmenu(bchwnd)
            end
        end
    end
    return false
end
//消息過程
var mailview = 0
function info_windowproc(message, wParam, lParam)
    //    if(message == 277)
    //        traceprint(strformat("%s %s %s", message, wParam, lParam))
    //    end
    //SCROLLBAR_PROC
    if(message == 276)
        if(wParam == 1)
            if(mailview < 9)
                mailview++
                var sel = listgetcursel("maillist0", "info")
                editsettext("mailedit1", maillcontent[sel][mailview], "info")
                staticsettext("static55", strformat("第%s封", mailview + 1), "info")
            end
        elseif(wParam == 0)
            if(mailview > 0)
                mailview--
                var sel = listgetcursel("maillist0", "info")
                editsettext("mailedit1", maillcontent[sel][mailview], "info")
                staticsettext("static55", strformat("第%s封", mailview + 1), "info")
            end
        end
    end
    ///////////////////////////////////////
    if(message == 277 && wParam == 0)
        if(GetInfoScrollSet(0) && tabgetcursel("infotab", "info") == 2)
            if(talkdelay < 99.9)
                talkdelay = talkdelay + 0.1
            end
            checksettext("autotalk", strformat("自動說話 間隔%s秒", strcut(talkdelay, 5, false)), "info")
        end
    elseif(message == 277 && wParam == 1) 
        if(GetInfoScrollSet(0) && tabgetcursel("infotab", "info") == 2)
            if(talkdelay > 0.2)
                talkdelay = talkdelay - 0.1
            end
            checksettext("autotalk", strformat("自動說話 間隔%s秒", strcut(talkdelay, 5, false)), "info")
        end
    end
    ///////////////////////////////////////
    if(message == 277 && wParam == 0)
        if(GetInfoScrollSet(1) && tabgetcursel("infotab", "info") == 2)
            if(talkwinheight < 26)
                talkwinheight = talkwinheight + 1
            end
            if(LoginPreCheck)
                wmint(bchwnd, #00C1C478, 0, talkwinheight)
            end
            staticsettext("static56", strformat("聊窗高度: %d", talkwinheight), "info")
        end
    elseif(message == 277 && wParam == 1) 
        if(GetInfoScrollSet(1) && tabgetcursel("infotab", "info") == 2)
            if(talkwinheight > 4)
                talkwinheight = talkwinheight - 1
            end
            if(LoginPreCheck)
                wmint(bchwnd, #00C1C478, 0, talkwinheight)
            end
            staticsettext("static56", strformat("聊窗高度: %d", talkwinheight), "info")
        end
    end
    ///////////////////////////////////////
    if(message == 277 && wParam == 0)
        if(GetInfoScrollSet(2) && tabgetcursel("infotab", "info") == 2)
            if(talkwinwidth < 37)
                talkwinwidth = talkwinwidth + 1
            end
            if(LoginPreCheck)
                wmint(bchwnd, #00C1C470, 0, talkwinwidth)
            end
            staticsettext("static57", strformat("聊窗寬度: %d", talkwinwidth), "info")
        end
    elseif(message == 277 && wParam == 1) 
        if(GetInfoScrollSet(2) && tabgetcursel("infotab", "info") == 2)
            if(talkwinwidth > 12)
                talkwinwidth = talkwinwidth - 1
            end
            if(LoginPreCheck)
                wmint(bchwnd, #00C1C470, 0, talkwinwidth)
            end
            staticsettext("static57", strformat("聊窗寬度: %d", talkwinwidth), "info")
        end
    end
    ///////////////////////////////////////
    if(message == 277 && wParam == 0)
        if(GetInfoScrollSet(3) && tabgetcursel("infotab", "info") == 2)
            if(talkvolume < 5)
                talkvolume = talkvolume + 1
            end
            if(LoginPreCheck)
                wmint(bchwnd, #00544460, 0, talkvolume)
            end
            staticsettext("static58", strformat("說話音量: %d", talkvolume), "info")
        end
    elseif(message == 277 && wParam == 1) 
        if(GetInfoScrollSet(3) && tabgetcursel("infotab", "info") == 2)
            if(talkvolume > 1)
                talkvolume = talkvolume - 1
            end
            if(LoginPreCheck)
                wmint(bchwnd, #00544460, 0, talkvolume)
            end
            staticsettext("static58", strformat("說話音量: %d", talkvolume), "info")
        end
    end
end
var talkwinheight = 4
var talkwinwidth = 12
var talkdelay = 5.00
var talkvolume = 5
function GetInfoScrollSet(type)
    var x, y
    mousegetpoint(x, y)
    var wndx, wndy
    var ret = windowscreentoclient(controlgetchildhwnd("info"), x, y, wndx, wndy)
    //traceprint(strformat("%s %s %s", ret, wndx, wndy))
    if(ret && type == 0)
        if(wndx > 670 && wndx < 687 && wndy >= 25 && wndy <= 42)
            return true
        end
    elseif(ret && type == 1)
        if(wndx > 620 && wndx < 647 && wndy >= 45 && wndy <= 62)
            return true
        end
    elseif(ret && type == 2)
        if(wndx > 620 && wndx < 647 && wndy >= 65 && wndy <= 82)
            return true
        end
    elseif(ret && type == 3)
        if(wndx > 620 && wndx < 647 && wndy >= 85 && wndy <= 102)
            return true
        end
    end
end
//調用創建右鍵選單功能
function infopopmenu(HWND)
    var log
    var index = PopuMenu("_|人物使用|寵物一使用|寵物二使用|寵物三使用|寵物四使用|寵物五使用|_|丟棄物品|_|複製道具名")
    //traceprint("選項編號: " & index)
    if(loginstate && HWND > 0)
        var r_row, r_col
        gridgetfocusitem("griditem0", r_row, r_col, "info")
        select(index)
            case 1
            UseItemSuper(HWND, r_row - 1, 0)
            case 2
            UseItemSuper(HWND, r_row - 1, 1)
            case 3
            UseItemSuper(HWND, r_row - 1, 2)
            case 4
            UseItemSuper(HWND, r_row - 1, 3)
            case 5
            UseItemSuper(HWND, r_row - 1, 4)
            case 6
            UseItemSuper(HWND, r_row - 1, 5)
            case 8
            PickItem(HWND, r_row - 1)
            var mx, my
            bc.GetCursorPos(mx, my)
            if(mx != 320 && my != 240)
                bc.MoveTo(320, 240)
            end
            bc.LeftClick()
            case 10
            bc.SetClipboard(itemName[r_row - 1])
        end  
    end
end
//
function infoTimer_ontime()
    var HWND = bchwnd
    if(HWND > 0)
        select(tabgetcursel("infotab", "info"))
            case 0
            SetInfoData()
            if(infoshow[0] != infoshowsave[0])
                if(!checkgetstate("check30"))
                    infoshow[0] = "戰鬥人物動作"
                end
                staticsettext("staticinfo1", infoshow[0], "info")
                infoshowsave[0] = infoshow[0]
            end
            if(infoshow[1] != infoshowsave[1])
                if(!checkgetstate("check30"))
                    infoshow[1] = "戰鬥寵物動作"
                end
                staticsettext("staticinfo2", infoshow[1], "info")
                infoshowsave[1] = infoshow[1]
            end
            case 1
            SetItemData(HWND)
            case 2
            GetTalkHistory(HWND)
            staticsettext("static56", strformat("聊窗高度: %d", rmint(HWND, #00C1C478, 0)), "info")
            staticsettext("static57", strformat("聊窗寬度: %d", rmint(HWND, #00C1C470, 0)), "info")
            staticsettext("static58", strformat("說話音量: %d", rmint(HWND, #00544460, 0)), "info")
        end
    end
end
//物品資訊
var iteminfo1save = array()
var iteminfo1 = null
function SetItemData(HWND)
    if(HWND > 0 && LoginPreCheck)
        if(isarray(iteminfo1))
            for(var i = 0; i < 20; i++)
                iteminfo1[i] = infochk(iteminfo1[i])
            end
        end
        bc.Delay(10)
        for(var i = 0; i < 21; i++)
            if(itemName[i] != itemNamesave2[i] || itemAmount[i] != itemAmountsave[i] || iteminfo1save[i] != iteminfo1[i])
                if(itemExist[i] > 0)
                    gridsetcontent("griditem0", i + 1, 3, iteminfo1[i], "info")
                    gridsetcontent("griditem0", i + 1, 1, itemName[i], "info")
                    if(gridgetrowheight("griditem0", i + 1, "info") != 15)
                        gridsetrowheight("griditem0", i + 1, 15, "info")
                    end
                else
                    gridsetcontent("griditem0", i + 1, 3, "", "info")
                    gridsetcontent("griditem0", i + 1, 1, "", "info")
                    if(gridgetrowheight("griditem0", i + 1, "info") != 15)
                        gridsetrowheight("griditem0", i + 1, 15, "info")
                    end
                end
                if(itemExist[i] > 0)
                    if(itemAmount[i] == 0 && itemExist[i] > 0)
                        gridsetcontent("griditem0", i + 1, 2, itemAmount[i] + 1, "info")
                    else
                        gridsetcontent("griditem0", i + 1, 2, itemAmount[i], "info")
                    end
                    if(gridgetrowheight("griditem0", i + 1, "info") != 15)
                        gridsetrowheight("griditem0", i + 1, 15, "info")
                    end
                else
                    gridsetcontent("griditem0", i + 1, 2, "", "info")
                    if(gridgetrowheight("griditem0", i + 1, "info") != 15)
                        gridsetrowheight("griditem0", i + 1, 15, "info")
                    end
                end
                if(itemName[i] != itemNamesave2[i])
                    itemNamesave2[i] = itemName[i]
                end
                if(itemAmount[i] != itemAmountsave[i])
                    itemAmountsave[i] = itemAmount[i] 
                end
                if(iteminfo1save[i] != iteminfo1[i])
                    iteminfo1save[i] = iteminfo1[i]
                end
            end
        end
        bc.Delay(10)
        for(var i = 0; i < 8; i++)
            if(WearName[i] != WearNamesave[i])
                if(WearExist[i] > 0)
                    gridsetcontent("griditem1", i + 1, 1, WearName[i], "info")
                    if(gridgetrowheight("griditem0", i + 1, "info") != 15)
                        gridsetrowheight("griditem1", i + 1, 15, "info")
                    end
                else
                    gridsetcontent("griditem1", i + 1, 1, "", "info")
                    if(gridgetrowheight("griditem0", i + 1, "info") != 15)
                        gridsetrowheight("griditem1", i + 1, 15, "info")
                    end
                end
                WearNamesave[i] = WearName[i]
            end
        end
        bc.Delay(10)
        var stonevalue = itemvalue()
        if(stonevalue != stonevaluesave)
            staticsettext("static49", strformat("%d", stonevalue), "info")
            stonevaluesave = stonevalue
        end
    end
end
//過濾多於字元
function infochk(content)
    var infochk = regexmatchtext(content, "[$][0-9]{1}", false, false, false, false)
    if(infochk != "")
        for(var i = 0; i < arraysize(infochk); i++)
            content = strreplace(content, infochk[i], "")
        end
        for(var i = 0; i < 9; i++)
            content = strreplace(content, "$" & i, "")
        end
        return content
    else
        return content
    end
end
//戰場資訊
function SetInfoData()
    if(bchwnd > 0 && LoginPreCheck)
        var combattimeinfo = strformat("第 %d 局         第 %d 回合          回合時間: %s秒        累積時間: %d 分鐘    ", TotalRound, round + 1, CombatDuration, TotalDuration / 60)
        if(combattimeinfo != combattimeinfosave)
            staticsettext("staticinfo0", combattimeinfo, "info")
            combattimeinfosave = combattimeinfo
        end
        bc.Delay(10)
        var Unit = array()
        arraysetcache(Unit, 20)
        for(var i = 0; i < 20; i++)
            if(alivelv[i] != 0)
                Unit[i] = strformat("%s LV:%d HP:%d/%d MP:%d/%d", alivename[i], alivelv[i], alivehp[i], alivemaxhp[i], alivemp[i], alivemaxmp[i])
            else
                Unit[i] = ""
            end
            if(Unit[i] != Unitsave[i])
                select(i)
                    case 0
                    gridsetcontent("gridinfo0", 5, 0, Unit[i], "info")
                    if(gridgetrowheight("gridinfo0", 5, "info") != 15)
                        gridsetrowheight("gridinfo0", 5, 15, "info")
                    end
                    case 1
                    gridsetcontent("gridinfo0", 3, 0, Unit[i], "info")
                    if(gridgetrowheight("gridinfo0", 3, "info") != 15)
                        gridsetrowheight("gridinfo0", 3, 15, "info")
                    end
                    case 2
                    gridsetcontent("gridinfo0", 7, 0, Unit[i], "info")
                    if(gridgetrowheight("gridinfo0", 7, "info") != 15)
                        gridsetrowheight("gridinfo0", 7, 15, "info")
                    end
                    case 3
                    gridsetcontent("gridinfo0", 1, 0, Unit[i], "info")
                    if(gridgetrowheight("gridinfo0", 1, "info") != 15)
                        gridsetrowheight("gridinfo0", 1, 15, "info")
                    end
                    case 4
                    gridsetcontent("gridinfo0", 9, 0, Unit[i], "info")
                    if(gridgetrowheight("gridinfo0", 9, "info") != 15)
                        gridsetrowheight("gridinfo0", 9, 15, "info")
                    end
                    case 5
                    gridsetcontent("gridinfo0", 6, 0, "    " & Unit[i], "info")
                    if(gridgetrowheight("gridinfo0", 6, "info") != 15)
                        gridsetrowheight("gridinfo0", 6, 15, "info")
                    end
                    case 6
                    gridsetcontent("gridinfo0", 4, 0, "    " & Unit[i], "info")
                    if(gridgetrowheight("gridinfo0", 4, "info") != 15)
                        gridsetrowheight("gridinfo0", 4, 15, "info")
                    end
                    case 7
                    gridsetcontent("gridinfo0", 8, 0, "    " & Unit[i], "info")
                    if(gridgetrowheight("gridinfo0", 8, "info") != 15)
                        gridsetrowheight("gridinfo0", 8, 15, "info")
                    end
                    case 8
                    gridsetcontent("gridinfo0", 2, 0, "    " & Unit[i], "info")
                    if(gridgetrowheight("gridinfo0", 2, "info") != 15)
                        gridsetrowheight("gridinfo0", 2, 15, "info")
                    end
                    case 9
                    gridsetcontent("gridinfo0", 10, 0, "    " & Unit[i], "info")
                    if(gridgetrowheight("gridinfo0", 10, "info") != 15)
                        gridsetrowheight("gridinfo0", 10, 15, "info")
                    end
                    case 10
                    gridsetcontent("gridinfo1", 5, 0, Unit[i], "info")
                    if(gridgetrowheight("gridinfo1", 5, "info") != 15)
                        gridsetrowheight("gridinfo1", 5, 15, "info")
                    end
                    case 11
                    gridsetcontent("gridinfo1", 3, 0, Unit[i], "info")
                    if(gridgetrowheight("gridinfo1", 3, "info") != 15)
                        gridsetrowheight("gridinfo1", 3, 15, "info")
                    end
                    case 12
                    gridsetcontent("gridinfo1", 7, 0, Unit[i], "info")
                    if(gridgetrowheight("gridinfo1", 7, "info") != 15)
                        gridsetrowheight("gridinfo1", 7, 15, "info")
                    end
                    case 13
                    gridsetcontent("gridinfo1", 1, 0, Unit[i], "info")
                    if(gridgetrowheight("gridinfo1", 1, "info") != 15)
                        gridsetrowheight("gridinfo1", 1, 15, "info")
                    end
                    case 14
                    gridsetcontent("gridinfo1", 9, 0, Unit[i], "info")
                    if(gridgetrowheight("gridinfo1", 9, "info") != 15)
                        gridsetrowheight("gridinfo1", 9, 15, "info")
                    end
                    case 15
                    gridsetcontent("gridinfo1", 6, 0, "    " & Unit[i], "info")
                    if(gridgetrowheight("gridinfo1", 6, "info") != 15)
                        gridsetrowheight("gridinfo1", 6, 15, "info")
                    end
                    case 16
                    gridsetcontent("gridinfo1", 4, 0, "    " & Unit[i], "info")
                    if(gridgetrowheight("gridinfo1", 4, "info") != 15)
                        gridsetrowheight("gridinfo1", 4, 15, "info")
                    end
                    case 17
                    gridsetcontent("gridinfo1", 8, 0, "    " & Unit[i], "info")
                    if(gridgetrowheight("gridinfo1", 8, "info") != 15)
                        gridsetrowheight("gridinfo1", 8, 15, "info")
                    end
                    case 18
                    gridsetcontent("gridinfo1", 2, 0, "    " & Unit[i], "info")
                    if(gridgetrowheight("gridinfo1", 2, "info") != 15)
                        gridsetrowheight("gridinfo1", 2, 15, "info")
                    end
                    case 19
                    gridsetcontent("gridinfo1", 10, 0, "    " & Unit[i], "info")
                    if(gridgetrowheight("gridinfo1", 10, "info") != 15)
                        gridsetrowheight("gridinfo1", 10, 15, "info")
                    end
                end
                Unitsave[i] = Unit[i]
            end
        end
    end
end
//TAB
function infotab_selectchange()
    var handle = controlgethandle("talkcombo0", "info")
    var sel = tabgetcursel("infotab", "info")
    if(sel == 2)
        windowshow(handle)
        windowsettop(handle, true)
        for(var i = 1; i < 5; i++)
            windowshow(scrollhwnd2[i])
        end
    else
        windowhide(handle)
        for(var i = 1; i < 5; i++)
            windowhide(scrollhwnd2[i])
        end
    end
    var itemhandle0 = controlgethandle("griditem0", "info")
    var itemhandle1 = controlgethandle("griditem1", "info")
    if(sel == 1)
        windowshow(itemhandle0)
        windowshow(itemhandle1)
        windowsettop(itemhandle0, true)
        windowsettop(itemhandle1, true)
    else
        windowhide(itemhandle0)
        windowhide(itemhandle1)
    end
    if(sel == 3)
        maillist = traverse(bchwnd, #00E8BBB0, 60, #074, 3, 50)
        for(var i = 0; i < 60; i++)
            if(maillist[i] != "")
                listdeletetext("maillist0", i, "info")
                listinserttext("maillist0", strformat("%s:%s", i + 1, maillist[i]), i, "info")
            else
                listdeletetext("maillist0", i, "info")
                listinserttext("maillist0", strformat("%s:-----", i + 1), i, "info")
            end
        end
        windowshow(scrollhwnd2[0])
    else
        windowhide(scrollhwnd2[0])
    end
end
//GAME_FONT_SIZE
function talkcombo3_selectchange()
    select(combogetcursel("talkcombo3", "info"))
        case 0
        wmint(bchwnd, #0072B9CC, 2, 2)
        case 1
        wmint(bchwnd, #0072B9CC, 2, 0)
        case 2
        wmint(bchwnd, #0072B9CC, 2, 1)
    end
end
//FONT_COLOR
function talkcombo2_selectchange()
    var colorcombo = combogetcursel("talkcombo2", "info")
    var color = 0
    select(colorcombo)
        case 0
        color = 0
        case 1
        color = 1
        case 2
        color = 2
        case 3
        color = 3
        case 4
        color = 5
        case 5
        color = 6
        case 6
        color = 7
        case 7
        color = 8
        case 8
        color = 9
        case 9
        color = 48
        case 10
        color = 49
        case 11
        color = 50
        case 12
        color = 51
        case 13
        color = 52
        case 14
        color = 53
        case 15
        color = 54
        case 16
        color = 55
        case 17
        color = 56
        case 18
        color = 57
        case 19
        color = 58
        case 20
        color = 59
    end
    wmint(bchwnd, #00613918, 0, color)
end
//讀對話歷史紀錄
function GetTalkHistory(HWND)
    var path = windowgetpath(bchwnd)
    path = strreplace(path, "bluecg.exe", "")
    var filepath = path & rmstring(HWND, #006136D4, 100)
    var ret = filereadex(filepath) 
    var dv	
    var size = strsplit(ret, "\r\n", dv)
    var listhwnd = controlgethandle("infotalkedit", "info")
    if(size != savetxsize)
        var TEXT = editgettext("infotalkedit", "info")
        TEXT = TEXT & strformat("%s\r\n", dv[size - 2])
        editsettext("infotalkedit", TEXT, "info")
        windowsendmessage(listhwnd, 277, 7, 0)
        savetxsize = size
    end
end
function infoarrang_click()
    var HWND = bchwnd
    BackpakeArrange(HWND)
    SetItemData(HWND)
end
//持有魔石價格計算
function itemvalue()
    var value = 0
    var infochk = array()
    var content = array()
    for(var i = 0; i < arraysize(itemName); i++)
        infochk[i] = regexmatchtext(itemName[i], "[(][0-9]{1,4}[G][)]")
        if(infochk[i] != "")
            content[i] = regexmatchtext(infochk[i][0], "[0-9]{1,4}")
            if(isint(content[i][0]))
                value = value + (content[i][0] * itemAmount[i])
            end
        end
    end
    return value
end
//發信
function SendTo_click()
    if(radiogetstate("inforideo0", "info"))
        SetNormalMail(bchwnd, listgetcursel("maillist0", "info"), editgettext("mailedit", "info"))
    elseif(radiogetstate("inforideo1", "info"))
    elseif(radiogetstate("inforideo2", "info"))
        SetPackageMail(bchwnd, listgetcursel("maillist0", "info"), combogetcursel("mailcombo1", "info"), combogetcursel("mailcombo0", "info"), editgettext("mailedit", "info"))
    end
end
function maillist0_selectchange()
    var sel = listgetcursel("maillist0", "info")
    //C84
    var value = #EEE60C + (#C80 * sel)
    maillcontent[sel] = traverse(bchwnd, value, 10, #0140, 3, 1000)
    editsettext("mailedit1", maillcontent[sel][0], "info")
    buttonsettext("SendTo", strformat("發信給 %s", maillist[sel]), "info")
end
function inforideo0_click()
    windowhide(controlgethandle("mailcombo0", "info"))
    windowhide(controlgethandle("mailcombo1", "info"))
end
function inforideo1_click()
    windowhide(controlgethandle("mailcombo0", "info"))
    windowhide(controlgethandle("mailcombo1", "info"))
end
function inforideo2_click()
    windowshow(controlgethandle("mailcombo0", "info"))
    windowshow(controlgethandle("mailcombo1", "info"))
    for(var i = 0; i < 5; i++)
        if(petname[i] != "")
            combodeletestring("mailcombo0", i, "info")
            comboinsertitem("mailcombo0", i, strformat("寵物%s:%s(%s)", i + 1, petname[i], petnickname[i]), "info")
        else
            combodeletestring("mailcombo0", i, "info")
            comboinsertitem("mailcombo0", i, strformat("寵物%s:-----", i + 1), "info")
        end
    end
    combosetcursel("mailcombo0", 0, "info")
    for(var i = 0; i < 20; i++)
        if(itemName[i] != "")
            combodeletestring("mailcombo1", i, "info")
            comboinsertitem("mailcombo1", i, strformat("物品%s:%s", i + 1, itemName[i]), "info")
        else
            combodeletestring("mailcombo1", i, "info")
            comboinsertitem("mailcombo1", i, strformat("物品%s:-----", i + 1), "info")
        end
    end
    combosetcursel("mailcombo1", 0, "info")
end
var autotalklistarray = array()
function talkb_click()
    var content = editgettext("talkedit", "info")
    if(content != "")
        listaddtext("talklist0", content, "info")
        arraypush(autotalklistarray, content)
        editsettext("talkedit", "", "info")
    end
    content = null
end
function talklist0_doubleclicked()
    var sel = listgetcursel("talklist0", "info")
    listdeletetext("talklist0", sel, "info")
    arrayclear(autotalklistarray)
    var size = listgetcount("talklist0", "info")
    for(var i = 0; i < size; i++)
        var content = listgettext("talklist0", i, "info")
        if(content != "")
            arraypush(autotalklistarray, content)
        end
    end
end
//自動喊話
function SetAutoTalk()
    var n = 0
    var HWND = bchwnd
    while(true)
        if(HWND > 0 && LoginPreCheck)
            if(n >= arraysize(autotalklistarray))
                n = 0
            end
            if(autotalklistarray[n] != "" && arraysize(autotalklistarray) > 0)
                bc.SendString2(HWND, autotalklistarray[n])
                bc.KeyPress(13)
            end
            n++
        end
        var tmp = talkdelay * 1000
        bc.Delay(tmp)
    end
    return false
end
var AutoTalkID = 0
var AutoTalkCheck = false
function autotalk_click()
    AutoTalkCheck = checkgetstate("autotalk", "info")
    if(AutoTalkCheck)
        AutoTalkID = threadbegin("SetAutoTalk", bchwnd)
    else
        threadclose(AutoTalkID, 1)
    end
end