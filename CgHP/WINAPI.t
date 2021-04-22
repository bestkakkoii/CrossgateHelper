//WINAPI
function SetThemeAppProperties()
    dllcall("uxtheme.dll", "int", "SetThemeAppProperties", "int", STAP_ALLOW_NONCLIENT)
end
function GetWindowLongA(hwnd, type = 0)
    if(type == 0)
        return dllcall("user32.dll", "int", "GetWindowLongA", "int", hwnd, "int", GWL_STYLE)
    else
        return dllcall("user32.dll", "int", "GetWindowLongA", "int", hwnd, "int", -20)
    end
end
function SetWindowLongA(hwnd, style, type = 0)
    if(type == 0)
        dllcall("user32.dll", "int", "SetWindowLongA", "int", hwnd, "int", GWL_STYLE, "int", style) 
    else
        dllcall("user32.dll", "int", "SetWindowLongA", "int", hwnd, "int", -20, "int", style) 
    end
end
function GetCurrentProcess()
    return dllcall("kernel32.dll", "int", "GetCurrentProcess")
end
function GetProcessID(hwnd)
    return information(information(hwnd, 5), 2)
end
function TerminateProcess(hProcess)
    dllcall("kernel32.dll", "int", "TerminateProcess", "int", hProcess, "int", 0)
end
function SetWindowTheme(hwnd)
    dllcall("uxtheme.dll", "int", "SetWindowTheme", "int", hwnd, "long", "", "long", "")
end
function GetProcAddress(Module, Proc)
    var hDll = dllcall("kernel32.dll", "long", "GetModuleHandleA", "char *", Module)
    var fAddr = dllcall("kernel32.dll", "long", "GetProcAddress", "long", hDll, "char *", Proc)
    return fAddr
end
//按鍵擴充功能
function buttonsetpushlike(name, parent = "")
    var hwnd = controlgethandle(name, parent)
    dllcall("uxtheme.dll", "int", "SetWindowTheme", "int", hwnd, "long", "", "long", "")
    windowsendmessage(hwnd, #f3, true, 0)
end
//下拉框擴充功能
function combodeletestring(name, index, parent = "")
    windowsendmessage(controlgethandle(name, parent), CB_DELETESTRING, index, 0)
end
function comboinsertitem(name, index, content, parent = "")
    windowsendmessage(controlgethandle(name, parent), CB_INSERTSTRING, index, content)
end
function combogetedithandle(name, parent = "")
    return windowfindchild(controlgethandle(name, parent), "", "Edit")
end
function combodeleteedit(name, parent = "")
    var handle = combogetedithandle(name, parent)
    dllcall("user32.dll", "int", "SetWindowTextA", "int", handle, "int", "")
    windowsetfocus(handle)
end
//列表框功能
function listboxaddstring(handle, content)
    windowsendmessage(handle, LB_ADDSTRING, 0, content)
end
function listboxgetcursel(handle)
    return windowsendmessage(handle, LB_GETCURSEL, 0, 0)
end
function listboxdeletestring(handle, cursel)
    windowsendmessage(handle, LB_DELETESTRING, cursel, 0)
end
function listboxsetitemheight(handle, height)
    windowsendmessage(handle, LB_SETITEMHEIGHT, 0, height)
end
function listboxgetitemheight(handle)
    return windowsendmessage(handle, LB_GETITEMHEIGHT, 0, 0)
end
function listboxgettext(handle, cursel)
    return windowsendmessage(handle, LB_GETTEXT, cursel, 0)
end
function listboxgetcount(handle)
    return windowsendmessage(handle, LB_GETCOUNT, 0, 0)
end
function GetFont(handle)
    return windowsendmessage(handle, WM_GETFONT, 0, 0)
end
function SetFont(handle, font = null, bool = false)
    return windowsendmessage(handle, WM_SETFONT, font, bool)
end
//消息框
function msgbox(lpText, Type = 0, LPCTSTR = "水藍小幫手")
    var uType = #0
    select(Type)
        case 0
        uType = MB_ICONWARNING
        case 1
        uType = MB_ICONINFORMATION
        case 2
        uType = MB_ICONQUESTION
        case 3
        uType = MB_ICONASTERISK
        case 4
        uType = MB_ICONSTOP
        case 5
        uType = MB_ICONWARNING + MB_OKCANCEL
    end
    return dllcall("user32.dll", "int", "MessageBoxW", "int", m_hwnd, "wchar *", lpText, "wchar *", LPCTSTR, "int", uType)
end
//進度條function msctls_progress32(HWND, x, y, width, height, type, name = 0, parent = "")
    var ExStyle = WS_EX_NOREDIRECTIONBITMAP
    var Style = WS_CHILD + WS_VISIBLE + PBS_SMOOTH + WS_BORDER + WS_CLIPSIBLINGS
    var color = #FFFFFF
    //
    var handle = dllcall("user32.dll", "int", "CreateWindowExW", "int", ExStyle, "wchar *", "msctls_progress32", "wchar *", "", "int", Style, "int", x, "int", y, "int", width, "int", height, "int", HWND, "int", controlgethandle(name, parent), "int", 0, "int", 0)
    select(type)
        case 0
        color = #8080FF
        case 1
        color = #FF8080
    end
    windowsendmessage(handle, #2001, 0, #FFFFFF)
    windowsendmessage(handle, #409, 0, color)
    SetWindowThemeEx(handle)
    return handle
end
function GetPercentage(lowdec, hidec)
    var percentage = 0
    if(hidec > 0)
        percentage = lowdec * 100 / hidec
    end
    return percentage
end
function PBM_SETPOS(num, percent)
    windowsendmessage(barhwnd[num], PBM_SETPOS, percent, 0)
end
//主選單
function SetMenu(title, subtitle)
    var title_array = null
    strsplit(title, "|", title_array)
    var hMenu = dllcall("user32.dll", "long", "CreateMenu")
    var subsec_id = 1000
    var hPopupMenu = array()
    var subtitle_array = null
    var total_subtitle = strsplit(subtitle, ",", subtitle_array)
    /////////////////////////////////////////////////////////
    var hPopupMenu2 = dllcall("user32.dll", "long", "CreatePopupMenu")
    var subcontent = array()
    for(var i = 0; i < total_subtitle; i++)
        var subsize = strsplit(subtitle_array[i], "|", subcontent[i])
        hPopupMenu[i] = dllcall("user32.dll", "long", "CreatePopupMenu")
        for(var sbc = 0; sbc < subsize; sbc++)
            if(subcontent[i][sbc] == "_")
                dllcall("user32.dll", "int", "AppendMenuA", "int", hPopupMenu[i], "int", MF_SEPARATOR, "int", 0, "char *", "fff")  
            else
                dllcall("user32.dll", "long", "AppendMenuW", "long", hPopupMenu[i], "long", MF_POPUP, "long", subsec_id, "wchar *", subcontent[i][sbc])
                subsec_id++
            end
        end
        dllcall("user32.dll", "long", "AppendMenuW", "long", hMenu, "long", MF_POPUP, "long", hPopupMenu[i], "wchar *", title_array[i])
    end
    dllcall("user32.dll", "long", "SetMenu", "long", m_hwnd, "long", hMenu)
end
//樹形選單
function SysTreeView32(HWND)
    var Style = WM_SETCURSOR + WS_VSCROLL + WS_CHILD + WS_VISIBLE + TVS_HASBUTTONS + TVS_HASLINES + TVS_LINESATROOT + WM_SETCURSOR + TVIS_BOLD + TVS_SINGLEEXPAND
    TreeViewhwnd = dllcall("user32.dll", "int", "CreateWindowExW", "int", WS_EX_CLIENTEDGE, "wchar *", "SysTreeView32", "wchar *", "", "int", 1445019671, "int", 12, "int", 80, "int", 333, "int", 133, "int", HWND, "int", 0, "int", 0, "int", 0)
    windowsettop(TreeViewhwnd, true)
    windowhide(TreeViewhwnd)
    return TreeViewhwnd
end
//樹型框增加項目
var TreeViewhwnd = 0
var Sec_hwnds = array()
var Sec_content_Sets = array()
function TreeViewInsertitem(Sec_name, isChild, hwnd)
    var TV_INSERTSTRUCT_Struc = array()
    var String_pointer = varaddress(Sec_name)
    TV_INSERTSTRUCT_Struc["hParent"] = array("long" = "1", "value" = hwnd)//父句柄
    TV_INSERTSTRUCT_Struc["hInsertAfter"] = array("long" = "1", "value" = TTVI_LAST)//插入新项的项
    TV_INSERTSTRUCT_Struc["mask"] = array("long" = "1", "value" = TVIF_TEXT + TVIF_CHILDREN + TVIF_IMAGE + TVIF_PARAM + TVIF_SELECTEDIMAGE + TVIF_STATE)//包含有效数据或要填充的数据的标志阵列掩码
    TV_INSERTSTRUCT_Struc["hItem"] = array("long" = "1", "value" = 0)//Section_hwnd
    TV_INSERTSTRUCT_Struc["state"] = array("long" = "1", "value" = 0)//状态
    TV_INSERTSTRUCT_Struc["stateMask"] = array("long" = "1", "value" = 0)//状态掩码
    TV_INSERTSTRUCT_Struc["pszText"] = array("long" = "1", "value" = String_pointer)//项文本
    TV_INSERTSTRUCT_Struc["cchTextMax"] = array("long" = "1", "value" = 0)//缓冲区大小(指定属性时可忽略)
    TV_INSERTSTRUCT_Struc["iImage"] = array("long" = "1", "value" = 0)//指定图象列表
    TV_INSERTSTRUCT_Struc["iSelectedImage"] = array("long" = "1", "value" = 0)//指定图象索引
    TV_INSERTSTRUCT_Struc["cChildren"] = array("long" = "1", "value" = isChild)//是否有子
    TV_INSERTSTRUCT_Struc["lParam"] = array("long" = "1", "value" = 0)//与项关联的32位值
    var TV_INSERTSTRUCT_Pointer = structmalloc(TV_INSERTSTRUCT_Struc)
    var Target_hwnd = dllcall("user32.dll", "int", "SendMessageW", "int", TreeViewhwnd, "int", TVM_INSERTITEMW, "int", 0, "int", TV_INSERTSTRUCT_Pointer)//成功返回Section_hwnd
    if(Target_hwnd > 0)
        arraypush(Sec_hwnds, Target_hwnd)
        arraypush(Sec_content_Sets, Sec_name)
        structfree(TV_INSERTSTRUCT_Pointer)
        return Target_hwnd
    end
    structfree(TV_INSERTSTRUCT_Pointer)
end
//清空树形框
function TreeViewClear()
    windowsendmessage(TreeViewhwnd, 4353, 0, 0)
    arrayclear(Sec_hwnds)
    arrayclear(Sec_content_Sets)
end
//遍歷檔案新增樹型框項目
var 腳本目錄句柄 = 0
//
var 第一層文件數組 = array()
var 第二層文件數組 = array()
var 第三層文件數組 = array()
var 第四層文件數組 = array()
//
var 第一層資料夾數組 = array()
var 第二層資料夾數組 = array()
var 第三層資料夾數組 = array()
var 第四層資料夾數組 = array()
//
var 第一層文件數目 = 0
var 第二層文件數目 = array()
var 第三層文件數目 = array()
var 第四層文件數目 = array()
//
var 第一層資料夾數目 = array()
var 第二層資料夾數目 = array()
var 第三層資料夾數目 = array()
var 第四層資料夾數目 = array()
//
var 第一層文件句柄 = array()
var 第二層文件句柄 = array()
var 第三層文件句柄 = array()
var 第四層文件句柄 = array()
//
var 第一層資料夾句柄 = array()
var 第二層資料夾句柄 = array()
var 第三層資料夾句柄 = array()
var 第四層資料夾句柄 = array()
function TreeViewSetContent()
    腳本目錄句柄 = 0
    //
    第一層文件數組 = array()
    第二層文件數組 = array()
    第三層文件數組 = array()
    第四層文件數組 = array()
    //
    第一層資料夾數組 = array()
    第二層資料夾數組 = array()
    第三層資料夾數組 = array()
    第四層資料夾數組 = array()
    //
    第一層文件數目 = 0
    第二層文件數目 = array()
    第三層文件數目 = array()
    第四層文件數目 = array()
    //
    第一層資料夾數目 = array()
    第二層資料夾數目 = array()
    第三層資料夾數目 = array()
    第四層資料夾數目 = array()
    //
    第一層文件句柄 = array()
    第二層文件句柄 = array()
    第三層文件句柄 = array()
    第四層文件句柄 = array()
    //
    第一層資料夾句柄 = array()
    第二層資料夾句柄 = array()
    第三層資料夾句柄 = array()
    第四層資料夾句柄 = array()
    var 腳本目錄 = "./Script/"
    filetraverse(腳本目錄, 第一層文件數組, 第一層資料夾數組)
    第一層資料夾數目 = arraysize(第一層資料夾數組)
    if(第一層資料夾數目 > 0)
        for(var i = 0; i < 第一層資料夾數目; i++)
            第二層資料夾句柄[i] = array()
            第二層文件句柄[i] = array()
            第三層文件數目[i] = array()
            第三層文件數組[i] = array()
            第三層文件句柄[i] = array()
            第三層資料夾數組[i] = array()
            第三層資料夾數目[i] = array()
            第三層資料夾句柄[i] = array()
            第四層文件數組[i] = array()
            第四層文件數目[i] = array()
            第四層文件句柄[i] = array()
            第四層資料夾數組[i] = array()
            第四層資料夾數目[i] = array()
            第四層資料夾句柄[i] = array()
            第一層資料夾句柄[i] = TreeViewInsertitem(第一層資料夾數組[i], 1, 腳本目錄句柄)
            filetraverse(strformat("%s%s", 腳本目錄, 第一層資料夾數組[i]), 第二層文件數組[i], 第二層資料夾數組[i])
            //
            第二層資料夾數目[i] = arraysize(第二層資料夾數組[i])
            for(var g = 0; g < 第二層資料夾數目[i]; g++)
                第三層文件句柄[i][g] = array()
                第三層資料夾句柄[i][g] = array()
                第四層文件數組[i][g] = array()
                第四層文件數目[i][g] = array()
                第四層文件句柄[i][g] = array()
                第四層資料夾數組[i][g] = array()
                第四層資料夾數目[i][g] = array()
                第四層資料夾句柄[i][g] = array()
                第二層資料夾句柄[i][g] = TreeViewInsertitem(第二層資料夾數組[i][g], 1, 第一層資料夾句柄[i])
                filetraverse(strformat("%s%s/%s", 腳本目錄, 第一層資料夾數組[i], 第二層資料夾數組[i][g]), 第三層文件數組[i][g], 第三層資料夾數組[i][g])
                第三層文件數目[i][g] = arraysize(第三層文件數組[i][g])
                第三層資料夾數目[i][g] = arraysize(第三層資料夾數組[i][g])
                for(var k = 0; k < 第三層資料夾數目[i][g]; k++)
                    第四層文件數組[i][g][k] = array()
                    第四層文件數目[i][g][k] = array()
                    第四層文件句柄[i][g][k] = array()
                    第四層資料夾數組[i][g][k] = array()
                    第四層資料夾數目[i][g][k] = array()
                    第四層資料夾句柄[i][g][k] = array()
                    第三層資料夾句柄[i][g][k] = TreeViewInsertitem(第三層資料夾數組[i][g][k], 1, 第二層資料夾句柄[i][g])
                    filetraverse(strformat("%s%s/%s/%s", 腳本目錄, 第一層資料夾數組[i], 第二層資料夾數組[i][g], 第三層資料夾數組[i][g][k]), 第四層文件數組[i][g][k], 第四層資料夾數組[i][g][k])
                    第四層文件數目[i][g][k] = arraysize(第四層文件數組[i][g][k])
                    for(var l = 0; l < 第四層文件數目[i][g][k]; l++)
                        第四層文件句柄[i][g][k][l] = TreeViewInsertitem(第四層文件數組[i][g][k][l], 0, 第三層資料夾句柄[i][g][k])
                    end
                end
                for(var k = 0; k < 第三層文件數目[i][g]; k++)
                    第三層文件句柄[i][g][k] = TreeViewInsertitem(第三層文件數組[i][g][k], 0, 第二層資料夾句柄[i][g])
                end
            end 
            //
            第二層文件數目[i] = arraysize(第二層文件數組[i])
            for(var j = 0; j < 第二層文件數目[i]; j++)
                第二層文件句柄[i][j] = TreeViewInsertitem(第二層文件數組[i][j], 0, 第一層資料夾句柄[i])
            end
        end 
    end
    第一層文件數目 = arraysize(第一層文件數組)
    if(第一層文件數目 > 0)
        for(var i = 0; i < 第一層文件數目; i++)
            if(i == 0)
                第一層文件句柄[i] = TreeViewInsertitem(第一層文件數組[i], 0, 腳本目錄句柄)
            else
                第一層文件句柄[i] = TreeViewInsertitem(第一層文件數組[i], 0, 腳本目錄句柄)
            end
        end
    end
end
function treeviewmenu(Current_focus)
    for(var i = 0; i < 第一層文件數目; i++)
        if(Current_focus == 第一層文件句柄[i])
            ScriptPath = "./Script/" & 第一層文件數組[i]
            staticsettext("static36", 第一層文件數組[i])
            ScriptFolderTmpPath = "./Script/"
            ScriptFolderTmp = 第一層文件數組[i]
            LoadScript()
            return false
        end
    end
    for(var i = 0; i < 第一層資料夾數目; i++)
        for(var j = 0; j < 第二層文件數目[i]; j++)
            if(Current_focus == 第二層文件句柄[i][j])
                ScriptPath = "./" & strformat("Script/%s/%s", 第一層資料夾數組[i], 第二層文件數組[i][j])
                staticsettext("static36", 第二層文件數組[i][j])
                ScriptFolderTmpPath = "./" & strformat("Script/%s/", 第一層資料夾數組[i])
                ScriptFolderTmp = 第二層文件數組[i][j]
                LoadScript()
                return false
            end
        end
        for(var g = 0; g < 第二層資料夾數目[i]; g++)
            for(var k = 0; k < 第三層文件數目[i][g]; k++)
                if(Current_focus == 第三層文件句柄[i][g][k])
                    ScriptPath = "./" & strformat("Script/%s/%s/%s", 第一層資料夾數組[i], 第二層資料夾數組[i][g], 第三層文件數組[i][g][k])
                    staticsettext("static36", 第三層文件數組[i][g][k])
                    ScriptFolderTmpPath = "./" & strformat("Script/%s/%s/", 第一層資料夾數組[i], 第二層資料夾數組[i][g])
                    ScriptFolderTmp = 第三層文件數組[i][g][k]
                    LoadScript()
                    return false
                end
            end
            for(var k = 0; k < 第三層資料夾數目[i][g]; k++)
                for(var l = 0; l < 第四層文件數目[i][g][k]; l++)
                    if(Current_focus == 第四層文件句柄[i][g][k][l])
                        ScriptPath = "./" & strformat("Script/%s/%s/%s/%s", 第一層資料夾數組[i], 第二層資料夾數組[i][g], 第三層資料夾數組[i][g][k], 第四層文件數組[i][g][k][l])
                        staticsettext("static36", 第四層文件數組[i][g][k][l])
                        ScriptFolderTmpPath = "./" & strformat("Script/%s/%s/%s/", 第一層資料夾數組[i], 第二層資料夾數組[i][g], 第三層資料夾數組[i][g][k])
                        ScriptFolderTmp = 第四層文件數組[i][g][k][l]
                        LoadScript()
                        return false
                    end
                end
            end
        end
    end
end
//創建UPDOWN功能滾動條
function CreateScrollbar(mhwnd, x = 110, y = 100, width = 17, height = 17, type = 0)
    var Style = 0
    if(type == 0)
        Style = 1442840577
    else
        Style = 1442840644
    end
    var hwnd = dllcall("user32.dll", "int", "CreateWindowExW", "int", 0, "wchar *", "ScrollBar", "wchar *", "", "int", Style, "int", x, "int", y, "int", width, "int", height, "int", mhwnd, "int", "", "int", null, "int", "")
    windowsettop(hwnd, true)
    windowhide(hwnd)
    return hwnd
end
//右鍵選單
function PopuMenu(title)
    var isCheck = array()
    var h_Menu
    var title_array
    var array1
    var count = strsplit(title, "|", title_array)    
    h_Menu = dllcall("user32.dll", "int", "CreatePopupMenu")
    if(h_Menu == 0)
        return 0
    end
    for(var i = 1; i < count; i++)
        select(title_array[i])
            case "-" //表示使用分割线
            dllcall("user32.dll", "int", "AppendMenuA", "int", h_Menu, "int", MF_SEPARATOR, "int", 0, "char *", "fff")  
            isCheck[i] = false
            case "_"//表示使用分割线
            dllcall("user32.dll", "int", "AppendMenuA", "int", h_Menu, "int", MF_SEPARATOR, "int", 0, "char *", "fff")  
            isCheck[i] = false
            default
            var t = title_array[i]
            //表示要使用复选框
            if(strsub(title_array[i], 0, 1) == "√")
                //截取√符号不显示
                title_array[i] = strsub(title_array[i], 1, strlen(title_array[i]))
                if(isCheck[i])
                    //选中状态
                    dllcall("user32.dll", "int", "AppendMenuA", "int", h_Menu, "int", MF_CHECKED, "int", i, "char *", title_array[i])
                    isCheck[i] = true
                else
                    //未选中状态
                    dllcall("user32.dll", "int", "AppendMenuA", "int", h_Menu, "int", 0, "int", i, "char *", title_array[i])
                    isCheck[i] = false
                end
            else
                //正常的
                dllcall("user32.dll", "int", "AppendMenuA", "int", h_Menu, "int", 0, "int", i, "char *", title_array[i])
                isCheck[i] = false
            end
        end
    end  
    var x0, y0
    var x, y
    mousegetpoint(x, y)
    var retR = dllcall("user32.dll", "int", "TrackPopupMenu", "int", h_Menu, "int", TPM_RIGHTALIGN + TPM_TOPALIGN + TPM_LEFTBUTTON + TPM_RIGHTBUTTON + TPM_RETURNCMD, "int", x, "int", y, "int", 0, "int", windowgetmyhwnd(), "int", 0)
    dllcall("user32.dll", "int", "DestroyMenu", "int", h_Menu)
    if(isCheck[retR])
        isCheck[retR] = false
    else
        isCheck[retR] = true
    end
    return retR    
end
////////////////////////////////////////////////////////////////////////////////////////////
function icochange()//工具欄氣泡
    create_bar_icon(windowgetmyhwnd(), "水藍小幫手")
    Pop_iconMsg(windowgetmyhwnd(), "水藍小幫手", "小幫手已新增至工具列", 1)
    var iconHwnd
    iconHwnd = install_icon(rc & ("lovesa.ico"))
    iconchengeFun(windowgetmyhwnd(), iconHwnd)
end
function WinProc(hwnd, mssage, wParam, lParam)//
    if(mssage == 10001)
        select(lParam)
            case 517
            var index = PopuMenu("_|打開小幫手|關閉程式|取消")//工具欄右鍵選單
            select(index)
                case 0
                case 1
                windowrestore(windowgetmyhwnd())
                windowactivate(windowgetmyhwnd())
                case 2
                threadclose(mainID, 1)
                threadclose(submainID, 1)
                TerminateProcess(GetProcessID(StairFinderHwnd))
                TerminateProcess(GetProcessID(bchwnd))
                TerminateProcess(GetCurrentProcess())
                case 3
            end  
            case 515
            windowrestore(windowgetmyhwnd())
            windowactivate(windowgetmyhwnd())
        end
    elseif(mssage == 16)
        var NOTIFYICONDATA
        NOTIFYICONDATA = Set_NOTIFYICONDATA()
        NOTIFYICONDATA["hWnd"]["value"] = hwnd
        NOTIFYICONDATA["uFlags"]["value"] = 7
        NOTIFYICONDATA["ucallbackMessage"]["value"] = 12345
        NOTIFYICONDATA["hIcon"]["value"] = 0
        NOTIFYICONDATA["szTip"]["wchar"] = 1
        NOTIFYICONDATA["szTip"]["value"] = 0
        NOTIFYICONDATA["cbSize"]["value"] = structlen(NOTIFYICONDATA)
        dllcall("shell32.dll", "long", "Shell_NotifyIconW", "long", 2, "pstruct", NOTIFYICONDATA)
    end
    return dllcall("user32.dll", "long", "CallWindowProcW", "long", default_Process, "long", hwnd, "long", mssage, "long", wParam, "long", lParam)
end
var default_Process = 0
function create_bar_icon(hwnd, PopText, ReturnValue = 10001)
    var NOTIFYICONDATA, Pointer
    NOTIFYICONDATA = Set_NOTIFYICONDATA()
    NOTIFYICONDATA["hWnd"]["value"] = hwnd
    NOTIFYICONDATA["uFlags"]["value"] = 7
    NOTIFYICONDATA["ucallbackMessage"]["value"] = ReturnValue
    NOTIFYICONDATA["hIcon"]["value"] = windowsendmessage(hwnd, 127, 0, 0)
    NOTIFYICONDATA["szTip"]["value"] = PopText
    NOTIFYICONDATA["cbSize"]["value"] = structlen(NOTIFYICONDATA)
    dllcall("shell32.dll", "long", "Shell_NotifyIconW", "long", 0, "pstruct", NOTIFYICONDATA)
    Pointer = callbackmalloc("WinProc", "DIALOGPROC")
    default_Process = dllcall("user32.dll", "long", "GetWindowLongW", "long", hwnd, "long", -4)
    dllcall("user32.dll", "long", "SetWindowLongW", "long", hwnd, "long", -4, "long", Pointer)
end
function Pop_iconMsg(hwnd, Poptitle, PopContent, Popdetail = 0) //图示图标:0=无图表,1=蓝色"i"图标,2=黄色"!"图标,3=红色"X"图标
    var NOTIFYICONDATA = Set_NOTIFYICONDATA()
    NOTIFYICONDATA["hWnd"]["value"] = hwnd
    NOTIFYICONDATA["uFlags"]["value"] = 16
    NOTIFYICONDATA["dwInfoFlags"]["value"] = Popdetail
    NOTIFYICONDATA["szInfoTitle"]["value"] = Poptitle
    NOTIFYICONDATA["szInfo"]["value"] = PopContent
    NOTIFYICONDATA["cbSize"]["value"] = structlen(NOTIFYICONDATA)
    dllcall("shell32.dll", "long", "Shell_NotifyIconW", "long", 1, "pstruct", NOTIFYICONDATA)
end
function set_icon_focus(hwnd)
    var NOTIFYICONDATA = Set_NOTIFYICONDATA()
    NOTIFYICONDATA["hWnd"]["value"] = hwnd
    NOTIFYICONDATA["uFlags"]["value"] = 4
    NOTIFYICONDATA["cbSize"]["value"] = structlen(NOTIFYICONDATA)
    dllcall("shell32.dll", "long", "Shell_NotifyIconW", "long", 3, "pstruct", NOTIFYICONDATA)
end
function iconchengeFun(hwnd, New_iconHwnd)
    var NOTIFYICONDATA = Set_NOTIFYICONDATA()
    NOTIFYICONDATA["hWnd"]["value"] = hwnd
    NOTIFYICONDATA["uFlags"]["value"] = 2
    NOTIFYICONDATA["hIcon"]["value"] = New_iconHwnd
    NOTIFYICONDATA["cbSize"]["value"] = structlen(NOTIFYICONDATA)
    dllcall("shell32.dll", "long", "Shell_NotifyIconW", "long", 1, "pstruct", NOTIFYICONDATA)
end
function install_icon(iconPath)
    return dllcall("User32.dll", "int", "LoadImageW", "int", 0, "wchar *", iconPath, "int", 1, "int", 32, "int", 32, "int", 16)
end
function Set_NOTIFYICONDATA()
    var NOTIFYICONDATA = array()
    NOTIFYICONDATA["cbSize"] = array("long" = 1, "value" = 0)
    NOTIFYICONDATA["hWnd"] = array("long" = 1, "value" = 0)
    NOTIFYICONDATA["uId"] = array("long" = 1, "value" = 1)
    NOTIFYICONDATA["uFlags"] = array("long" = 1, "value" = 0)
    NOTIFYICONDATA["ucallbackMessage"] = array("long" = 1, "value" = 0)
    NOTIFYICONDATA["hIcon"] = array("long" = 1, "value" = 0)
    NOTIFYICONDATA["szTip"] = array("wchar" = 128, "value" = 0)
    NOTIFYICONDATA["dwState"] = array("long" = 1, "value" = 0)
    NOTIFYICONDATA["dwStateMask"] = array("long" = 1, "value" = 0)
    NOTIFYICONDATA["szInfo"] = array("wchar" = 256, "value" = 0)
    NOTIFYICONDATA["uTimeoutORVersion"] = array("long" = 1, "value" = 0)
    NOTIFYICONDATA["szInfoTitle"] = array("wchar" = 64, "value" = 0)
    NOTIFYICONDATA["dwInfoFlags"] = array("long" = 1, "value" = 0)
    return NOTIFYICONDATA
end
function SetCallbackFunc(name, hwnd)
    var Pointer = callbackmalloc(name, "DIALOGPROC")
    default_Process = dllcall("user32.dll", "long", "GetWindowLongW", "long", hwnd, "long", -4)
    dllcall("user32.dll", "long", "SetWindowLongW", "long", hwnd, "long", -4, "long", Pointer)
end
function ScrollWindow(value)
    var LPCSCROLLINFO = array()
    LPCSCROLLINFO["cbSize"] = array("int" = 1, "value" = 0)
    LPCSCROLLINFO["fMask"] = array("int" = 1, "value" = SIF_POS)
    LPCSCROLLINFO["nMin"] = array("int" = 1, "value" = 1)
    LPCSCROLLINFO["nMax"] = array("int" = 1, "value" = ScriptSize)
    LPCSCROLLINFO["nPage"] = array("int" = 1, "value" = 7)
    LPCSCROLLINFO["nPos"] = array("int" = 1, "value" = value)
    LPCSCROLLINFO["nTrackPos"] = array("int" = 1, "value" = value) 
    windowsendmessage(controlgethandle("gridscript"), SBM_SETSCROLLINFO, true, LPCSCROLLINFO)
    //traceprint(getlasterror(1))
end
//腳本運行自動滾動表格
function SetScollPos(CmpValue)
    var CurrentPos = GetScrollPos() / 18
    if(CurrentPos != (CmpValue - 3))
        var tmp = CurrentPos - (CmpValue - 3)
        if(tmp > 0)
            SB_LINEUP(tmp)
        else
            SB_LINEDOWN(mabs(tmp))
        end
    end
end
function SB_LINEDOWN(value)
    for(var i = 0; i < value; i++)
        windowpostmessage(controlgethandle("gridscript"), WM_VSCROLL, SB_LINEDOWN, 0)
    end
end
function SB_LINEUP(value)
    for(var i = 0; i < value; i++)
        windowpostmessage(controlgethandle("gridscript"), WM_VSCROLL, SB_LINEUP, 0)
    end
end
function GetScrollRange(&Min, &Max)
    dllcall("user32.dll", "int", "GetScrollRange", "int", controlgethandle("gridscript"), "int", SB_VERT, "int", varaddress(Min), "int", varaddress(Max))
end
function GetScrollPos()
    return dllcall("user32.dll", "int", "GetScrollPos", "int", controlgethandle("gridscript"), "int", SB_VERT)
end