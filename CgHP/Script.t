//腳本功能
var ScriptOnOff = false
var ScriptPath = "./Script/"
var ScriptFolderTmpPath = "./Script/"
var ScriptFolderTmp = ""
var Scriptcontent = ""
var ScriptSize = 0
var command_array = array()
var commandsize = 0
var ParamStringSize = array()
var param_array = array()
var Param = array()
var ScriptProcessID = 0
var WearSave_array = array()
var scriptdata_array = array()
//標記數組
var var_array = array()
//調用返回數組
var ReturnFlag_array = array()
//自訂變量數組
var varset_array = array()
var ScriptEventID = 0
var scriptsp = 150
var routesp = 350
////////////////////子腳本
var Scriptcontent2
var ScriptPath2
var ScriptSize2 = 0
var command_array2 = array()
var commandsize2 = 0
var ParamStringSize2 = array()
var param_array2 = array()
var Param2 = array()
var scriptdata_array2 = array()
//標記數組
var var_array2 = array()
//調用返回數組
var ReturnFlag_array2 = array()
//自訂變量數組
var varset_array2 = array()
function SetScriptRestoreVar()
    threadclose(ScriptProcessID)
    ScriptSize = 0
    command_array = array()
    commandsize = 0
    ParamStringSize = array()
    param_array = array()
    Param = array()
    WearSave_array = array()
    //標記數組
    var_array = array()
    //調用返回數組
    ReturnFlag_array = array()
    //自訂變量數組
    varset_array = array()
    ScriptEventID = 0
    scriptsp = 150
    routesp = 350
end
function SetSubScriptRestoreVar()
    ScriptSize2 = 0
    command_array2 = array()
    commandsize2 = 0
    ParamStringSize2 = array()
    param_array2 = array()
    Param2 = array()
    //標記數組
    var_array2 = array()
    //調用返回數組
    ReturnFlag_array2 = array()
    //自訂變量數組
    varset_array2 = array()
end
function button21_click()
    if(bchwnd > 0 && loginstate && LoginPreCheck)
        if(buttongettext("button21") == "開始")
            gridsetfocusitem("gridscript", 1, 1)
            ScriptProcessID = threadbegin("ScriptProcess", array(bchwnd, 1))
        else
            var row = 0, col = 0
            gridgetfocusitem("gridscript", row, col)
            ScriptProcessID = threadbegin("ScriptProcess", array(bchwnd, row))
        end
        if(threadgetstatus(ScriptProcessID))
            controlenable("button22", true)
            controlenable("button23", true)
            controlenable("button21", false)
            ScriptOnOff = true
        end
    end
end
function button23_click()
    SetScriptSuspend()
end
function SetScriptSuspend()
    if(buttongettext("button23") == "暫停")
        threadsuspend(ScriptProcessID)
        buttonsettext("button23", "繼續")
    else
        threadresume(ScriptProcessID)
        buttonsettext("button23", "暫停")
    end
end
function gridscript_clicked()
    var row = 0, col = 0
    gridgetfocusitem("gridscript", row, col)
    if(!ScriptOnOff)
        if(row == 1)
            buttonsettext("button21", "開始")
        elseif(row > 1)
            buttonsettext("button21", "中間開始")
        end
    end
end
function button22_click()
    SetScripStop()
end
function SetScripStop()
    buttonsettext("button21", "開始")
    if(buttongettext("button23") == "繼續")
        threadresume(ScriptProcessID)
        buttonsettext("button23", "暫停")
    end
    threadclose(ScriptProcessID, 1)
    arrayclear(varset_array)
    arrayclear(ReturnFlag_array)
    arrayclear(WearSave_array)
    controlenable("button22", false)
    controlenable("button23", false)
    controlenable("button21", true)
    ScriptOnOff = false
end
var nLine = 0
function SetScriptStatic(line)
    staticsettext("static35", strformat("正在運行行數: %d/%d", line, ScriptSize))
    gridsetselectrange("gridscript", line, 0, line, 2)
end
//讀取腳本
function LoadScript()
    scriptdata_array = array()
    SetScriptRestoreVar()
    buttonsettext("button21", "開始")
    var tmp
    var sz = strsplit(ScriptPath, "/", tmp)
    var SH = strfind(tmp[sz - 1], ".shs")
    if(SH > 0)
        //Scriptcontent = AESdecrypt(filereadex(ScriptPath))
        Scriptcontent = AESdecrypt(FileRead(ScriptPath))
    else
        //Scriptcontent = filereadex(ScriptPath)
        Scriptcontent = FileRead(ScriptPath)
    end
    scriptdata_array = array()
    ScriptSize = strsplit(Scriptcontent, "\r\n", command_array)
    for(var i = 0; i < ScriptSize; i++)
        if(command_array[i] == "")
            command_array[i] = "//"
        end
        scriptdata_array[i] = array()
        command_array[i] = strformat("%s %s", i + 1, command_array[i])
        command_array[i] = strtrim(command_array[i])
        //
        var tmpsz = strsplit(command_array[i], " ", param_array[i])
        if(tmpsz > 3 && isarray(param_array[i]))
            var vatmptmp = ""
            for(var j = 2; j < tmpsz; j++)
                vatmptmp = strformat("%s%s", vatmptmp, param_array[i][j])
            end
            param_array[i][2] = vatmptmp
        end
        //
        if(SH == -1)
            scriptdata_array[i]["行數"] = param_array[i][0]
            scriptdata_array[i]["指令"] = param_array[i][1]
            scriptdata_array[i]["內容"] = param_array[i][2]
        else
            scriptdata_array[i]["行數"] = param_array[i][0]
            scriptdata_array[i]["指令"] = "指令已加密"
            scriptdata_array[i]["內容"] = "內容隱藏"
        end
        //分割多个参数
        ParamStringSize[i] = strsplit(param_array[i][2], ",", Param[i])
    end
    if(isarray(param_array[0]))
        griddeleteall("gridscript")
        gridsetfixedsize("gridscript", 1, 0)
        gridfillarraydata("gridscript", scriptdata_array)
        gridsetcolwide("gridscript", 0, 40)
        gridsetcolwide("gridscript", 1, 85)
        gridsetcolwide("gridscript", 2, 175)
        for(var i = 0; i < ScriptSize; i++)
            if(i == 0)
                gridsetrowheight("gridscript", i, 18)
            end
            gridsetrowheight("gridscript", i, 18)
            for(var j = 0; j < 3; j++)
                gridsetreadonly("gridscript", i, j)
            end
        end
        windowsendmessage(controlgethandle("gridscript"), 277, 6, 0)
        for(var i = 0; i < ScriptSize; i++)
            if(isarray(param_array[i]))
                if(param_array[i][1] == "標記" || param_array[i][1] == "Function")
                    var_array[Param[i][0]] = i + 1
                end
            end
        end
        SetScriptStatic(0)
    end
end
function LoadSubScript(HWND, path)
    scriptdata_array2 = array()
    ScriptPath2 = strformat("%s%s", ScriptFolderTmpPath, path)
    staticsettext("static36", path)
    if(path != "")
        SetSubScriptRestoreVar()
        var tmp
        var sz = strsplit(ScriptPath2, "/", tmp)
        var SH = strfind(tmp[sz - 1], ".shs")
        if(SH > 0)
            Scriptcontent2 = AESdecrypt(FileRead(ScriptPath2))
        else
            Scriptcontent2 = FileRead(ScriptPath2)
        end
        ScriptSize2 = strsplit(Scriptcontent2, "\r\n", command_array2)
        for(var i = 0; i < ScriptSize2; i++)
            if(command_array2[i] == "")
                command_array2[i] = "//"
            end
            if(command_array2[i] != "")
                scriptdata_array2[i] = array()
                command_array2[i] = strformat("%s %s", i + 1, command_array2[i])
                command_array2[i] = strtrim(command_array2[i])
                //
                var tmpsz = strsplit(command_array2[i], " ", param_array2[i])
                if(tmpsz > 3 && isarray(param_array2[i]))
                    var vatmptmp = ""
                    for(var j = 2; j < tmpsz; j++)
                        vatmptmp = strformat("%s%s", vatmptmp, param_array2[i][j])
                    end
                    param_array2[i][2] = vatmptmp
                end
                if(param_array2[i][1] == "執行" || param_array2[i][1] == "執行Ex" || param_array2[i][1] == "Run" || param_array2[i][1] == "RunEx")
                    traceprint(param_array2[i][1])
                    param_array2[i][1] = "//"
                    param_array2[i][2] = "子腳本不可用執行命令"
                end
                //
                if(SH == -1)
                    scriptdata_array2[i]["行數"] = param_array2[i][0]
                    scriptdata_array2[i]["指令"] = param_array2[i][1]
                    scriptdata_array2[i]["內容"] = param_array2[i][2]
                else
                    scriptdata_array2[i]["行數"] = param_array2[i][0]
                    scriptdata_array2[i]["指令"] = "指令已加密"
                    scriptdata_array2[i]["內容"] = "內容隱藏"
                end
                //分割多个参数
                ParamStringSize2[i] = strsplit(param_array2[i][2], ",", Param2[i])
            end
        end
        if(isarray(param_array2[0]))
            griddeleteall("gridscript")
            gridsetfixedsize("gridscript", 1, 0)
            gridfillarraydata("gridscript", scriptdata_array2)
            gridsetcolwide("gridscript", 0, 40)
            gridsetcolwide("gridscript", 1, 85)
            gridsetcolwide("gridscript", 2, 175)
            for(var i = 0; i < ScriptSize2; i++)
                if(i == 0)
                    gridsetrowheight("gridscript", i, 18)
                end
                gridsetrowheight("gridscript", i, 18)
                for(var j = 0; j < 3; j++)
                    gridsetreadonly("gridscript", i, j)
                end
            end
            windowpostmessage(controlgethandle("gridscript"), 277, 6, 0)
            for(var i = 0; i < ScriptSize2; i++)
                if(isarray(param_array2[i]))
                    if(param_array2[i][1] == "標記" || param_array2[i][1] == "Function")
                        var_array2[Param2[i][0]] = i + 1
                    end
                end
            end
            SetScriptStatic(0)
            ScriptSubProcess(HWND)
        end
    end
end
function ScriptProcess(PARAMARRAY)
    var HWND = PARAMARRAY[0]
    var preline = -1
    if(PARAMARRAY[1] != null)
        preline = PARAMARRAY[1]
    end
    var ParamString = null, JempValue = 0
    var n = 0
    for(var i = 0; i < ScriptSize; i++)
        if(loginstate && LoginPreCheck)
            if(preline != -1)
                i = preline - 1
                preline = -1
            end
            if(isarray(param_array[i]))
                JempValue = SetScriptAnalysis(HWND, param_array[i][1], Param[i], i)
            end
            if(JempValue > 0)
                i = i + JempValue - 1
                n = 0
            elseif(JempValue < 0)
                i = i + JempValue - 1
                n = 0
            end
        else
            i = i - 1
        end
        bc.Delay(scriptsp)
    end
    threadbegin("SetScripStop", null)
end
function ScriptSubProcess(HWND)
    var ParamString = null, JempValue = 0
    var n = 0
    for(var i = 0; i < ScriptSize2; i++)
        if(loginstate && LoginPreCheck)
            if(isarray(param_array2[i]))
                JempValue = SetScriptAnalysis(HWND, param_array2[i][1], Param2[i], i)
            end
            if(JempValue > 0)
                i = i + JempValue - 1
                n = 0
            elseif(JempValue < 0)
                i = i + JempValue - 1
                n = 0
            end
        else
            i = i - 1
        end
        bc.Delay(scriptsp)
    end
    if(isarray(param_array[0]))
        gridfillarraydata("gridscript", scriptdata_array)
        for(var i = 0; i < ScriptSize; i++)
            if(i == 0)
                gridsetrowheight("gridscript", i, 18)
            end
            gridsetrowheight("gridscript", i, 18)
            for(var j = 0; j < 3; j++)
                gridsetreadonly("gridscript", i, j)
            end
        end
        staticsettext("static36", ScriptFolderTmp)
    end
end
function SetScriptAnalysis(HWND, command, param, line)
    if(!isarray(param))
        return false
    end
    SetScriptStatic(line + 1)
    nLine++
    if(nLine == 1)
        SetScollPos(line + 1)
        nLine = 0
    end
    if(strfind(command, "//") == 0)
        return 0
    end
    for(var i = 0; i < arraysize(param); i++)
        if(strfind(param[i], "?") == 0 && strlen(param[i]) > 1)
            var tmp = strcut(param[i], 1, true)
            param[i] = varset_array[tmp]
        end
    end
    //traceprint(strformat("%s %s,%s", command, param, line))
    select(command)
        case "坐標"
        SetMovement(HWND, param[0], param[1])
        case "座標"
        SetMovement(HWND, param[0], param[1])
        case "MoveTo"
        SetMovement(HWND, param[0], param[1])
        case "移動"
        if(isint(param[0]) && isint(param[1]))
            SetRouteEx(HWND, param[0], param[1])
        end
        case "MoveToEx"
        if(isint(param[0]) && isint(param[1]))
            SetRouteEx(HWND, param[0], param[1])
        end
        case "尋路"
        if(isint(param[0]) && isint(param[1]))
            SetRoute(array(HWND, param[0], param[1]))
        end
        case "FindRoute"
        if(isint(param[0]) && isint(param[1]))
            SetRoute(array(HWND, param[0], param[1]))
        end
        case "查坐標"
        if(isint(param[0]) && isint(param[1]))
            return GetLocate(param[0], param[1], param[2], line)
        end
        case "查座標"
        if(isint(param[0]) && isint(param[1]))
            return GetLocate(param[0], param[1], param[2], line)
        end
        case "CheckLocate"
        if(isint(param[0]) && isint(param[1]))
            return GetLocate(param[0], param[1], param[2], line)
        end
        case "方向"
        SetDirection(HWND, param[0])
        case "Dir"
        SetDirection(HWND, param[0])
        case "對話"
        case "CheckConver"
        case "按鈕"
        SetButtonPress(HWND, param[0], param[1])
        case "Press"
        SetButtonPress(HWND, param[0], param[1])
        case "設置"
        Set(HWND, command, param[0])
        case "Set"
        Set(HWND, command, param[0])
        case "取消"
        Set(HWND, command, param[0])
        case "cancel"
        Set(HWND, command, param[0])
        case "延時"
        if(param[0] != "" && isint(param[0]))
            bc.Delay(param[0])
        end
        case "Delay"
        if(param[0] != "" && isint(param[0]))
            bc.Delay(param[0])
        end
        case "地圖"
        return GetMapInfo(HWND, command, param[0], param[1], line)
        case "CheckMap"
        return GetMapInfo(HWND, command, param[0], param[1], line)
        case "地圖快判"
        return GetMapInfo(HWND, command, param[0], param[1], line)
        case "CheckMapEx"
        return GetMapInfo(HWND, command, param[0], param[1], line)
        case "行數"
        return param[0]
        case "SetLine"
        return param[0]
        case "戰鬥中"
        return IsCombat(param[0], line)
        case "IsCombat"
        return IsCombat(param[0], line)
        case "人物狀態"
        return GetChampState(param[0], param[1], param[2])
        case "CmpStatus"
        return GetChampState(param[0], param[1], param[2])
        case "背包滿"
        return GetBackpackState(param[0], line)
        case "IsFull"
        return GetBackpackState(param[0], line)
        case "回點"
        ReturnBase(HWND)
        case "ReturnBase"
        ReturnBase(HWND)
        case "登出"
        LogOut(HWND)
        case "Logout"
        LogOut(HWND)
        case "OC"
        OC(param[0], param[1])
        case "OCEX"
        OCEX(param[0], param[1], param[2])
        case "消息"
        msgbox(strformat("%s%s%s%s%s%s", param[0], param[1], param[2], param[3], param[4], param[5]), 1)
        case "MsgBox"
        msgbox(strformat("%s%s%s%s%s%s", param[0], param[1], param[2], param[3], param[4], param[5]), 1)
        case "結束"
        threadbegin("SetScripStop", null)
        case "End"
        threadbegin("SetScripStop", null)
        case "暫停"
        threadbegin("SetScriptSuspend", null)
        case "Suspend"
        threadbegin("SetScriptSuspend", null)
        case "組隊"
        case "輸入"
        SendString(HWND, param[0], 0, param[1])
        case "Printf"
        SendString(HWND, param[0], 0, param[1])
        case "說出"
        SendString(HWND, param[0], 1, param[1])
        case "Output"
        SendString(HWND, param[0], 0, param[1])
        case "使用道具"
        if(param[1] == "")
            param[1] = -1
        end
        if(param[2] == "")
            param[2] = 0
        end
        SetUseItem(HWND, param[0], param[1], param[2])
        case "UseItem"
        if(param[1] == "")
            param[1] = -1
        end
        if(param[2] == "")
            param[2] = 0
        end
        SetUseItem(HWND, param[0], param[1], param[2])
        case "變數"
        SetVar(param[0], param[1], param[2])
        case "Var"
        SetVar(param[0], param[1], param[2])
        case "判斷變數"
        return GetVarCompare(param[0], param[1], param[2], param[3], line)
        case "CmpVar"
        return GetVarCompare(param[0], param[1], param[2], param[3], line)
        case "整理"
        BackpakeArrange(HWND)
        case "Arrange"
        BackpakeArrange(HWND)
        case "標記"
        //traceprint("標記所在位置: " & var_array[param[0]])
        case "跳轉"
        var jmp = var_array[param[0]] - line
        return jmp
        case "Jmp"
        var jmp = var_array[param[0]] - line
        return jmp
        case "調用"
        ReturnFlag_array[param[0]] = line
        var jmp = var_array[param[0]] - line
        return jmp
        case "Call"
        ReturnFlag_array[param[0]] = line
        var jmp = var_array[param[0]] - line
        return jmp
        case "返回"
        var linechange = 0
        arraypop(ReturnFlag_array, linechange)
        var jmp = linechange - line + 1  
        return jmp
        case "Return"
        var linechange = 0
        arraypop(ReturnFlag_array, linechange)
        var jmp = linechange - line + 1  
        return jmp
        case "執行"
        LoadSubScript(HWND, param[0])
        case "Run"
        LoadSubScript(HWND, param[0])
        case "執行Ex"
        case "RunEx"
        case "尋找最近樓梯"
        GetStairPos(HWND)
        case "FindStair"
        GetStairPos(HWND)
        case "左擊"
        bc.MoveTo(param[0], param[1])
        bc.LeftClick()
        case "LBUTTONCLICK"
        bc.MoveTo(param[0], param[1])
        bc.LeftClick()
        case "左按下"
        bc.LeftDown()
        case "LBUTTONDOWN"
        bc.LeftDown()
        case "左彈起"
        bc.LeftUp()
        case "LBUTTONUP"
        bc.LeftUp()
        case "左雙擊"
        bc.MoveTo(param[0], param[1])
        bc.LeftDoubleClick()
        case "LBUTTONDBLCLK"
        bc.MoveTo(param[0], param[1])
        bc.LeftDoubleClick()
        case "右擊"
        bc.MoveTo(param[0], param[1])
        bc.RightClick()
        case "RBUTTONCLICK"
        bc.MoveTo(param[0], param[1])
        bc.RightClick()
        case "滾下"
        bc.WheelDown()
        case "MOUSEWHEELDOWN"
        bc.WheelDown()
        case "滾上"
        bc.WheelUp()
        case "MOUSEWHEELUP"
        bc.WheelUp()
        case "道具有"
        GetItemExist(param[0])
        case "IsItemExist"
        GetItemExist(param[0])
        case "道具數量"
        return GetItemQuantity(param[0], param[1], param[2], param[3], line)
        case "CmpItemQua"
        return GetItemQuantity(param[0], param[1], param[2], param[3], line)
        case "道具"
        return GetItemState(param[0], param[1], param[2], param[3], line)
        case "IsItemExistEx"
        return GetItemState(param[0], param[1], param[2], param[3], line)
        case "允許開關"
        SetSwitcher(param[0], param[1])
        case "SetSwitch"
        SetSwitcher(param[0], param[1])
        case "KNPC"
        KNPC(HWND, param[0])
        case "提示"
        PushAnnounce(HWND, strformat("<腳本提示>%s%s%s%s%s%s", param[0], param[1], param[2], param[3], param[4], param[5]))
        case "SetAnnounce"
        PushAnnounce(HWND, strformat("<腳本提示>%s%s%s%s%s%s", param[0], param[1], param[2], param[3], param[4], param[5]))
        case "清屏"
        bc.KeyPress(36)
        var path = windowgetpath(HWND)
        path = strreplace(path, "bluecg.exe", "")
        var filepath = path & rmstring(HWND, #006136D4, 100)
        filewriteex(filepath, "")
        case "Clear"
        bc.KeyPress(36)
        var path = windowgetpath(bchwnd)
        path = strreplace(path, "bluecg.exe", "")
        var filepath = path & rmstring(HWND, #006136D4, 100)
        filewriteex(filepath, "")
        case "切換分流"
        case "記錄身上裝備"
        RecordWear(HWND)
        case "RecordEquip"
        RecordWear(HWND)
        case "檢測記錄裝備"
        GetWearState(HWND, param[0], line)
        case "CheckEquip"
        GetWearState(HWND, param[0], line)
        case "裝上記錄裝備"
        WearRecordWear(HWND)
        case "SetEquip"
        WearRecordWear(HWND)
        case "存入道具"
        SetItemDeposit(HWND, param[0], param[1], param[2])
        case "ItemDeposit"
        SetItemDeposit(HWND, param[0], param[1], param[2])
        case "提出道具"
        SetItemWithdraw(HWND, param[0], param[1])
        case "ItemLoad"
        SetItemWithdraw(HWND, param[0], param[1])
        case "更換寵物"
        SetPetPos(HWND, param[0], param[1])
        case "SetPetPos"
        SetPetPos(HWND, param[0], param[1])
        case "寵物郵件"
        SetPackageMail(HWND, param[0] - 1, GetItemPos(param[1]), param[2] - 1, param[3])
        case "SendPackage"
        SetPackageMail(HWND, param[0] - 1, GetItemPos(param[1]), param[2] - 1, param[3])
        case "生產"
        SetMake(HWND, param[0], param[1], param[2])
        case "裝飾"
        GetMakingScreenEx(HWND)
        case "MakeDec"
        GetMakingScreenEx(HWND)
        case "交名"
        hotkeybutton(186)
        case "CardExchange"
        hotkeybutton(186)
        case "PK"
        hotkeybutton(74)
        case "聽見"
        return ConversationDetect(HWND, param[0], param[1], param[2], line)
        case "DialogDetect"
        return ConversationDetect(HWND, param[0], param[1], param[2], line)
        case "治療"
        if(param[0] >= 0 && param[0] <= 5)
            SetUseNormalSkill(HWND, param[0])
        end
        case "Treat"
        if(param[0] >= 0 && param[0] <= 5)
            SetUseNormalSkill(HWND, param[0])
        end
        case "急救"
        if(param[0] >= 0 && param[0] <= 5)
            SetUseNormalSkill(HWND, param[0])
        end
        case "Heal"
        if(param[0] >= 0 && param[0] <= 5)
            SetUseNormalSkill(HWND, param[0])
        end
        case "採集"
        SetCollect(HWND, param[0])
    end
    return 0
end
function SetMake(HWND, type, targetname, ingre)
    for(var i = 0; i < 14; i++)
        if(skillname[i] == type)
            if(isint(targetname))
                GetMakingScreen(HWND, targetname - 1, i)
                bc.Delay(100)
                return MakeProcess(HWND, ingre, i)
            end
            //traceprint(skillname[i])
            var productname = traverse(HWND, #00E8DFE8 + (i * #4C4C), 50, #134, 3, 100)
            for(var j = 0; j < 50; j++)
                if(productname[j] == targetname)
                    //traceprint(strformat("%s:%s", productname[j], targetname))
                    GetMakingScreen(HWND, j, i)
                    bc.Delay(100)
                    return MakeProcess(HWND, ingre, i)
                end
            end
        end
    end
    PushAnnounce(HWND, "<系統提示>所填寫技能名不存在/技能格錯誤或尚未學習該技能。")
    return false
end
function MakeProcess(HWND, ingre, sk)
    GetSkilExpInfo(HWND)
    var tmpexp = skillexp[sk]
    var intX, intY
    while(ingre != "")
        bc.FindPic(0, 0, 640, 480, "cookclose.bmp", "3892a9", 0.9, 0, intX, intY)
        //traceprint(strformat("%d,%d", intX, intY))
        if(intX > 0 && intY > 0)
            var re = SetItemPos(HWND, ingre, intX, intY)
            if(!re)
                return -1
            end
            while(re)
                bc.Delay(1000)
                var ret = press("retrycook", 1)
                if(ret)
                    break
                end
            end
            GetSkilExpInfo(HWND)
            var tmpexp2 = skillexp[sk]
            var tmpdiff = tmpexp2 - tmpexp
            PushAnnounce(HWND, strformat("本次生產獲得經驗:%d 升級剩餘:%d", tmpdiff, expdifferance[sk]))
            tmpexp2 = null
            tmpexp2 = null
            tmpdiff = null
            return true
        end
        bc.Delay(100)
    end
    return -1
end
function SetCollect(HWND, name)
    var collectskill_array = array("狩獵", "伐木", "剪取", "挖掘")
    for(var i = 0; i < 4; i++)
        if(collectskill_array[i] == name)
            for(var j = 0; j < 14; j++)
                if(skillname[j] == name)
                    name = null
                    GetCollectionScreen(HWND, j)
                    collectskill_array = null
                    return false
                end
            end
        end
    end
    collectskill_array = null
    PushAnnounce(HWND, "<系統提示>所填寫技能不存在或尚未學習該技能。")
end
function SetPetPos(HWND, type, pos)
    var petpos = GetPetPos(HWND)
    select(type)
        case "戰鬥"
        LockPetPos0(HWND, pos - 1)
        case "1"
        LockPetPos0(HWND, pos - 1)
        case "休息"
        if(petpos == pos - 1)
            LockPetPos0(HWND, pos - 1)
            wmint(HWND, #00C462C8, 0, 255)
        end
        case "0"
        if(petpos == pos - 1)
            LockPetPos0(HWND, pos - 1)
            wmint(HWND, #00C462C8, 0, 255)
        end
        case "騎乘"
        LockPetPos1(HWND, pos - 1)
        case "2"
        LockPetPos1(HWND, pos - 1)
    end
end
function ConversationDetect(HWND, area, content, jump, line)
    if(area > 0)
        var path = windowgetpath(HWND)
        path = strreplace(path, "bluecg.exe", "")
        var filepath = path & rmstring(HWND, #006136D4, 100)
        var ret = filereadex(filepath) 
        var dv	
        var size = strsplit(ret, "\r\n", dv)
        for(var i = 0; i < area + 1; i++)
            if(strfind(dv[size - 2 - i], content) != -1 && content != "" && dv[size - 2 - i] != "")
                return 0
            end
        end
        return Goto(jump, line)
    else
        return 0
    end
end
function SetItemDeposit(HWND, content, type = 0, amount = -1)
    var spotarray = GetItemPosEx(content, type, amount)
    var tmp = array()
    if(arraysize(spotarray) > 0 && !combatstate)
        BankItemExist = traverse(HWND, #00C46348, 20, #0C44, 2, 100)
        BankItemName = traverse(HWND, #00C46354, 20, #0C44, 3, 100)
        for(var j = 19; j > -1; j--)
            if(BankItemExist[j] == 0 && BankItemName[j] == "")
                arraypush(tmp, j)
            end
        end
        for(var i = 0; i < arraysize(spotarray); i++)
            if(arraysize(tmp) > 0 && !combatstate)
                if(itemName[spotarray[i]] != "")
                    var value = 0
                    arraypop(tmp, value)
                    SetDepositBank(HWND, spotarray[i], value)
                    PushAnnounce(HWND, strformat("存入道具 %s x %s", itemName[spotarray[i]], itemAmount[spotarray[i]]))
                end
            else
                select(rmint(HWND, #00CD91D0, 0))
                    case 0
                    SetBankPage(HWND, 1)
                    case 1
                    SetBankPage(HWND, 0)
                end
                bc.Delay(1000)
                spotarray = GetItemPosEx(content, type, amount)
                BankItemExist = traverse(HWND, #00C46348, 20, #0C44, 2, 100)
                BankItemName = traverse(HWND, #00C46354, 20, #0C44, 3, 100)
                for(var j = 19; j > -1; j--)
                    if(BankItemExist[j] == 0 && BankItemName[j] == "")
                        arraypush(tmp, j)
                    end
                end
                if(arraysize(tmp) > 0 && !combatstate)
                    if(itemName[spotarray[i]] != "")
                        var value = 0
                        arraypop(tmp, value)
                        SetDepositBank(HWND, spotarray[i], value)
                        PushAnnounce(HWND, strformat("存入道具 %s x %s", itemName[spotarray[i]], itemAmount[spotarray[i]]))
                    end
                else
                    break
                end
            end
        end
    else
        bc.Delay(500)
        PushAnnounce(HWND, strformat("要存入的道具 %s 不存在", content))
    end
    for(var i = 0; i < 20; i++)
        BankItemName[i] = ""
        BankItemExist[i] = 0
    end
end
function SetItemWithdraw(HWND, content, type = 0)
    var spotarray = GetBankItemPos(HWND, content, type)
    var tmp = array()
    if(arraysize(spotarray) > 0 && !combatstate)
        for(var j = 19; j > -1; j--)
            if(itemExist[j] == 0 && itemName[j] == "")
                arraypush(tmp, j)
            end
        end
        for(var i = 0; i < arraysize(spotarray); i++)
            if(arraysize(tmp) > 0 && !combatstate)
                if(BankItemName[spotarray[i]] != "")
                    var value = 0
                    arraypop(tmp, value)
                    SetBankWithdraw(HWND, spotarray[i], value)
                    PushAnnounce(HWND, strformat("提出道具 %s", BankItemName[spotarray[i]]))
                    BankItemName[spotarray[i]] = ""
                end
            end
        end
    end
    bc.Delay(300)
    select(rmint(HWND, #00CD91D0, 0))
        case 0
        SetBankPage(HWND, 1)
        case 1
        SetBankPage(HWND, 0)
    end
    bc.Delay(1000)
    spotarray = GetBankItemPos(HWND, content, type)
    tmp = array()
    if(arraysize(spotarray) > 0 && !combatstate)
        for(var j = 19; j > -1; j--)
            if(itemExist[j] == 0 && itemName[j] == "")
                arraypush(tmp, j)
            end
        end
        for(var i = 0; i < arraysize(spotarray); i++)
            if(arraysize(tmp) > 0 && !combatstate)
                if(BankItemName[spotarray[i]] != "")
                    var value = 0
                    arraypop(tmp, value)
                    SetBankWithdraw(HWND, spotarray[i], value)
                    PushAnnounce(HWND, strformat("提出道具 %s", BankItemName[spotarray[i]]))
                    BankItemName[spotarray[i]] = ""
                end
            else
                break
            end
        end
    else
        PushAnnounce(HWND, strformat("要提出的道具 %s 不存在", content))
    end
    for(var i = 0; i < 20; i++)
        BankItemName[i] = ""
        BankItemExist[i] = 0
    end
end
function SetVar(subcommand, variable, content = 0)
    select(subcommand)
        case "設置"
        if(content == "?")
            var value = InputBox(variable)
            varset_array[variable] = value
            traceprint(varset_array[variable])
        else
            varset_array[variable] = content
        end
        case "Set"
        if(content == "?")
            var value = InputBox(variable)
            varset_array[variable] = value
            traceprint(varset_array[variable])
        else
            varset_array[variable] = content
        end
        case "取消"
        arraydeletekey(varset_array, variable)
        case "Cancel"
        arraydeletekey(varset_array, variable)
        case "清空"
        arrayclear(varset_array)
        case "Clear"
        arrayclear(varset_array)
        case "加減"
        varset_array[variable] = varset_array[variable] + content
        case "Calculate"
        varset_array[variable] = varset_array[variable] + content
    end
end
function GetVarCompare(variable, logic, value, jump, line)
    if(isint(value))
        select(logic)
            case ">="
            if(varset_array[variable] >= value)
                return Goto(jump, line)
            end
            case "<="
            if(varset_array[variable] >= value)
                return Goto(jump, line)
            end
            case "=="
            if(varset_array[variable] == value)
                return Goto(jump, line)
            end
            case ">"
            if(varset_array[variable] > value)
                return Goto(jump, line)
            end
            case "<"
            if(varset_array[variable] < value)
                return Goto(jump, line)
            end
            case "!="
            if(varset_array[variable] != value)
                return Goto(jump, line)
            end
        end
    end
    return 0
end
function Goto(jump, line)
    if(isint(jump))
        return jump
    else
        //traceprint("標記 " & jump & " 行數: " & linechange)
        return var_array[jump] - line
    end
end
function SetMapLoad(mapnum)
    mf.A(strformat("%sCgHP\\Map\\%s.bmp", sysgetpath(5), mapnum), AESdecrypt("5dc70124eb15677177f22a4c8a4bbd8d5aa123061b703446fddc506e8f8e6042"))
    if(mf.checkMap(cstring(mapnum)) == 1)
        //traceprint("地圖: " & mapnum & " 讀取完成")
        return true
    else
        //traceprint("地圖: " & mapnum & " 讀取失敗")
        return false
    end
end
function SetRoute(XYarray)
    if(!combatstate && loginstate)
        var tmp = bc.GetTime()
        var HWND = XYarray[0]
        var disx = XYarray[1]
        var disy = XYarray[2]
        if(east == disx && south == disy)
            PushAnnounce(HWND, "<尋路>已到達目的地。")
            return false
        end
        var mapID = GetMapID(HWND)
        var result = SetMapLoad(mapID)
        if(result)
            var East = int(rmfloat(HWND, #0095C88C) / 64)
            var South = int(rmfloat(HWND, #0095C890) / 64)
            var A = mf.FindPath(East, South, disx, disy, 0, 1)
            var precod = null
            if(A != -1)
                strsplit(A, ",", precod)
                var tmp2 = bc.GetTime()
                PushAnnounce(HWND, strformat("<尋路>成功找到路徑(%d,%d,%d步)，耗時：%d", disx, disy, precod[2], (tmp2 - tmp)))
                if(precod[2] <= 10)
                    SetMovement(HWND, disx, disy)
                    bc.Delay(2000)
                end
            else
                PushAnnounce(HWND, "<尋路>找不到路徑、地圖缺失或坐標無法到達。") 
                return false
            end
            while(East != disx || South != disy)
                if(!combatstate && loginstate)
                    East = int(rmfloat(HWND, #0095C88C) / 64)
                    South = int(rmfloat(HWND, #0095C890) / 64)
                    var B = mf.FindPath(East, South, disx, disy, 0, 1)
                    //traceprint(B)
                    var cod = null
                    strsplit(B, ",", cod)
                    if(B != -1)
                        SetMovement(HWND, cod[0], cod[1])
                    else
                        SetMapLoad(mapID)
                        return false
                    end
                end
                bc.Delay(routesp)
            end
            if(East == disx && South == disy)
                PushAnnounce(HWND, "<尋路>已到達目的地。") 
            end
        end
    end
    return false
end
function SetRouteEx(HWND, disx, disy)
    if(!combatstate && loginstate)
        var XYarray = array(disx, disy, bchwnd)
        SetMovementEx(XYarray)
    end
end
function SetDirection(HWND, dir)
    select(dir)
        case "北"
        SetFaceDirection(HWND, 0)
        case "東北"
        SetFaceDirection(HWND, 1)
        case "東"
        SetFaceDirection(HWND, 2)
        case "東南"
        SetFaceDirection(HWND, 3)
        case "南"
        SetFaceDirection(HWND, 4)
        case "西南"
        SetFaceDirection(HWND, 5)
        case "西"
        SetFaceDirection(HWND, 6)
        case "西北"
        SetFaceDirection(HWND, 7)
        //
        //
        case "N"
        SetFaceDirection(HWND, 0)
        case "EN"
        SetFaceDirection(HWND, 1)
        case "E"
        SetFaceDirection(HWND, 2)
        case "ES"
        SetFaceDirection(HWND, 3)
        case "S"
        SetFaceDirection(HWND, 4)
        case "WS"
        SetFaceDirection(HWND, 5)
        case "W"
        SetFaceDirection(HWND, 6)
        case "WN"
        SetFaceDirection(HWND, 7)
    end
end
function GetLocate(x, y, jump, line)
    if(x != east || y != south)
        return Goto(jump, line)
    else
        return 0
    end
end
function GetMapInfo(HWND, command, num, jump, line)
    var mapID = GetMapID(HWND)
    var map = GetMap(HWND)
    if(command == "地圖" || command == "CheckMap")
        SetMapLoad(mapID)
        bc.Delay(1000)
    end
    var type = isint(num)
    if(num != mapID && type)
        return Goto(jump, line)
    elseif(num != map && !type)
        return Goto(jump, line)
    elseif(num == mapID && type || num == map && !type)
        return 0
    else
        return Goto(jump, line)
    end
end
function IsCombat(jump, line)
    if(combatstate)
        return Goto(jump, line)
    else
        return 0
    end
end
function SendString(HWND, content, type = 0, channel = "")
    if(channel == "家" || channel == "GUILD")
        content = "[GUILD]" & content
    end
    bc.SendString2(HWND, content)
    if(type == 1)
        bc.KeyPress(13)
    end
end
function KNPC(HWND, type)
    select(type)
        case "護士"
        NPC_hospital(HWND)
        case "0"
        NPC_hospital(HWND)
        case "領恢"
        NPC_recover(HWND)
        case "1"
        NPC_recover(HWND)
        case "商賣"
        NPC_sellitem(HWND)
        case "2"
        NPC_sellitem(HWND)
    end
    bc.Delay(1000)
end
function GetItemExist(name)
    for(var i = 0; i < 20; i++)
        var key = strfind(itemName[i], name)
        if(key != -1 && itemExist[i] > 0)
            return 0
        end
    end
    return -1
end
function GetItemQuantity(name, logic, value, jump, line)
    var count = 0
    var tmp = 0
    for(var j = 0; j < 20; j++)
        if(itemName[j] == name && itemExist[j] > 0)
            tmp = itemAmount[j]
            if(tmp == 0)
                tmp = 1
            end
            count = count + tmp
        end
    end
    if(count != 0)
        return  CmpItemQuantity(logic, count, value, jump, line)
    end
    return 0
end
function CmpItemQuantity(logic, count, value, jump, line)
    select(logic)
        case "!="
        if(count != value)
            return Goto(jump, line)
        end
        case "=="
        if(count == value)
            return Goto(jump, line)
        end
        case ">="
        if(count >= value)
            return Goto(jump, line)
        end
        case "<="
        if(count <= value)
            return Goto(jump, line)
        end
        case ">"
        if(count > value)
            return Goto(jump, line)
        end
        case "<"
        if(count < value)
            return Goto(jump, line)
        end
    end
end
function GetItemState(spot, name, jump, searchtype, line)
    if(spot == "?")
        if(searchtype == 1)
            if(arrayfindvalue(itemName, name) != "")
                return 0
            else
                return Goto(jump, line)
            end
        end
        for(var j = 0; j < 20; j++)
            if(strfind(itemName[j], name) != -1)
                return 0
            end
        end
        return Goto(jump, line)
    end
    if(strfind(spot, "-") >= 0)
        var spt
        strsplit(spot, "-", spt)
        for(var p = (spt[0] - 1); p < spt[1]; p++)
            if(itemName[p - 1] == name && itemExist[p - 1] > 0)
                return 0
            end
        end
        return Goto(jump, line)
    end
    if(itemName[spot - 1] == name && itemExist[spot - 1] > 0)
        return 0
    else
        return Goto(jump, line)
    end
end
function GetChampState(type, logic, value)
    var con = StatusType(type)
    select(logic)
        case "!="
        if(con != value)
            return 0
        end
        case "=="
        if(con == value)
            return 0
        end
        case ">="
        if(con >= value)
            return 0
        end
        case "<="
        if(con <= value)
            return 0
        end
        case ">"
        if(con > value)
            return 0
        end
        case "<"
        if(con < value)
            return 0
        end
    end
    return -1
end
function StatusType(type)
    select(type)
        case "HP"
        return mainHP
        case "MAXHP"
        return mainMAXHP
        case "HP百分比"
        return GetPercentage(mainHP, mainMAXHP)
        case "HPPercent"
        return GetPercentage(mainHP, mainMAXHP)
        case "MP"
        return mainMP
        case "MAXMP"
        return mainMAXMP
        case "MP百分比"
        return GetPercentage(mainMP, mainMAXMP)
        case "MPPercent"
        return GetPercentage(mainMP, mainMAXMP)
        default
        return 0
    end
end
function GetBackpackState(jump, line, type = 0)
    var count = 0
    for(var i = 0; i < 20; i++)
        if(itemExist[i] > 0 && itemName[i] != "")
            count++
        end
    end
    if(count >= 20 && loginstate && !combatstate && LoginPreCheck)
        if(type == 0)
            return Goto(jump, line)
        else
            return 1
        end
    else
        return 0
    end
end
function SetUseItem(HWND, name, target = -1, type = 0)
    if(!combatstate)
        //traceprint(strformat("%s %s", name, target))
        var spot = -1
        for(var i = 0; i < 20; i++)
            if(itemExist[i] > 0 && strfind(itemName[i], name) != -1 && type == 0)
                spot = i
                break
            elseif(itemExist[i] > 0 && itemName[i] == name && type == 1)
                spot = i
                break
            end
        end
        if(spot != -1)
            if(target >= 0)
                //traceprint(1)
                UseItemSuper(HWND, spot, target)
            else
                //traceprint(0)
                UseItem(HWND, spot)
            end
        end
    end
end
function SetButtonPress(HWND, pm, type = 0)
    if(type == 1)
        return PressButton(HWND, pm)
    end
    select(pm)
        case "是"
        PressButton(HWND, "是")
        case "Yes"
        PressButton(HWND, "是")
        //press("yes", 1)
        case "否"
        PressButton(HWND, "否")
        //press("no", 1)
        case "No"
        PressButton(HWND, "否")
        case "確定"
        press("OK", 1)
        case "OK"
        press("OK", 1)
        case "取消"
        press("cancel", 1)
        case "Cancel"
        press("cancel", 1)
        case "全部"
        press("all", 1)
        case "All"
        press("all", 1)
        case "買"
        FindString("買")
        case "Buy"
        FindString("買")
        case "賣"
        FindString("賣")
        case "Sell"
        FindString("賣")
        case "不用了"
        PressButton(HWND, 0)
        case "Nope"
        PressButton(HWND, 0)
        case 1
        press(1, 0)
        case 2
        press(2, 0)
        case 3
        press(3, 0)
        case "物品"
        hotkeybutton(69)
        case "技能"
        hotkeybutton(87)
        case "上一頁"
        press("pgup", 1)
        case "下一頁"
        press("pgdn", 1)
        case "重試"
        var z = press("retrycook", 1)
        if(!z)
            press("retry", 1)
        end
        case "Retry"
        var z = press("retrycook", 1)
        if(!z)
            press("retry", 1)
        end
        case "關閉"
        press("close", 1)
        case "Close"
        press("close", 1)
        default
        FindString(pm)
    end
end
function hotkeybutton(key)
    bc.KeyDown(17)
    bc.Delay(100)
    bc.KeyPress(key)
    bc.KeyUp(17)
    bc.KeyPress(8)
end
function Set(HWND, command, pm)
    var bool = false
    if(command == "設置" || command == "Set")
        bool = true
    else
        bool = false
    end
    var control = ""
    select(pm)
        case "走路遇敵"
        control = "check24"
        checksetstate(control, bool)
        if(!checkgetstate("check24"))
            threadclose(AutoWalkID, 1)
            threadbegin("SetMovementEx", array(east, south, bchwnd))
        else
            if(!threadgetstatus(AutoWalkID))
                threadclose(AutoWalkExID, 1)
                bc.WriteDataAddr(HWND, #00462EA2, "E8 89 10 00 00")
                AutoWalkID = threadbegin("AutoWalk", HWND)
            end
        end
        return false
        case "自動組隊"
        control = "check11"
        case "自動丟棄"
        control = "check21"
        case "快速遇敵"
        control = "check29"
        checksetstate(control, bool)
        checksetstate("check24", false)
        SuperAutoWalk(HWND)
        return false
        case "自動逃跑"
        control = "check27"
        case "自動捉寵"
        control = "check26"
        case "鎖定攻擊"
        control = "check31"
        case "鎖定逃跑"
        control = "check32"
        case "自動KNPC"
        control = "check22"
        case "登入成功後自動重新開始走路遇敵"
        control = "check45"
        case "鎖定一般動作技能為當前最高等級"
        control = "check47"
        case "戰鬥後顯示經驗信息"
        control = "check46"
        case "KNPC護士"
        control = "check49"
        case "KNPC原恢"
        control = "check48"
        case "KNPC商賣"
        control = "check50"
        case "非鎖定攻擊目標不逃跑"
        control = "check39"
        case "每回合延時"
        control = "check37"
        case "技能等級對應敵人數目"
        control = "check35"
        case "隨機目標"
        control = "check36"
        case "道具技"
        control = "check34"
        checksetstate(control, bool)
        return false
        case "快速走路"
        control = "check16"
        case "隨機路線"
        control = "check53"
        case "隨身倉庫"
        SetBankPageOn(HWND)
        bc.Delay(200)
        return false
        default
        return false
    end
    checksetstate(control, bool)
    control = null
    return false
end
function SetSwitcher(type, value)
    var control = ""
    select(type)
        case "組隊"
        control = "switch2"
        case "決鬥"
        control = "switch0"
        case "交名"
        control = "switch3"
        case "交易"
        control = "switch4"
        case "家族"
        control = "switch5"
        case "聊天"
        control = "switch1"
        default
        return false
    end
    var state = checkgetstate(control)
    if(value == 1)
        if(!state)
            SetSwitcherEx(type)
        end
    elseif(value == 0)
        if(state)
            SetSwitcherEx(type)
        end
    end
end
function SetSwitcherEx(type)
    select(type)
        case "組隊"
        hotkeybutton(79)
        case "決鬥"
        hotkeybutton(85)
        case "交名"
        hotkeybutton(80)
        case "交易"
        hotkeybutton(70)
        case "家族"
        hotkeybutton(219)
        case "聊天"
        hotkeybutton(73)
    end
end
function OC(type, value)
    select(type)
        case "自動丟棄"
        strsplit(value, ";", dropitem)
        case "鎖圖自走"
        var size = strsplit(value, ";", maplock)
        if(arraysize(maplock) > 0)
            listdeleteall("list0")
            for(var i = 0; i < size; i++)
                if(maplock[i] != "")
                    listaddtext("list0", maplock[i])
                end
            end
        end
        case "腳本延時"
        scriptsp = value
        case "尋路延時"
        routesp = value
    end
end
function OCEX(type, subType, value)
    select(type)
        case "走路遇敵"
        select(subType)
            case "方向"
            if(isint(value))
                if(value >= 0 && value < 2)
                    combosetcursel("combobox7", value)
                end
            end
            case "Dir"
            if(isint(value))
                if(value >= 0 && value < 2)
                    combosetcursel("combobox7", value)
                end
            end
            case "延時"
            if(isint(value))
                if(value > 0)
                    walkdelay = value
                    staticsettext("static44", walkdelay)
                end
            end
            case "Delay"
            if(isint(value))
                if(value > 0)
                    walkdelay = value
                    staticsettext("static44", walkdelay)
                end
            end
            case "格數"
            if(isint(value))
                if(value > 0 && value <= 99)
                    walklen = value
                    staticsettext("static45", walklen)
                end
            end
            case "Len"
            if(isint(value))
                if(value > 0 && value <= 99)
                    walklen = value
                    staticsettext("static45", walklen)
                end
            end
        end
    end
end
function RecordWear(HWND)
    WearSave_array = array()
    var WearItemExist = traverse(HWND, #00F4C494, 8, #0C5C, 2, 100)
    var WearItemName = traverse(HWND, #00F4C496, 8, #0C5C, 3, 100)
    for(var i = 0; i < 8; i++)
        var Output = ""
        var part = ""
        if(WearItemExist[i] && WearItemName[i] != "")
            Output = WearItemName[i]
        else
            Output = "無"
        end
        arraypush(WearSave_array, Output)
        select(i)
            case 0
            part = "頭部"
            case 1
            part = "身體"
            case 2
            part = "右手"
            case 3
            part = "左手"
            case 4
            part = "鞋子"
            case 5
            part = "右飾"
            case 6
            part = "左飾"
            case 7
            part = "水晶"
        end
        var Output2 = strformat("<記錄身上裝備>%s:%s", part, Output)
        PushAnnounce(HWND, Output2)  
        bc.Delay(15)
    end
    return 0
end
function GetWearState(HWND, jump, line)
    var WearItemName = traverse(HWND, #00F4C496, 8, #0C5C, 3, 100)
    for(var j = 0; j < 8; j++)
        if(WearItemName[j] != WearSave_array[j] && WearSave_array[j] != "無" && WearSave_array[j] != "")
            return Goto(jump, line)
        end
    end
    return 0
end
function WearRecordWear(HWND)
    var Output = ""
    var WearItemName = traverse(HWND, #00F4C496, 8, #0C5C, 3, 100)
    for(var i = 0; i < 8; i++)
        if(WearItemName[i] != WearSave_array[i] && WearSave_array[i] != "無" && WearSave_array[i] != "")
            for(var j = 0; j < 20; j++)
                if(itemName[j] == WearSave_array[i])
                    UseItem(HWND, j)
                    Output = strformat("<裝上記錄裝備>%s", WearSave_array[i])
                    PushAnnounce(HWND, Output)
                    bc.Delay(50)
                    break
                end
            end
        end
    end
    Output = null
    return 0
end
function GetStairPos(HWND)
    if(!bc.GetWindowState(StairFinderHwnd, 0))
        PushAnnounce(HWND, "CgStairFinder 未啟動")
        return false
    end
    if(!combatstate && loginstate)
        var fEast = rmstring(HWND, #00A79140, 50)
        var fSouth = rmstring(HWND, #00A79150, 50)
        if(fEast == east && fSouth == south)
            SetRoute(array(HWND, fEast + rnd(0, 2), fSouth + rnd(0, 2)))
            bc.Delay(500)
            SetRoute(array(HWND, fEast, fSouth))
        elseif(fEast > 0 && fSouth > 0)
            SetRoute(array(HWND, fEast, fSouth))
        else
            PushAnnounce(HWND, "找不到樓梯座標。")
        end
    end
end
function InputBox(content)
    inputboxtext = content
    if(!controldomodal("inputbox"))
        inputboxreturn = null
    end
    var value = inputboxreturn
    inputboxreturn = null
    return value
end