//傳送選擇面板
function form2_init()
    SetWindowLongA(controlgetchildhwnd("form2"), 128, 1)
    var handle = controlgethandle("form2group", "form2")
    SetWindowLongA(handle, 1442971911)
    SetWindowThemeEx(handle)
end
function SetTeleport(HWND, type)
    if(HWND > 0 && LoginPreCheck)
        select(type)
            case 0
            bc.SendString2(HWND, AESdecrypt("121d2839e8e89d8b83b71f06fbb008cf"))
            case 1
            bc.SendString2(HWND, "/pk")
            case 2
            bc.SendString2(HWND, "/豪華屋")
            case 3
            bc.SendString2(HWND, "/中型屋")
            case 4
            bc.SendString2(HWND, "/國民屋")
        end
        bc.KeyPress(13)
    end
end
function form2ck0_click()
    SetTeleport(bchwnd, 0)
    checksetstate("form2ck0", false, "form2")
end
function form2ck1_click()
    SetTeleport(bchwnd, 1)
    checksetstate("form2ck1", false, "form2")
end
function form2ck2_click()
    SetTeleport(bchwnd, 2)
    checksetstate("form2ck2", false, "form2")
end
function form2ck3_click()
    SetTeleport(bchwnd, 3)
    checksetstate("form2ck3", false, "form2")
end
function form2ck4_click()
    SetTeleport(bchwnd, 4)
    checksetstate("form2ck4", false, "form2")
end