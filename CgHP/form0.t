//名單列表設置面板
var form0listhwnd = 0
var form0caption = 0
var dropitem = array()
var preitemuse = array(array(), array(), array(), array(), array(), array())
var preHumanName = array()
function form0_init()
    SetWindowLongA(controlgetchildhwnd("form0"), 382470228)
    SetWindowLongA(controlgetchildhwnd("form0"), 65792, 1)
    SetWindowLongA(controlgethandle("form0combo", "form0"), 1442906690)
    //form0listhwnd = dllcall("user32.dll", "int", "CreateWindowExW", "int", 512, "wchar *", "ListBox", "wchar *", "", "int", 1442906561, "int", 9, "int", 64, "int", 177, "int", 137, "int", controlgetchildhwnd("form0"), "int", 0, "int", 0, "int", 0)
    form0listhwnd = controlgethandle("form0list", "form0")
    SetFont(controlgethandle("form0list", "form0"), 134886786, false)
    var form0hwnd = controlgetchildhwnd("form0")
    select(form0caption)
        case 0
        bc.SetWindowText(form0hwnd, "自動丟棄")
        SetItemList("form0combo", "form0")
        Getpreitemlist("form0list", dropitem, "form0")
        case 1
        bc.SetWindowText(form0hwnd, "戰鬥道具補血")
        SetItemList("form0combo", "form0")
        Getpreitemlist("form0list", preitemuse[1], "form0")
        case 2
        bc.SetWindowText(form0hwnd, "道具一般動作")
        SetItemList("form0combo", "form0")
        Getpreitemlist("form0list", preitemuse[2], "form0")
        case 3
        bc.SetWindowText(form0hwnd, "平時道具補血")
        SetItemList("form0combo", "form0")
        Getpreitemlist("form0list", preitemuse[3], "form0")
        case 4
        bc.SetWindowText(form0hwnd, "平時道具補氣")
        SetItemList("form0combo", "form0")
        Getpreitemlist("form0list", preitemuse[4], "form0")
        case 5
        bc.SetWindowText(form0hwnd, "自動登出名單")
        SetHumanList(bchwnd)
        GetpreHumanlist(preHumanName)
    end
end
function SetEditForm0(result, num, name, type = 0)
    //traceprint(strformat("%s %s %s", result, num, name))
    if(result)
        if(type == 0)
            var text = ""
            for(var i = 0; i < arraysize(preitemuse[num]); i++)
                text = strformat("%s|%s", text, preitemuse[num][i])
            end
            text = strtrim(text, "|")
            editsettext(name, text)
        elseif(type == 1)
            var text = ""
            editsettext(name, "")
            for(var i = 0; i < arraysize(preHumanName); i++)
                text = strformat("%s|%s", text, preHumanName[i])
            end
            text = strtrim(text, "|")
            editsettext(name, text)
        end
    end
end
function Getpreitemlist(name, ary, parent = "")
    var size = arraysize(ary)
    if(size != 0)
        for(var i = 0; i < size; i++)
            if(ary[i] != "")
                listaddtext(name, ary[i], parent)
            end
        end
        size = null
    end
end
function GetpreHumanlist(ary)
    var size = arraysize(ary)
    if(size != 0)
        for(var i = 0; i < size; i++)
            if(ary[i] != "")
                listaddtext("form0list", ary[i], "form0")
            end
        end
        size = null
    end
end
function SetItemList(name, parent = "")
    for(var i = 0; i < 20; i++)
        if(itemExist[i] > 0 && itemName[i] != "")
            comboaddtext(name, itemName[i], parent)
        end
    end
end
function SetHumanList(HWND)
    if(LoginPreCheck)
        HumanName = traverse(HWND, #0059924C, 60, #13C, 3, 100)
    end
    for(var i = 0; i < 60; i++)
        if(HumanName[i] != "")
            comboaddtext("form0combo", HumanName[i], "form0")
        end
    end
end
function form0down_click()
    var text = combogettext("form0combo", "form0")
    var tmparray = array()
    for(var i = 0; i < listgetcount("form0list", "form0"); i++)
        tmparray[i] = listgettext("form0list", i, "form0")
    end
    if(text != "" && form0listhwnd > 0 && arrayfindvalue(tmparray, text) == "")
        listaddtext("form0list", text, "form0")
    end
end
function form0up_click()
    listdeletetext("form0list", listgetcursel("form0list", "form0"), "form0")
end
function form0confirm_click()
    select(form0caption)
        case 0
        arrayclear(dropitem)
        AddListToArray(0)
        //traceprint(dropitem)
        case 1
        arrayclear(preitemuse[1])
        AddListToArray(1)
        traceprint(preitemuse[1])
        case 2
        arrayclear(preitemuse[2])
        AddListToArray(2)
        traceprint(preitemuse[2])
        case 3
        arrayclear(preitemuse[3])
        AddListToArray(3)
        traceprint(preitemuse[3])
        case 4
        arrayclear(preitemuse[4])
        AddListToArray(4)
        traceprint(preitemuse[4])
        case 5
        arrayclear(preHumanName)
        AddListToArray(5)
        traceprint(preHumanName)
    end
    controlclosewindow("form0", 1)
end
function AddListToArray(num)
    var tmparray = array()
    for(var i = 0; i < listgetcount("form0list", "form0"); i++)
        tmparray[i] = listgettext("form0list", i, "form0")
        if(tmparray[i] != "")
            select(num)
                case 0
                arraypush(dropitem, tmparray[i])
                case 1
                arraypush(preitemuse[1], tmparray[i])
                case 2
                arraypush(preitemuse[2], tmparray[i])
                case 3
                arraypush(preitemuse[3], tmparray[i])
                case 4
                arraypush(preitemuse[4], tmparray[i])
                case 5
                arraypush(preHumanName, tmparray[i])
            end
        end
    end
    arrayclear(tmparray)
end
//点击关闭_执行操作
function form0_close()
    form0listhwnd = 0
    controlclosewindow("form0", 0)
end