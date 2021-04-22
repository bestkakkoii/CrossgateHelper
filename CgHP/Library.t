///通用函數庫///
//文字加密
function AESencrypt(content)
    return aesencrypt(content, "Ew6p%NdDqezT.M5vEf%p5uzNhDH-D442")
end
//文字解密
function AESdecrypt(content)
    return aesdecrypt(content, "Ew6p%NdDqezT.M5vEf%p5uzNhDH-D442")
end
//計時
function GetTickCounter(OriginalTime)
    return strcut(((bc.GetTime() - OriginalTime) * 0.001), 3, false)
end
//設置經典模式
function SetWindowThemeEx(handle)
    SetWindowTheme(handle)
    arraypush(SetThemeHwnd_array, handle)
end
//轉十六進制
function chex(dec)
    return strformat("%X", dec)
end
//方向整數轉文字
function GetStringDirection()
    select(direction)
        case 0
        return "北"
        case 1
        return "東北"
        case 2
        return "東"
        case 3
        return "東南"
        case 4
        return "南"
        case 5
        return "西南"
        case 6
        return "西"
        case 7
        return "西北"
    end
end
//轉二進制
function cbin(dec = 0)
    var bin = ""
    while(dec != 1)
        if((dec % 2) == 0)
            dec = int((dec / 2))
            bin = "0" & bin
        else
            dec = int(((dec - 1) / 2))
            bin = "1" & bin
        end
    end
    if(dec != 0)
        bin = "1" & bin
    end
    if(strlen(bin) == 3)
        bin = "0000" & bin
    elseif(strlen(bin) == 4)
        bin = "000" & bin
    elseif(strlen(bin) == 5)
        bin = "00" & bin
    elseif(strlen(bin) == 6)
        bin = "0" & bin
    elseif(strlen(bin) == 1)
        bin = "000000" & bin
    end
    var BinArray = array()
    for(var i = 0; i < 7; i++)
        var ck = strsub(bin, i, i + 1)
        arraypush(BinArray, ck)
    end
    return BinArray
end
//時間格式轉換
function timeGetTime(HWND)
    var Time = GetTime(HWND)
    var hh = int(Time / 60 / 60)
    var mm = int(Time / 60) - (hh * 60)
    var ss = int(Time) - (hh * 60 * 60) - (mm * 60) 
    return strformat("%d 時 %d 分 %d 秒", hh, mm, ss)
end
//平均經驗計算
function expcount(HWND, exp)
    var Time = GetTime(HWND)
    if(Time > 0)
        return strcut((exp * 0.1 / Time * 60 * 60 * 10), 7, false)
    else
        return 0
    end
end
//檢測分流標題
function ServerNaming(HWND)
    var value = rmint(HWND, #00579EC4, 0)
    if(value >= 160 && value <= 167)
        value = value - 160
        return strformat("櫻之舞%s", GetSymbol(value))
    elseif(value >= 0 && value <= 7)
        return strformat("卡蓮%s", GetSymbol(value))
    elseif(value >= 420 && value <= 424)
        value = value - 420
        return strformat("露比%s", GetSymbol(value))
    elseif(value >= 80 && value <= 84)
        value = value - 80
        return strformat("獅子%s", GetSymbol(value))
    elseif(value >= 140 && value <= 143)
        value = value - 140
        return strformat("歌姬%s", GetSymbol(value))
    elseif(value >= 40 && value <= 41)
        value = value - 40
        return strformat("雙子%s", GetSymbol(value))
    end
end
//子分流判斷
function GetSymbol(value)
    select(value)
        case 0
        return "Ⅰ"
        case 1
        return "Ⅱ"
        case 2
        return "Ⅲ"
        case 3
        return "Ⅳ"
        case 4
        return "Ⅴ"
        case 5
        return "Ⅵ"
        case 6
        return "Ⅶ"
        case 7
        return "Ⅷ"
    end
end
//多類型找字
function FindString(content, num = 0, type = 0)
    var A = ""
    if(num == 2)
        A = bc.FindStrWithFontEx(0, 0, 640, 480, content, "ffffff-333333", 1.0, AESdecrypt("5417e1691e7c593da7c2b365ac1b6120"), 12, 1)
    elseif(num == 3)
        var H = array()
        bc.FindStrFast(0, 0, 640, 480, content, "ffff00-333333", 1.0, H[1], H[2])
        var z = array(H[1], H[2])
        if(H[1] > 0 && H[2] > 0)
            if(type == 1)
                return true
            end
            bc.MoveTo(H[1] + 10, H[2] + 4)
            bc.LeftClick()
            bc.MoveTo(0, 0)
            return true
        else
            return false
        end
    elseif(num == 0 || num == 1)
        A = bc.FindStrWithFontEx(0, 0, 640, 480, content, "ffffff-333333", 1.0, AESdecrypt("b0aa83e785fc2e4a3102a23f4ec2d028"), 9, 0)
    end
    var N
    var size = strsplit(A, "|", N)
    var H
    select(num)
        case 0
        strsplit(N[size - 1], ",", H)
        case 1
        strsplit(N[0], ",", H)
        case 2
        if(size == 1)
            strsplit(N[0], ",", H)
        elseif(size == 2)
            strsplit(N[size - 1], ",", H)
        elseif(size == 3)
            strsplit(N[size - 2], ",", H)
        else
            strsplit(N[size - 1], ",", H)
        end
    end
    var z = array(H[1], H[2])
    if(H[1] > 0 && H[2] > 0)
        if(type == 1)
            return true 
        end
        bc.MoveTo(H[1] + 10, H[2] + 4)
        bc.LeftClick()
        bc.MoveTo(0, 0)
        return true 
    else
        H = array()
        bc.FindStrFast(0, 0, 640, 480, content, "ffffff-333333", 1.0, H[1], H[2])
        z = array(H[1], H[2])
        if(H[1] > 0 && H[2] > 0)
            if(type == 1)
                return true
            end
            bc.MoveTo(H[1] + 10, H[2] + 4)
            bc.LeftClick()
            bc.MoveTo(0, 0)
            return true
        end
    end
    return false
end
//圖色找按鈕
function press(name, type, spc = 0.9)
    var ptx = 20
    var pty = 15
    if(name == "no" || name == "yes")
        ptx = 25
        pty = 25
    elseif(name == "close")
        ptx = 10
        pty = 10
    elseif(name == "retry")
        ptx = 20
        pty = 8
    end
    var x, y
    if(type == 0)
        if(name == 1)
            x = 317
            y = 197
            bc.MoveTo(x, y)
            bc.LeftClick()
            bc.MoveTo(0, 0)
            return true
        elseif(name == 2)
            x = 317
            y = 237
            bc.MoveTo(x, y)
            bc.LeftClick()
            bc.MoveTo(0, 0)
            return true
        elseif(name == 3)
            x = 317
            y = 276
            bc.MoveTo(x, y)
            bc.LeftClick()
            bc.MoveTo(0, 0)
            return true
        end
    elseif(type == 1)
        var f = bc.FindPic(0, 0, 640, 480, name & ".bmp", "", spc, 2, x, y)
        if(x > 0 && y > 0)
            bc.MoveTo(x + ptx, y + pty)
            bc.LeftClick()
            bc.MoveTo(0, 0)
            return true
        end
    end
    return false
end
//固定位按鈕
function p(content)
    bc.MoveTo(0, 0)
    var x, y
    select(content)
        case "cancel"
        x = 318
        y = 321
        case "OK"
        x = 318
        y = 321
        case "yes"
        x = 249
        y = 320
        case "no"
        x = 387
        y = 319
    end
    bc.MoveTo(x, y)
    bc.LeftClick()
    bc.MoveTo(0, 0)
end
//對話紀錄堆棧找內容
function MemFindString(HWND, content, addrs = "00C00000-00CFFFFF")
    var result = bc.FindString(HWND, addrs, content, 0)
    //traceprint(strformat("<%s>,%s", result, content))
    var ret = null
    strsplit(result, "|", ret)
    if(arraysize(ret) > 0 && result != "")
        return ret
    else
        return 0
    end
end
//初始化內存
function ClearFindStringResult(HWND, result)
    if(isarray(result))
        for(var i = 0; i < arraysize(result); i++)
            wmint(HWND, cint(result[i], 1), 0, 0)
        end
    end
end
//計算敵人數量
function GetEnemyCount(HWND)
    var count = 0
    var alive = traverse(HWND, #0058C6C7, 20, #04, 2, 100)
    for(var i = 10; i < 20; i++)
        if(alive[i] > 0)
            count++
        end
    end
    return count
end
//取得物品編號
function GetItemPos(name)
    for(var i = 0; i < 20; i++)
        if(itemName[i] == name)
            return i
        end
    end
    return -1
end
//進階取物品編號
function GetItemPosEx(name, type = 0, amount = -1)
    var tmp = array()
    for(var i = 0; i < 20; i++)
        if(itemAmount[i] == 0 && itemExist[i] > 0 && itemName[i] != "")
            itemAmount[i] = 1
        end
        select(type)
            case 0
            if(strfind(itemName[i], name) != -1)
                if(itemAmount[i] >= amount || amount == -1 || amount == 0)
                    arraypush(tmp, i)
                end
            end
            case 1
            if(itemName[i] == name)
                if(itemAmount[i] >= amount || amount == -1)
                    arraypush(tmp, i)
                end
            end
        end
    end
    return tmp
end
//取銀行物品編號
var BankItemExist = array()
var BankItemName = array()
function GetBankItemPos(HWND, name, type = 0)
    BankItemExist = traverse(HWND, #00C46348, 20, #0C44, 2, 100)
    BankItemName = traverse(HWND, #00C46354, 20, #0C44, 3, 100)
    var tmp = array()
    for(var i = 0; i < 20; i++)
        if(BankItemName != "")
            select(type)
                case 0
                if(strfind(BankItemName[i], name) != -1)
                    arraypush(tmp, i)
                end
                case 1
                if(BankItemName[i] == name)
                    arraypush(tmp, i)
                end
            end
        end
    end
    return tmp
end
//取多樣物品編號
function GetPreitemSpot(num)
    for(var i = 0; i < arraysize(preitemuse[num]); i++)
        if(preitemuse[num][i] != "")
            var ret = GetItemPos(preitemuse[num][i])
            if(ret != -1)
                return ret
            end
        end
    end
    select(num)
        case 1
        checksetstate("check41", false)
        case 2
        checksetstate("check34", false)
        case 3
        checksetstate("check43", false)
        case 4
        checksetstate("check44", false)
    end
    return -1
end
//判斷編碼並讀取文檔
function FileRead(path, type = 2)
    var Stream = com("ADODB.Stream")
    Stream.Type = type//1－二进制，2－文本
    Stream.charset("x-ansi")
    Stream.Open
    Stream.LoadFromFile(path)//读入文件
    var TEXT_a = Stream.ReadText(2)
    if(type == 2)
        var encode = strgetat(TEXT_a, 0) & "|" & strgetat(TEXT_a, 1)
        var Codes = ""
        select(encode)
            case "97|100"
            Codes = "UTF-8"  
            case "230|168"
            Codes = "UTF-8"  
            case "239|187"
            Codes = "UTF-8"  
            case "255|254"
            Codes = "Unicode"
            case "254|255"
            Codes = "Unicode big endian"        
            default
            Codes = "gb2312"  //txt文件的ANSI编码
        end
        Stream.Close
        Stream = null
        var tmp = ""
        if(Codes != "UTF-8")
            return filereadex(path)
        elseif(Codes == "UTF-8")
            Stream = com("ADODB.Stream")//创建对象
            Stream.Type = 2    //2=文本
            Stream.charset("UTF-8")
            Stream.Open  //打开文件流
            Stream.LoadFromFile(path)//读入文件
            tmp = Stream.readtext
            Stream.Close
            Stream = null
            return tmp
        end
    end
end
//判斷隊伍人數
function GetTeamCount(HWND)
    var groupstate = GetGroupState(HWND)
    if(groupstate)
        var tmp = 1
        for(var i = 0; i < 4; i++)
            if(isint(GroupMemberExist[i]))
                tmp = tmp + GroupMemberExist[i]
            end
        end
        traceprint(tmp)
        return tmp
    end
    return 0
end
//取得敵人編號
function GetEmptySpot()
    for(var i = 19; i > -1; i--)
        if(itemExist <= 0 && itemAmount[i] == 0 && itemName[i] == "")
            return i
            break
        end
    end
    return -1
end