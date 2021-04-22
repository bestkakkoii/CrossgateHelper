//倉庫存領面板
var form3listhwnd = 0
function form3_init()
    var form3hwnd = controlgetchildhwnd("form3")
    SetWindowLongA(controlgetchildhwnd("form3"), 382470228)
    SetWindowLongA(controlgetchildhwnd("form3"), 65792, 1)
    SetWindowLongA(controlgethandle("form3combo", "form3"), 1442906690)
    SetWindowThemeEx(controlgethandle("form3comfirm", "form3"))
    form3listhwnd = controlgethandle("form3list", "form3")
    SetFont(controlgethandle("form3list", "form3"), 134886786, false)
    SetItemList("form3combo", "form3")
    // Getpreitemlist("form3list", dropitem, "form3")
end
function form3comfirm_click()
    var tmparray = array()
    var count = listgetcount("form3list", "form3")
    if(count > 0)
        SetBankPageOn(bchwnd)
        bc.Delay(300)
        for(var i = 0; i < count; i++)
            tmparray[i] = listgettext("form3list", i, "form3")
            if(tmparray[i] != "")
                if(radiogetstate("form3radio0", "form3"))
                    SetItemDeposit(bchwnd, tmparray[i], 0, editgettext("form3edit0", "form3"))
                elseif(radiogetstate("form3radio1", "form3"))
                    SetItemWithdraw(bchwnd, tmparray[i])
                end
            end
            bc.Delay(1000)
        end
    end
    controlclosewindow("form3", 1)
end
function form3down_click()
    var text = combogettext("form3combo", "form3")
    var tmparray = array()
    for(var i = 0; i < listgetcount("form3list", "form3"); i++)
        tmparray[i] = listgettext("form3list", i, "form3")
    end
    if(text != "" && form3listhwnd > 0 && arrayfindvalue(tmparray, text) == "")
        listaddtext("form3list", text, "form3")
    end
end
function form3up_click()
    listdeletetext("form3list", listgetcursel("form3list", "form3"), "form3")
end
function form3radio1_click()
    SetBankPageOn(bchwnd)
    bc.Delay(300)
    SetItemListEx("form3combo", "form3")
end
function SetItemListEx(name, parent = "")
    BankItemName = traverse(bchwnd, #00C46354, 20, #0C44, 3, 100)
    for(var i = 0; i < 20; i++)
        if(BankItemName[i] != "")
            comboaddtext(name, BankItemName[i], parent)
        end
    end
    SetBankPage(bchwnd, 1)
    bc.Delay(800)
    BankItemName = traverse(bchwnd, #00C46354, 20, #0C44, 3, 100)
    for(var i = 0; i < 20; i++)
        if(BankItemName[i] != "")
            comboaddtext(name, BankItemName[i], parent)
        end
    end
    SetBankPage(bchwnd, 0)
end