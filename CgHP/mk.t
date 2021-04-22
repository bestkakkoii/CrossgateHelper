//腳本編輯
function mk_init()
    buttonsetpushlike("mkbutton2", "mk")
    preoloadmk(bchwnd)
    for(var i = 0; i < 4; i++)
        var handle = controlgethandle("mkgroup" & i, "mk")
        SetWindowLongA(handle, 1442971911)
        SetWindowThemeEx(handle)
    end
    timerregister("mktimer0", 100, "mk")
end
function preoloadmk(HWND)
    var mx, my
    bc.GetCursorPos(mx, my)
    if(!windowiswindow(bchwnd))
        mx = ""
        my = ""
    end
    if(mkmxsave != mx || mkmysave != my)
        staticsettext("mkstatic3", "鼠標:" & mx & "," & my, "mk")
        if(mkmxsave != mx)
            mkmxsave == mx
        end
        if(mkmysave != my)
            mkmysave == my
        end
    end
    var dir = GetStringDirection()
    if(Eastsave != east || Southsave != south || dir != mkdirsave)
        staticsettext("mkstatic2", strformat("座標:%s,%s", east, south), "mk")
        if(Eastsave != east)
            Eastsave == east
        end
        if(Southsave != south)
            Southsave == south
        end
        if(dir != mkdirsave)
            mkdirsave = dir
        end
    end
    var mapID = GetMapID(HWND)
    var map = GetMap(HWND)
    if(mapID != mapnumsave || map != mkmapsave)
        staticsettext("mkstatic1", strformat("地圖編號:%s", mapID), "mk")
        staticsettext("mkstatic0", strformat("地圖:%s", map), "mk")
        if(mapID != mapnumsave || map != mkmapsave)
            mapnumsave = mapID
            mkmapsave = map 
        end
    end
end
function mktimer0_ontime()
    recordstep(bchwnd)
    preoloadmk(bchwnd)
end
var mkmxsave = 0
var mkmysave = 0
var mkmapIDsave = 0
var mkmapsave = ""
var mkdirsave = ""
var mapnumsave = 0
var Eastsave = 0
var Southsave = 0
//紀錄走路
function recordstep(HWND)
    var mapID = GetMapID(HWND)
    if(checkgetstate("mkcheck0", "mk"))
        var TEXT = editgettext("mkedit0", "mk") 
        var mapnum = mapID
        if(mapnum != mapnumsave)
            TEXT = strformat("%s延時 1500\r\n地圖 %s,-2\r\n", TEXT, mapnum)
            mapnumsave = mapnum
            editsettext("mkedit0", TEXT, "mk")
            windowsendmessage(controlgethandle("mkedit0", "mk"), 277, 7, 0) 
        end
        if(east != Eastsave || south != Southsave)
            TEXT = TEXT & strformat("坐標 %s,%s\r\n", east, south)
            Eastsave = east
            Southsave = south
            editsettext("mkedit0", TEXT, "mk")
            windowsendmessage(controlgethandle("mkedit0", "mk"), 277, 7, 0)
        end
    end
end
function mklist0_doubleclicked()
    var content = listgetchecktext("mklist0", "mk")
    var TEXT = editgettext("mkedit0", "mk")
    if(TEXT != "")
        if(content == "尋路" || content == "坐標" || content == "移動")
            content = strformat("%s %s,%s", content, east, south)
        elseif(content == "方向")
            content = strformat("%s %s", content, GetStringDirection())
        elseif(content == "地圖" || content == "地圖快判")
            var mapID = GetMapID(bchwnd)
            content = strformat("%s %s,-1", content, mapID)
        end
        TEXT = strformat("%s%s\r\n", TEXT, content)
        editsettext("mkedit0", TEXT, "mk")
    else
        TEXT = strformat("%s%s\r\n", TEXT, content)
        editsettext("mkedit0", TEXT, "mk")
    end
end
function mklist0_selectchange()
    scriptorderins()
end
//顯示說明
function scriptorderins()
    var text = ""
    var content = listgetchecktext("mklist0", "mk")
    select(content)
        case "坐標"
        text = "移動到指定座標(以自身為中心一格) 格式: 坐標 東,南"
        case "移動"
        text = "移動到指定座標 但不等待到達座標 立即執行下一行"
        case "尋路"
        text = "尋路至指定坐標 格式: 尋路 東座標,南座標"
        case "方向"
        text = "人物轉向至指定方向亦可用來與NPC對話 格式: 方向 東/西/南/北/東南/西南/東北/西北"
        case "對話"
        text = "檢測NPC對話內容 格式: 對話 檢測目標行(沒有可留空),檢測內容"
        case "按鈕"
        text = "左鍵按下按鈕 格式: 按鈕 按鈕名稱/所在行數(所在行數僅護士有效)"
        case "設置"
        text = "開啟指定功能(所有可打勾項目) 格式: 設置 完整功能名稱"
        case "取消"
        text = "關閉指定功能(所有可打勾項目) 格式: 取消 完整功能名稱"
        case "延時"
        text = "腳本等待指定時間(非阻塞型)(千分之一秒[毫秒]) 格式: 延時 時間長度"
        case "地圖"
        text = "檢測所在地圖是否正確並重新讀取尋路地圖等待2秒 不正確則跳轉至指定行數 格式: 地圖 地圖編號/地圖名,錯誤跳轉行數/標記"
        case "地圖快判"
        text = "快速檢測所在地圖是否正確,地圖不正確則立即跳轉至指定行數標記(不等待) 格式: 地圖快判 地圖編號/地圖名,錯誤跳轉行數/標記"
        case "行數"
        text = "跳轉至指定行數 格式: 行數 ±行數"
        case "戰鬥中"
        text = "檢測人物是否在戰鬥中,是則正確跳轉 格式: 戰鬥中 正確跳轉行數"
        case "人物狀態"
        text = "檢測人物狀態 不正確則往上跳轉一行 正確則繼續執行 格式: 人物狀態 判斷項目[HP/MAXHP/HP百分比/MP/MAXMP/MP百分比],邏輯符號[!=/==/>=/<=/>/<],比較值"
        case "背包滿"
        text = "檢測道具欄是否已滿 滿則正確跳轉 格式: 背包滿 正確跳轉行數/標記"
        case "回點"
        text = "觸發點擊回點按鈕"
        case "登出"
        text = "觸發點擊登出按鈕"
        case "OC"
        text = "設置指定功能的進階內容 如指定下拉框選中編號或編輯框內容"
        case "OC 自動丟棄"
        text = "設置自動丟棄名單(多個物品以 ; 分隔) 格式: OC 自動丟棄,物品名稱"
        case "OCEX"
        text = "設置指定功能進階的內容 如指定下拉框選中編號或編輯框內容"
        case "OCEX 走路遇敵,方向"
        text = "設置自動走路遇敵/快速遇敵方向(起始項編號為 0) 除了防斷快遇為隨機方向 格式: OCEX 走路遇敵,方向,方向編號"
        case "OCEX 走路遇敵,延時"
        text = "設置自動走路遇敵/快速遇敵間格延時 格式: OCEX 走路遇敵,延時,數值"
        case "OCEX 走路遇敵,格數"
        text = "設置自動走路遇敵/快速遇敵步數(最低1最高100) 格式: OCEX 走路遇敵,格數,數值"
        case "消息"
        text = "彈出消息框並顯示指定內容 格式: 消息 內容"
        case "結束"
        text = "結束腳本"
        case "暫停"
        text = "暫停腳本"
        case "組隊 加入"
        text = "發送組隊指令"
        case "組隊 離隊"
        text = "觸發點選組隊/離隊按鈕"
        case "組隊 狀態"
        text = "檢測人物是否組隊中不是則錯誤跳轉 格式: 組隊 狀態,錯誤跳轉行數/標記"
        case "輸入"
        text = "發送指定內容至遊戲 格式: 輸入 內容"
        case "說出"
        text = "遊戲中說出指定內容 格式: 說出 內容"
        case "整理"
        text = "觸發輸入整理背包指令"
        case "使用道具"
        text = "使用指定物品或對指定目標使用物品[0 自己,1寵物一...]不指定對象填-1 格式: 使用道具 物品名稱,[使用對象編號-1到5之間],[模式0模糊,1精確]"
        case "變數 設置"
        text = "設置一個變數(區分大小寫,開頭不可為數字)並賦予一個值,調用變數則在變數前面加半形問號 格式: 變數 設置,變數名稱,賦予值"
        case "變數 加減"
        text = "對指定變數做數學加減指定的值(正數不帶符號,負數帶符號) 格式: 變數 加減,變數名稱,指定加減值"
        case "變數 取消"
        text = "取消指定變數 格式: 變數 取消,變數名稱"
        case "變數 清空"
        text = "清空所有變數 格式: 變數 清空"
        case "標記"
        text = "設置一個標記提供給 跳轉 或 調用命令使用 格式: 標記 標記名稱"
        case "跳轉"
        text = "跳轉到指定標記所在行 開始運行腳本 格式: 跳轉 標記名稱"
        case "調用"
        text = "調用子程序 類似於跳轉 區別在於可以在結尾處使用返回命令回到調用處的下一行開始執行 沒有調用返回則繼續往下執行 格式: 調用 標記名稱"
        case "返回"
        text = "回到前一個使用調用命令行的下一行開始執行"
        case "執行"
        text = "執行一個子腳本 路徑必須包含腳本資料夾之後開始的相對路徑 支援所有可讀取副檔名 如: .txt/.spp/.ini/.dat等等(編碼big5[cp950],UTF-16LE[unicode],GBK[gb2312]) 格式: 執行 資料夾\\腳本名稱.txt"
        case "執行Ex"
        text = "背景隱藏執行子腳本可和主腳本同時運行 格式同 執行"
        case "找最近樓梯"
        text = "尋找並尋路至最近樓梯 死路則錯誤跳轉行數/標記"
        case "左擊"
        text = "在指定視窗內座標點擊左鍵"
        case "左按下"
        text = "在指定視窗內座標按住左鍵"
        case "左彈起"
        text = "在指定視窗內座標放開左鍵"
        case "左雙擊"
        text = "在指定視窗內座標連點兩下左鍵"
        case "右擊"
        text = "在指定視窗內座標點擊右鍵"
        case "滾下"
        text = "滑鼠滾輪往下"
        case "滾上"
        text = "滑鼠滾輪往上"
        case "道具有"
        text = "檢測指定道具是否存在於背包存在則繼續執行 不存在則往上一行"
        case "道具"
        text = "檢測指定格子是否存在指定道具 填?則代表檢測整個背包 存在則繼續執行 不存在則錯誤跳轉行數/標記 模式0 模糊搜索 填1為精確搜索 格式: 道具 位置,名稱,錯誤跳轉/標記,[模式]"
        case "道具數量"
        text = "邏輯檢測身上道具 不符合條件則繼續執行 符合條件則正確跳轉行數/標記"
        case "允許開關"
        text = "控制開關 組隊|決鬥|交名|交易|聊天|家族,0|1  1為開 0為關"
        case "KNPC"
        text = "調用小幫手KNPC護士|領恢|商賣功能 有效節省腳本行數"
        case "提示"
        text = "將指定內容以遊戲公告黃色字體投放到遊戲中 支持最多五個變數 變數與內容要以逗號分隔 不可帶多於空格 格式: 提示 內容"
        case "清屏"
        text = "清空螢幕上的對話內容"
        case "記錄身上裝備"
        text = "記錄身上已裝備的物品"
        case "檢測記錄裝備"
        text = "檢測身上裝備的物品是否與記錄的物品吻合 正確繼續運行 錯誤則錯誤跳轉行數/標記 格式: 檢測記錄裝備 錯誤跳轉行數/標記"
        case "裝上記錄裝備"
        text = "自動檢測身上裝備是否與記錄吻合 如不吻合則自動穿上物品中持有與記錄相同的裝備 戰鬥中無效 如無物品繼續運行"
        case "存入道具"
        text = "自動開啟銀行 存入所有相同名稱物品 格式: 存入道具 物品名稱,[模式:0模糊,1精確],[指定存入堆疊數量不指定填-1]"
        case "提出道具"
        text = "自動開啟銀行 提領所有相同名稱物品 格式: 提出道具 物品名稱,[模式:0模糊,1精確]"
        case "更換寵物"
        text = "更換指定寵物成指定狀態 戰鬥|休息|騎乘 格式: 更換寵物 寵物位置,狀態"
        case "寵物郵件"
        text = "使用指令發送寵物郵件 格式: 寵物郵件 名片位置,寵物位置,物品,[送信內容]"
        case "交名"
        text = "發送交換名片指令"
        case "PK"
        text = "發送決鬥指令"
        case "聽見"
        text = "檢測遊戲中對話內容 由下至上檢測對話內容(1-20) 要檢測15行填15 包含內容則繼續執行 錯誤則錯誤跳轉行數/標記 格式: 聽見 最大行數,內容,錯誤跳轉行數/標記"
        case "治療"
        text = "治療指定目標 0人 1~5寵物 必須先手動開啟過一次含人物及寵物名字的綠字面板才會生效 不限制自己還別人 以最後一次開的面板為主 格式: 治療 治療對象編號"
        case "急救"
        text = "急救指定目標 0人 1~5寵物 必須先手動開啟過一次含人物及寵物名字的綠字面板才會生效 不限制自己還別人 以最後一次開的面板為主 格式: 急救 急救對象編號"
        case "查坐標"
        text = "檢查當前坐標是否與設置檢查坐標吻合 格式: 查坐標 東坐標,南坐標"
        case "採集"
        text = "發送對應名稱的開始採集指令[狩獵|伐木|剪取|挖掘] 格式: 採集 技能名稱"
        case "生產"
        text = "自動開啟對應生產面板並放入指定食材並執行產品完整名稱或產品編號[比如生命力回復藥(600)在第8格就填8](多個素材以 ; 分隔) 格式: 生產 技能名,產品名稱或編號,素材名稱"
    end
    staticsettext("mkstatic4", text, "mk")
    text = ""
    return false
end
function mkstatic3_click()
    scriptSetClipboard(0)
end
function mkstatic2_click()
    scriptSetClipboard(1)
end
function mkstatic1_click()
    scriptSetClipboard(2)
end
function mkstatic0_click()
    scriptSetClipboard(3)
end
function scriptSetClipboard(num)
    select(num)
        case 0
        var mx, my
        bc.GetCursorPos(mx, my)
        bc.SetClipboard(mx & "," & my)
        mx = null
        my = null
        case 1
        bc.SetClipboard(strformat("%s,%s %s", east, south, GetStringDirection()))
        case 2
        var mapID = GetMapID(bchwnd)
        bc.SetClipboard(mapID)
        case 3
        var map = GetMap(bchwnd)
        bc.SetClipboard(map)
    end
    return false
end
function mkbutton1_click()
    savescript()
end
function savescript()
    var path = filedialog(0, "*.txt|*.txt||")
    var content = editgettext("mkedit0", "mk")
    return filewriteex(path, content, 1)
end
function mkbutton0_click()
    clearscript()
end
function clearscript()
    return editsettext("mkedit0", "", "mk")
end
//点击关闭_执行操作
function mk_close()
    timerkill("mktimer0", "mk")
    mapnumsave = 0
    Eastsave = 0
    Southsave = 0
    lineselsave = 0
    linesizesave = 0
    controlclosewindow("mk", 0)
end
function mkbutton4_click()
    SetScriptRestoreVar()
    buttonsettext("button21", "開始")
    Scriptcontent = editgettext("mkedit0", "mk")
    scriptdata_array = array()
    ScriptSize = strsplit(Scriptcontent, "\r\n", command_array)
    for(var i = 0; i < ScriptSize; i++)
        if(command_array[i] != "")
            scriptdata_array[i] = array()
            command_array[i] = strtrim(command_array[i])
            command_array[i] = strformat("%s %s", i + 1, command_array[i])
            command_array[i] = strtrim(command_array[i])
            //
            strsplit(command_array[i], " ", param_array[i])
            //
            scriptdata_array[i]["行數"] = param_array[i][0]
            scriptdata_array[i]["指令"] = param_array[i][1]
            scriptdata_array[i]["內容"] = param_array[i][2]
            //分割多个参数
            ParamStringSize[i] = strsplit(param_array[i][2], ",", Param[i])
        end
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
        windowpostmessage(controlgethandle("gridscript"), 277, 6, 0)
        for(var i = 0; i < ScriptSize; i++)
            if(isarray(param_array[i]))
                if(param_array[i][1] == "標記")
                    var_array[Param[i][0]] = i + 1
                end
            end
        end
        SetScriptStatic(0)
    end
end
function mkbutton3_click()
    editsettext("mkedit0", filereadex(filedialog(1, "*.txt|*.txt|*.dat|*.dat|*.spp|*.spp|*.ini|*.ini||")), "mk")
end
function mkbutton5_click()
    var handle = controlgethandle("mkedit0", "mk")
    windowsetfocus(handle)
    windowsendmessage(handle, EM_SETSEL, 0, -1)
end
//消息路由功能
var lineselsave = 0
var linesizesave = 0
function mk_pretranslatemessage(hwnd, message, wParam, lParam, time, x, y)
    var handle = controlgethandle("mkedit0", "mk")
    if(hwnd == handle)//行數計算
        var linesize = windowsendmessage(handle, EM_GETLINECOUNT, 0, 0)
        var linesel = windowsendmessage(handle, EM_LINEFROMCHAR, -1, 0)
        if(linesizesave != linesize)
            buttonsettext("mkgroup1", strformat("腳本內容(%d/%d)", linesel + 1, linesize), "mk")
            linesizesave == linesize        
        end
        if(lineselsave != linesel)
            buttonsettext("mkgroup1", strformat("腳本內容(%d/%d)", linesel + 1, linesize), "mk")
            lineselsave == linesel
        end
    end
    return false
end
function mkbutton6_click()
    editsettext("mkedit0", Translation(editgettext("mkedit0", "mk")), "mk")
end