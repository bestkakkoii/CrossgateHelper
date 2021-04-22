//輸入框
var inputboxtext = null
var inputboxreturn = null
function inputbox_init()
    var hwnd = controlgetchildhwnd("inputbox")
    SetWindowLongA(hwnd, -1798832060)
    SetWindowLongA(hwnd, 65792, 1)
    SetWindowThemeEx(hwnd)
    var edithwnd = controlgethandle("editinput", "inputbox")
    SetWindowLongA(edithwnd, 1342242944)
    SetWindowLongA(edithwnd, 516, 1)
    SetWindowThemeEx(edithwnd)
    staticsettext("static51", inputboxtext, "inputbox")
    windowsetfocus(edithwnd)
end
function inputok_click()
    var content = editgettext("editinput", "inputbox")
    if(strlen(content) > 0)
        inputboxreturn = content
        controlclosewindow("inputbox", 1)
    else
        controlclosewindow("inputbox", 0)
    end
end
function inputokcancel_click()
    controlclosewindow("inputbox", 0)
end