var LKV = false
var KV = 0
var tmpva = ""
//自動驗證
function verification(HWND)
    var content = ""
    var ret0
    var ret1
    var ret2
    var retarr
    if(loginstate && LoginPreCheck)
        if(!LKV)
            var result = CRK[1].FindStringEx(HWND, "00500000-0068FFFF", "[Code]", 0, 2, 1, 1)
            if(result != "")
                var size0 = strsplit(result, "|", ret0)
                //traceprint(result)
                content = rmstring(HWND, cint(ret0[0], 1), 1000)
                //traceprint(content)
                retarr = regexmatchtext(content, "[/][A-Z][ ][0-9]{1,4}", false, true, false, false)
                //traceprint(retarr[0])
                if(retarr != null)
                    tmpva = retarr[0]
                    PushAnnounce(HWND, strformat("<系統提示>輸入驗證碼(%s)", retarr[0]))
                    bc.SendString2(HWND, retarr[0])
                    bc.KeyPress(13)
                    bc.Delay(500)
                    bc.KeyPress(13)
                    KV = 0
                    LKV = true
                end
            end
        else
            KV++
        end
        if(KV == 300)
            PushAnnounce(HWND, "<系統提示>開始清除驗證碼")
            var result1 = CRK[1].FindStringEx(HWND, "00400000-7FFFFFFF", tmpva, 0, 2, 1, 1)
            var size1 = strsplit(result1, "|", ret1)
            for(var j = 0; j < size1; j++)
                wmint(HWND, cint(ret1[j], 1), 0, 0)
            end
            var result2 = CRK[1].FindStringEx(HWND, "00400000-7FFFFFFF", "[Code]", 0, 2, 1, 1)
            var size2 = strsplit(result2, "|", ret2)
            for(var j = 0; j < size2; j++)
                wmint(HWND, cint(ret2[j], 1), 0, 0)
            end
            PushAnnounce(HWND, "<系統提示>驗證碼清除完成")
            KV = 0
            tmpva = ""
            LKV = false
        end
    end
    return false
end