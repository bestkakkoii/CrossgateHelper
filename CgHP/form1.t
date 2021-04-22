//目標對象選擇面板
var form1caption = 1
function form1_init()
    var form1hwnd = controlgetchildhwnd("form1")
    var handle = controlgethandle("form1group", "form1")
    SetWindowLongA(handle, 1442971911)
    SetWindowThemeEx(handle)
    SetWindowThemeEx(controlgethandle("form1comfirm", "form1"))
    SetWindowThemeEx(controlgethandle("form1cancel", "form1"))
    select(form1caption)
        case 0
        bc.SetWindowText(form1hwnd, "人物特定回合動作") 
        case 1
        bc.SetWindowText(form1hwnd, "人物一般回合動作") 
        case 2
        bc.SetWindowText(form1hwnd, "人物二段回合動作") 
        case 3
        bc.SetWindowText(form1hwnd, "人物特定敵數動作") 
        case 4
        bc.SetWindowText(form1hwnd, "人物特定氣力動作") 
        case 5
        bc.SetWindowText(form1hwnd, "精靈補血對象") 
        case 6
        bc.SetWindowText(form1hwnd, "精靈復活對象")
        case 7
        bc.SetWindowText(form1hwnd, "道具補血對象") 
        case 8
        bc.SetWindowText(form1hwnd, "寵物特定回合動作")
        case 9
        bc.SetWindowText(form1hwnd, "寵物一般回合動作") 
        case 10
        bc.SetWindowText(form1hwnd, "寵物特定氣力動作") 
    end
    for(var i = 0; i < 8; i++)
        checksetstate("form1ck" & i, Target_array[form1caption][i], "form1")
    end
    for(var i = 0; i < 10; i++)
        checksetstate("form1ckk" & i, Target_array2[form1caption][i], "form1")
    end
end
var Target_array = array()
var Target_array2 = array()
function SetTargetArray()
    for(var i = 0; i < 11; i++)
        if(i <= 4 || i >= 8)
            Target_array[i] = array(false, false, false, false, true, false, false, false, false, false, false)
        else
            Target_array[i] = array(true, true, false, false, false, false, false, false, false, false, false)
        end
        Target_array2[i] = array(false, false, false, false, false, false, false, false, false, false, false, false, false)
    end
end
function form1comfirm_click()
    for(var i = 0; i < 8; i++)
        Target_array[form1caption][i] = checkgetstate("form1ck" & i, "form1")
    end
    for(var i = 0; i < 10; i++)
        Target_array2[form1caption][i] = checkgetstate("form1ckk" & i, "form1")
    end
    var re = 0
    if(Target_array[form1caption][3])//我全
        re = 4
    elseif(Target_array[form1caption][0] && Target_array[form1caption][1])//己寵
        re = 9
    elseif(Target_array[form1caption][2] || Target_array2[form1caption][0] || Target_array2[form1caption][1] || Target_array2[form1caption][2] || Target_array2[form1caption][3] || Target_array2[form1caption][4] || Target_array2[form1caption][5] || Target_array2[form1caption][6] || Target_array2[form1caption][7] || Target_array2[form1caption][8] || Target_array2[form1caption][9]) //我任
        re = 3
    elseif(Target_array[form1caption][0])//自己
        re = 1
    elseif(Target_array[form1caption][1])//寵物
        re = 2
    elseif(Target_array[form1caption][5])//敵全
        re = 6
    elseif(Target_array[form1caption][6])//敵前
        re = 7
    elseif(Target_array[form1caption][7])//敵後
        re = 8
    elseif(Target_array[form1caption][4])//敵人
        re = 5
    else
        re = -1
    end
    controlclosewindow("form1", re)
end
function form1cancel_click()
    controlclosewindow("form1", 0)
end
function SetTargetButtonText(i, value)
    var re = ""
    if(value == 1)//自己
        re = "自己"
    elseif(value == 2)//寵物
        re = "寵物"
    elseif(value == 3) //我任
        re = "我任"
    elseif(value == 4)//我全
        re = "我全"
    elseif(value == 5)//敵人
        re = "敵人"
    elseif(value == 6)//敵全
        re = "敵全"
    elseif(value == 7)//敵前
        re = "敵前"
    elseif(value == 8)//敵後
        re = "敵後"
    elseif(value == 9)//己寵
        re = "己寵"
    elseif(value == -1)
        return buttonsettext("button" & i, "")
    else
        return 0
    end
    buttonsettext("button" & i, re)
end