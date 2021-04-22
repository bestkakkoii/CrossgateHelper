//彙編功能
//
//目標進程內注入與調用
function call(HWND, content, mode, n)
    if(isarray(content))
        var ASM = com("bc.kakoii")
        for(var i = 0; i < arraysize(content); i++)
            if(content[i] != "")
                ASM.AsmAdd(content[i])
            end
        end
        ASM.AsmCall(HWND, mode)
        ASM.AsmClear()
        arrayclear(content)
        ASM = null
    end
end
//寫入主要彙編代碼段
function SetData(HWND, MainData)
    if(bchwnd > 0 && loginstate)
        var server = rmint(HWND, #00D0CEA0, 0)
        wmint(HWND, #00D80B10, 0, server)
        var PostMessageA = GetProcAddress(AESdecrypt("8c7d76f018881849148e57ac5d0464ab"), AESdecrypt("bfe93dcd79c68e09f10f4953150f78a5"))
        //traceprint("PostMessageA Addr: " & chex(PostMessageA))
        wmint(HWND, #00E3216C, 0, PostMessageA)
        PostMessageA = null
        wmint(HWND, #00D80AE0, 0, m_hwnd)
        //
        wmdata(HWND, #00DF0000, MainData)
        //
        SetTimeExtension(HWND)
        //Announce
        wmint(HWND, #00D1EF50, 0, 0)
        wmdata(HWND, #00502DB0, AESdecrypt("b76e4fd0cf2ce8fd3d88056596c6d79bc4f7aef3047b549ede3c54fa660b7c03"))
        if(checkgetstate("check30"))
            SetCombatSys(HWND)
        end
        //FindRoute
        wmdata(HWND, #0046447C, AESdecrypt("c313af51268cbfd11099743515134cba"))//bluecg.exe+958DD0尋路開關[00D58DD0]
        //CordHOOK
        wmdata(HWND, #004C34F0, AESdecrypt("6aa7db65142f95ca3709d6fa3a5cb5279acdce0def740b4cdaf05600d925ac022f5509620c770a59b882cf43c5228b30"))
        if(checkgetstate("check13"))
            bc.Delay(1000)
            //GetTickCount
            wmint(HWND, #00E7FD74, 0, combogetcursel("combobox3"))
            wmdata(HWND, #00516506, AESdecrypt("706d4bbfa6b6209784baedc2361b9a80c96a91f0f6bc198a68d57aab10e65338"))
            SetSuperSpeed(HWND)
        end
    end
end
//自動戰鬥開與關
function AutoCombatOnOff(HWND)
    if(checkgetstate("check30"))
        SetCombatSys(HWND)
    else
        RecoverCombatSys(HWND)
    end
end
function SetCombatSys(HWND)
    if(bchwnd > 0)
        //人物面板音效
        wmdata(HWND, #00490ED7, AESdecrypt("6d056bc88d714d9477eb9bd423368c48"))
        //戰寵面板音效
        wmdata(HWND, #00491285, AESdecrypt("6d056bc88d714d9477eb9bd423368c48"))
        //秒數關閉
        wmdata(HWND, #0049113E, AESdecrypt("6d056bc88d714d9477eb9bd423368c48"))
        //寵物技能面板        wmdata(HWND, #00491253, AESdecrypt("6d056bc88d714d9477eb9bd423368c48"))
        //騎寵戰鬥中第一次騎寵/地二回合2面板音效
        wmdata(HWND, #00490D22, AESdecrypt("6d056bc88d714d9477eb9bd423368c48"))
        //經驗結算面板
        wmdata(HWND, #004FAA5D, AESdecrypt("6d056bc88d714d9477eb9bd423368c48"))
    end
end
function RecoverCombatSys(HWND)
    if(bchwnd > 0)
        //人物面板音效
        wmdata(HWND, #00490ED7, AESdecrypt("77cf9785011a5d72eebda39374681af1"))
        //戰寵面板音效
        wmdata(HWND, #00491285, AESdecrypt("888534773cc6da1dd8efa763ae131472"))
        //秒數
        wmdata(HWND, #0049113E, AESdecrypt("4e4c98b700e889adb9dc598190445d08"))
        //寵物技能面板
        wmdata(HWND, #00491253, AESdecrypt("20ee7565e8a61e21a62e825014169ec8"))
        ////騎寵首回合
        //WriteData(HWND, #00490CDF, "E8 EC E7 FF FF")
        ////騎寵戰鬥中第一次騎寵/地二回合面板音效
        //WriteData(HWND, #00490D11, "E8 5A DF FF FF 68 F0 00 00 00 68 40 01 00 00 6A 38 E8 D9 0F 09 00 83 C4 18")
        //sleep(10, false)
        //騎寵戰鬥中第一次騎寵/地二回合2面板音效
        wmdata(HWND, #00490D22, AESdecrypt("eaf5dc3b458693199947b3daeb9502ec"))
        //經驗結算面板
        wmdata(HWND, #004FAA5D, AESdecrypt("fb4763899044546695638480e4df63c2"))
    end
end
//超級加速
function SetSuperSpeed(HWND)
    if(bchwnd > 0)
        if(checkgetstate("check13"))
            superspeedstate = combogetcursel("combobox3")
            wmdata(HWND, #00404432, AESdecrypt("a3ba8bb4504dcc0bafd66cf335d5a9fbe8ed0953a15f968417aebe4dfec86d1a6a730395f4c0596c723904632cf93f53eb965cd8ee7124c974d37d1fc44e6651"))
            bc.Delay(10)
            wmint(HWND, #00E7FD74, 0, superspeedstate)//加速寫入
        else
            wmint(HWND, #00F4C460, 0, 100)
            bc.Delay(10)
            wmdata(HWND, #00404432, AESdecrypt("b15d564e971dfe84ee0d3fa91537789ce9df263ccb8b18565fde7d80439cbd03efd6ef6ddfb50c0921d549f32583e2d505e6b0369f9792ee6c2bdc1c89a179fb")) 
        end
    end
end
//戰鬥讀秒
function SetTimeExtension(HWND)
    //秒數99
    if(bchwnd > 0)
        if(checkgetstate("check28"))
            wmdata(HWND, #004381C1, AESdecrypt("5b35045fa923883bdc5b4153326e582d"))
        else
            wmdata(HWND, #004381C1, AESdecrypt("d66964ddb030de1713a24fa1823400b0"))
        end
    end
end
//黃字公告
function PushAnnounce(HWND, content)
    if(content == "")
        return false
    end
    if(bchwnd > 0)
        wmstring(HWND, #00D1EF50, content)
        var tmp = array()
        tmp[0] = "33c3qOUqswbreIvAC7hcxA=="
        call(HWND, tmp, 2, 0)
        content = null
        arrayclear(tmp)
    end
end
//抓起物品
function PickItem(HWND, spot)
    if(bchwnd > 0 && LoginPreCheck && !combatstate)
        if(!isint(spot))
            return false
        end
        if(spot >= 20)
            return false
        end
        if(itemExist[spot] > 0)
            wmint(HWND, #005DE628, 0, (spot + 8))
            var tmp = array()
            tmp[0] = "c7c2qOUqswbreIvAC7grxg=="
            call(HWND, tmp, 2, 1)
            wmint(HWND, #005DE628, 0, 0)
        end
        spot = null
    end
end
//聲音屏蔽
var volume0 = 0
var volume1 = 0
function Mute(HWND)
    if(bchwnd > 0)
        var  volumeSet0 = 0
        var  volumeSet1 = 0
        var tmp = array()
        if(checkgetstate("check6"))
            volume0 = rmint(HWND, #0057C4F0, 0)
            volume1 = rmint(HWND, #0057C4F4, 0)
            volumeSet0 = 0
            volumeSet1 = 0
        else
            volumeSet0 = volume0
            volumeSet1 = volume1
        end
        tmp[0] = strformat("mov eax,0%X", volumeSet0)
        tmp[1] = strformat("mov ebx,0%X", volumeSet1)
        tmp[2] = "mov [0057C4F0],eax"
        tmp[3] = "mov [0057C4F4],ebx"
        tmp[4] = "call 00521C80"
        call(HWND, tmp, 2, 2)
        arrayclear(tmp)
        volumeSet0 = null
        volumeSet1 = null
    end
end
//組隊
function GroupJoin(HWND, type)
    if(bchwnd > 0 && LoginPreCheck && !combatstate)
        if(!isint(type))
            return false
        end
        if(type < 0 || type > 1)
            return false
        end
        wmdata(HWND, #00469134, AESdecrypt("6d056bc88d714d9477eb9bd423368c48"))
        var tmp = array()
        select(type)
            case 0
            tmp[0] = "mov eax,01"
            case 1
            tmp[0] = "mov eax,00"
        end
        tmp[1] = "mov [00F62926],eax"
        tmp[2] = "call 00468FF0"
        call(HWND, tmp, 2, 3)
        arrayclear(tmp)
        type = null
    end
end
//關閉句柄
function CloseHandle(HWND, handle)
    if(bchwnd > 0)
        var tmp = array()
        tmp[0] = strformat("push 0%X", handle)
        tmp[1] = strformat("call 0", GetProcAddress("kernel32", "CloseHandle"))
        call(HWND, tmp, 2, 4)
        arrayclear(tmp)
        handle = null
    end
end
//省略過圖動畫
function SkipEffect(HWND)
    if(bchwnd > 0)
        if(checkgetstate("check9"))
            var Data = AESdecrypt("7a7562112945b84a1e17e27cdc2fc255bd91f2f12dfba6e959892b7ffcb605c5")
            wmdata(HWND, #00463B97, Data)
            Data = null
        else
            var Data = AESdecrypt("7a7562112945b84a1e17e27cdc2fc255c2dda78208bb1646f58b5d8df83d8d9d")
            wmdata(HWND, #00463B97, Data)
            Data = null
            //關閉所有戰鬥行為動畫
            //wmdata(#00438E3F, "C7 05 70 57 59 00 02 00 00 00")
        end
    end
end
//使用物品
function UseItem(HWND, num)
    if(bchwnd > 0 && LoginPreCheck && !combatstate)
        if(!isint(num))
            return false
        end
        if(num >= 20)
            return false
        end
        if(itemExist[num] > 0)
            wmint(HWND, #00E913D0, 0, num + 8)
            var tmp = array()
            tmp[0] = "6634qOUqswbreIvAC71awg=="
            call(HWND, tmp, 2, 5)
            arrayclear(tmp)
        end
        num = null
    end
end
//含目標使用物品
function UseItemSuper(HWND, spot, target)
    if(bchwnd > 0 && LoginPreCheck && !combatstate)
        if(!isint(spot) || !isint(target))
            return false
        end
        if(spot >= 20 || target >= 6)
            return false
        end
        if(itemExist[spot] > 0)
            wmint(HWND, #00E913E0, 0, (spot + 8))
            wmint(HWND, #00E913F0, 0, target)
            var tmp = array()
            tmp[0] = "0780qOUqswbreIvAC7ottQ=="
            call(HWND, tmp, 2, 6)
            arrayclear(tmp)
            wmint(HWND, #00E913E0, 0, 0)
            wmint(HWND, #00E913F0, 0, 0)
        end
        spot = null
        target = null
    end
end
//設置銀行頁面
function SetBankPage(HWND, pg)
    if(bchwnd > 0 && LoginPreCheck && !combatstate)
        if(!isint(pg))
            return false
        end
        if(pg > 1 || pg < 0)
            return false
        end
        var tmp = array()
        tmp[0] = strformat("mov eax,0%X", pg)
        tmp[1] = "mov dword ptr ds:[00CD91D0],eax"
        tmp[2] = "mov ecx,dword ptr ds:[00D0CEA0]"
        tmp[3] = strformat("push 0%X", pg + 1)
        tmp[4] = "push ecx"
        tmp[5] = "call 00508630"
        tmp[6] = "add esp,04"
        call(HWND, tmp, 2, 7)
        arrayclear(tmp)
        pg = null
    end
end
//存倉
function SetDepositBank(HWND, spot, target)
    if(bchwnd > 0 && LoginPreCheck && !combatstate)
        if(!isint(spot) || !isint(target))
            return false
        end
        if(spot > 20 || spot < 0 || target > 20 || target < 0)
            return false
        end
        var tmp = array()
        tmp[0] = strformat("mov ebx,0%X", spot)
        tmp[1] = strformat("mov ecx,0%X", target)
        tmp[2] = "add ecx,64"
        tmp[3] = "push ecx"
        tmp[4] = "lea ecx,dword ptr ss:[ebx+08]"
        tmp[5] = "push ecx"
        tmp[6] = "push 022"
        tmp[7] = "push 029"
        tmp[8] = "call 00480D10"
        tmp[9] = "add esp,010"
        call(HWND, tmp, 2, 8)
        arrayclear(tmp)
        spot = null
        target = null
    end
end
//提倉
function SetBankWithdraw(HWND, spot, target)
    if(bchwnd > 0 && LoginPreCheck && !combatstate)
        if(!isint(spot) || !isint(target))
            return false
        end
        if(spot > 20 || spot < 0 || target > 20 || target < 0)
            return false
        end
        var tmp = array()
        tmp[0] = strformat("mov edx,0%X", spot)
        tmp[1] = strformat("mov ecx,0%X", target)
        tmp[2] = "add edx,064"
        tmp[3] = "add ecx,08"
        tmp[4] = "push -01"
        tmp[5] = "mov dword ptr ds:[00C75C98],edx"
        tmp[6] = "mov dword ptr ds:[00CAF080],ecx"
        tmp[7] = "call 00480BD0"
        tmp[8] = "add esp,04"
        call(HWND, tmp, 2, 9)
        arrayclear(tmp)
        spot = null
        target = null
    end
end
//按鈕
function PressButton(HWND, content)
    if(bchwnd > 0 && LoginPreCheck && !combatstate)
        var hex = null
        var tmp = array()
        if(isint(content))
            select(content)
                case 0
                tmp[0] = "call 00495EA0"
                call(HWND, tmp, 2, 10)
                arrayclear(tmp)
                content = null
                return false
                case 1
                hex = "0"
                case 2
                hex = "2"
                case 3
                hex = "4"
            end
            if(hex != null)
                tmp[0] = "mov eax,00495EA0"
                tmp[1] = "push 0" & hex
                tmp[2] = "push eax"
                tmp[3] = "call 00495EA0"
                tmp[4] = "add esp,08"
                call(HWND, tmp, 2, 11)
                arrayclear(tmp)
            end
        else
            select(content)
                case "是"
                hex = "4"
                case "否"
                hex = "8"
                case "確定"
                hex = "1"
            end
            if(hex != null)
                tmp[0] = "mov eax,0" & hex
                tmp[1] = "push eax"
                tmp[2] = "call 00495EA0"
                tmp[3] = "add esp,04"
                call(HWND, tmp, 2, 12)
                arrayclear(tmp)
            end
        end
        hex = null
        content = null
    end
end
//防禦
function SetDefend(HWND)
    if(bchwnd > 0 && LoginPreCheck && combatstate)
        infoshow[0] = AESdecrypt("298027bdd6bca58c818d010379474124")
        bc.Delay(500)
        var tmp = array()
        tmp[0] = "mov esi,00000001"
        tmp[1] = "xor edi,edi"
        tmp[2] = "mov dword ptr ds:[005989B8],esi"
        tmp[3] = "mov dword ptr ds:[005989A8],edi"
        tmp[4] = "call 00437D10"
        tmp[5] = "mov ecx,dword ptr ds:[00D0CEA0]"
        tmp[6] = "push 00543F84"
        tmp[7] = "push ecx"
        tmp[8] = "call 00506860"
        tmp[9] = "mov dword ptr ds:[00598938],edi"
        tmp[10] = "mov dword ptr ds:[005989AC],esi"
        tmp[11] = "add esp,08"
        call(HWND, tmp, 2, 13)
        arrayclear(tmp)
    end
end
//位置
function SetPosition(HWND)
    if(bchwnd > 0 && LoginPreCheck && combatstate)
        bc.Delay(500)
        var tmp = array()
        tmp[0] = "mov esi,00000001"
        tmp[1] = "mov eax,06"
        tmp[2] = "mov dword ptr ds:[005989A8],eax"
        tmp[3] = "mov dword ptr ds:[005989CC],esi"
        tmp[4] = "call 00437D10"
        tmp[5] = "mov ecx,dword ptr ds:[00D0CEA0]"
        tmp[6] = "push 00543F1C"
        tmp[7] = "push ecx"
        tmp[8] = "call 00506860"
        tmp[9] = "mov edx,dword ptr ds:[00598938]"
        tmp[10] = "push edx"
        tmp[11] = "call 00404D00"
        tmp[12] = "push 000000F0"
        tmp[13] = "push 00000140"
        tmp[14] = "push 039"
        tmp[15] = "mov eax,00"
        tmp[16] = "mov dword ptr ds:[00598938],eax"
        tmp[17] = "mov dword ptr ds:[005989AC],esi"
        tmp[18] = "call 00521D00"
        tmp[19] = "add esp,018"
        call(HWND, tmp, 2, 14)
        arrayclear(tmp)
    end
end
//逃跑
function SetRunaway(HWND)
    if(bchwnd > 0 && LoginPreCheck && combatstate)
        infoshow[0] = AESdecrypt("5b83e50aec3a10bff7a6d4c81462f04f")
        bc.Delay(500)
        var tmp = array()
        tmp[0] = "mov esi,00000001"
        tmp[1] = "xor edi,edi"
        tmp[2] = "mov dword ptr ds:[005989D0],esi"
        tmp[3] = "mov dword ptr ds:[005989A8],edi"
        tmp[4] = "mov ecx,dword ptr ds:[00D0CEA0]"
        tmp[5] = "push 00543F08"
        tmp[6] = "push ecx"
        tmp[7] = "call 00506860"
        tmp[8] = "mov dword ptr ds:[00598938],edi"
        tmp[9] = "mov dword ptr ds:[005989AC],esi"
        tmp[10] = "add esp,08"
        call(HWND, tmp, 2, 15)
        arrayclear(tmp)
    end
end
//攻擊
function SetBasicAttack(HWND, target)
    if(bchwnd > 0 && LoginPreCheck)
        if(!isint(target))
            return false
        end
        infoshow[0] = strformat("人物對 %d 使用攻擊", target)
        var tmp = array()
        tmp[0] = "mov ecx,00"
        tmp[1] = strformat("mov eax,0%X", target)//目標位置
        tmp[2] = "push eax"
        tmp[3] = "lea edx,dword ptr ss:[esp+014]"
        tmp[4] = "push 00543F00"
        tmp[5] = "push edx"
        tmp[6] = "call 00530AE4"
        tmp[7] = "mov ecx,dword ptr ds:[00D0CEA0]"
        tmp[8] = "lea eax,dword ptr ss:[esp+01C]"
        tmp[9] = "push eax"
        tmp[10] = "push ecx"
        tmp[11] = "call 00506860"
        tmp[12] = "add esp,14"
        tmp[13] = "mov eax,dword ptr ds:[0059892C]"
        tmp[14] = "mov edx,02"
        tmp[15] = "mov dword ptr ds:[00598974],edx"
        tmp[16] = "inc eax"
        tmp[17] = "mov dword ptr ds:[0059892C],eax"
        tmp[18] = "call 0048F0A0"
        call(HWND, tmp, 2, 16)
        arrayclear(tmp)
        target = null
    end
end
//技能攻擊
function SetSkillAttack(HWND, sk, lv, target)
    if(bchwnd > 0 && LoginPreCheck && combatstate)
        if(!isint(sk) || !isint(lv) || !isint(target))
            return false
        end
        if(isarray(skillLVname))
            if(isarray(skillLVname[sk]))
                infoshow[0] = strformat("人物對 %d 使用 技能 %s", target, skillLVname[sk][lv])
            end
        end
        var tmp = array()
        tmp[0] = strformat("mov edx,0%X", lv)//技能等級<bluecg.exe>+1989B0
        tmp[1] = strformat("mov eax,0%X", target)//對象
        tmp[2] = "push eax"//對象 #28我方全體 #29敵方全體
        tmp[3] = strformat("mov eax,0%X", sk)
        tmp[4] = "push edx"
        tmp[5] = "push eax"
        tmp[6] = "lea ecx,dword ptr ss:[esp+01C]"
        tmp[7] = "push 00543E50"
        tmp[8] = "push ecx"
        tmp[9] = "call 00530AE4"
        tmp[10] = "mov eax,dword ptr ds:[00D0CEA0]"
        tmp[11] = "lea edx,dword ptr ss:[esp+024]"
        tmp[12] = "push edx"
        tmp[13] = "push eax"
        tmp[14] = "call 00506860"
        tmp[15] = "add esp, 01C"
        tmp[16] = "mov eax,dword ptr ds:[0059892C]"
        tmp[17] = "mov edx,02"
        tmp[18] = "mov dword ptr ds:[00598974],edx"
        tmp[19] = "inc eax"
        tmp[20] = "mov dword ptr ds:[0059892C],eax"
        tmp[21] = "call 0048F0A0"
        call(HWND, tmp, 2, 17)
        arrayclear(tmp)
        sk = null
        lv = null
        target = null
    end
end
//寵物動作
function SetPetAttack(HWND, target, sk)
    if(bchwnd > 0 && LoginPreCheck && combatstate)
        if(!isint(target) || !isint(sk))
            return false
        end
        if(isarray(petskillname))
            infoshow[1] = strformat("寵物對 %d 使用 %s", target, petskillname[sk])
        end
        var tmp = array()
        tmp[0] = strformat("mov eax,0%X", target)
        tmp[1] = "push eax"//目標
        tmp[2] = strformat("mov eax,0%X", sk)//選技能 <bluecg.exe>+143DE4
        tmp[3] = "push eax"
        tmp[4] = "lea ecx,dword ptr ss:[esp+018]"
        tmp[5] = "push 00543EC0"
        tmp[6] = "push ecx"
        tmp[7] = "call 00530AE4"
        tmp[8] = "mov eax,dword ptr ds:[00D0CEA0]"
        tmp[9] = "lea edx,dword ptr ss:[esp+020]"
        tmp[10] = "push edx"
        tmp[11] = "push eax"
        tmp[12] = "call 00506860"
        tmp[13] = "mov dword ptr ds:[005989AC],ebx"
        tmp[14] = "add esp,018"
        tmp[15] = "mov eax,dword ptr ds:[0059892C]"
        tmp[16] = "mov edx,02"
        tmp[17] = "mov dword ptr ds:[00598974],edx"
        tmp[18] = "inc eax"
        tmp[19] = "mov dword ptr ds:[0059892C],eax"
        tmp[20] = "call 0048F0A0"
        call(HWND, tmp, 2, 18)
        arrayclear(tmp)
        target = null
        sk = null
    end
end
//戰鬥物品動作
function SetItemAttack(HWND, spot, target)
    if(bchwnd > 0 && LoginPreCheck && combatstate)
        if(!isint(spot))
            return false
        end
        if(isarray(itemName))
            infoshow[0] = strformat("人物對 %d 使用 物品 %s", target, itemName[spot])
        end
        var tmp = array()
        tmp[0] = strformat("mov ecx,0%X", spot + 8)//道具位置0+8
        tmp[1] = strformat("mov eax,0%X", target)
        tmp[2] = "push eax"//目標 #29(41) = 全體
        tmp[3] = "push ecx"
        tmp[4] = "lea edx,dword ptr ss:[esp+018]"
        tmp[5] = "push 00543EF8"
        tmp[6] = "push edx"
        tmp[7] = "call 00530AE4"
        tmp[8] = "mov ecx,dword ptr ds:[00D0CEA0]"
        tmp[9] = "lea eax,dword ptr ss:[esp+020]"
        tmp[10] = "push eax"
        tmp[11] = "push ecx"
        tmp[12] = "call 00506860"
        tmp[13] = "mov dword ptr ds:[005989AC],ebx"
        tmp[14] = "add esp,018"
        tmp[15] = "mov eax,dword ptr ds:[0059892C]"
        tmp[16] = "mov edx,02"
        tmp[17] = "mov dword ptr ds:[00598974],edx"
        tmp[18] = "inc eax"
        tmp[19] = "mov dword ptr ds:[0059892C],eax"
        tmp[20] = "call 0048F0A0"
        call(HWND, tmp, 2, 19)
        arrayclear(tmp)
        spot = null
        target = null
    end
end
//回點
function ReturnBase(HWND)
    var value = rmint(HWND, #00F62954, 0)
    if(bchwnd > 0 && LoginPreCheck && loginstate)
        if(value == 3 || value == 4 || value == 6)
            var tmp = array()
            tmp[0] = "4a80qOUqswbreIvAC7gtzw=="
            call(HWND, tmp, 2, 20)
            arrayclear(tmp)
        end
    end
    value = null
end
//登出
function LogOut(HWND)
    var value = rmint(HWND, #00F62954, 0)
    if(bchwnd > 0 && LoginPreCheck && loginstate)
        if(value == 3 || value == 4 || value == 6)
            var tmp = array()
            tmp[0] = "eeb7qOUqswbreIvAC7suwA=="
            call(HWND, tmp, 2, 21)
            arrayclear(tmp)
            wmint(HWND, #00598858, 2, 1)//初始化非戰鬥狀態
            wmint(HWND, #00D15718, 2, 0)//初始化登出狀態
        end
    end
    value = null
end
//設置寵物狀態戰鬥或休息
function LockPetPos0(HWND, pos)
    if(bchwnd > 0 && LoginPreCheck)
        if(!isint(pos))
            return false
        end
        var tmp = array()
        tmp[0] = strformat("mov eax,0%X", pos)
        tmp[1] = "mov ecx,dword ptr ss:[eax*4+00C43138]"
        tmp[2] = "mov ecx,dword ptr ds:[00C462C8]"
        tmp[3] = "mov ebx,02"
        tmp[4] = "and dword ptr [ecx*4+00C43138],-03"
        tmp[5] = "mov dword ptr ss:[eax*4+00C43138],ebx"
        tmp[6] = "call 00485B10"
        tmp[7] = "call 004761B0"
        tmp[8] = "mov eax,dword ptr ss:[esp+010]"
        call(HWND, tmp, 2, 22)
        arrayclear(tmp)
        tmp[0] = "call 00485A91"
        tmp[1] = "call 00485A91"
        call(HWND, tmp, 2, 23)
        arrayclear(tmp)
        pos = null
    end
end
//騎乘
function LockPetPos1(HWND, pos)
    if(bchwnd > 0 && LoginPreCheck)
        if(!isint(pos))
            return false
        end
        var tmp = array()
        tmp[0] = "mov esi,dword ptr ds:[00CAFDC8]"
        tmp[1] = "mov edx,dword ptr ds:[00D0CEA0]"
        tmp[2] = "push 00580590"
        tmp[3] = "neg cl"
        tmp[4] = "sbb ecx,ecx"
        tmp[5] = "push -01"
        tmp[6] = "and ecx,064"
        tmp[7] = "push ebx"
        tmp[8] = "add ecx,esi"
        tmp[9] = "push ecx"
        tmp[10] = "push edx"
        tmp[11] = "call 00507D70"
        tmp[12] = "add esp,014"
        call(HWND, tmp, 1, 24)
        arrayclear(tmp)
        pos = null
    end
end
//開啟人寵戰鬥面板
function GetCombatPage(HWND, type)
    if(bchwnd > 0 && LoginPreCheck)
        if(!isint(type))
            return false
        end
        if(type < 0 || type > 1)
            return false
        end
        var tmp = array()
        tmp[0] = "push 00"
        tmp[1] = "push 00000155"
        select(type)
            case 0
            tmp[2] = "push 00"
            case 1
            tmp[2] = "push 03"
        end
        tmp[3] = "call 0048EC70"
        tmp[4] = "add esp,0C"
        call(HWND, tmp, 2, 25)
        arrayclear(tmp)
        type = null
    end
end
//走路
function SetMovement(HWND, x, y)
    //traceprint(strformat("%d(%X),%d(%X)", x, x, y, y))
    if(bchwnd > 0 && loginstate && !combatstate && LoginPreCheck)
        if(!isint(x) || !isint(y))
            return false
        end
        if(x < 0 || y < 0)
            return false
        end
        wmint(HWND, #00D58E0C, 0, x)
        wmint(HWND, #00D58E1C, 0, y)
        var tmp = array()
        tmp[0] = "7470qOUqswbreIvAC7spsQ=="
        call(HWND, tmp, 2, 26)
        arrayclear(tmp)
        x = null
        y = null
        wmint(HWND, #00D58E0C, 0, 0)
        wmint(HWND, #00D58E1C, 0, 0)
    end
end
//線程走路
function SetMovementEx(XYarray)
    var x = XYarray[0]
    var y = XYarray[1]
    var HWND = XYarray[2]
    if(bchwnd > 0 && loginstate && !combatstate && LoginPreCheck)
        if(!isint(x) || !isint(y))
            return false
        end
        if(x < 0 || y < 0)
            return false
        end
        //traceprint(strformat("%d(%X),%d(%X)", x, x, y, y))
        var tmp = array()
        wmint(HWND, #00D58E0C, 0, x)
        wmint(HWND, #00D58E1C, 0, y)
        tmp[0] = "7470qOUqswbreIvAC7spsQ=="
        call(HWND, tmp, 2, 27)
        arrayclear(tmp)
        arrayclear(XYarray)
        XYarray = null
        wmint(HWND, #00D58E0C, 0, 0)
        wmint(HWND, #00D58E1C, 0, 0)
    end
end
//BUG走路
function SetAutoWalkEx(HWND)
    if(bchwnd > 0 && loginstate && !combatstate && LoginPreCheck && checkgetstate("check29"))
        var tmp = array()
        tmp[0] = "5109qOUqswbreIvAC71YwA=="
        call(HWND, tmp, 2, 28)
        arrayclear(tmp)
        SetFaceDirection(HWND, rnd(0, 7), 1)
    end
end
//脫裝
function SetUnWearItem(HWND, target)
    if(bchwnd > 0 && loginstate && !combatstate && LoginPreCheck)
        if(!isint(target))
            return false
        end
        var Emptyspot = GetEmptySpot()
        var tmp = array()
        //脫裝CALL 0頭1衣服2右手3左手4鞋子5飾品[1]6飾品[2]7水晶
        tmp[0] = strformat("push 0%X", (Emptyspot + 8))//存放位置(位置+8)
        tmp[1] = strformat("push 0%X", target)//脫裝位置
        tmp[2] = "push 04"
        tmp[3] = "push 0E"
        tmp[4] = "call 00480D10"
        tmp[5] = "add esp,10"
        call(HWND, tmp, 2, 29)
        arrayclear(tmp)
        target = null
    end
end
//治療急救
function SetUseNormalSkill(HWND, target)
    if(bchwnd > 0 && LoginPreCheck && loginstate && !combatstate)
        if(!isint(target))
            return false
        end
        if(target > 5 || target < 0)
            return false
        end
        var tmp = array()
        tmp[0] = "mov eax,00C461C8"
        tmp[1] = "mov [00C31EB0],eax"
        tmp[2] = strformat("mov eax,0%X", target)
        tmp[3] = "mov edx,[00C31EB0]"
        tmp[4] = "lea ecx,[eax*8+00000000]"
        tmp[5] = "sub ecx,eax"
        tmp[6] = "mov ecx,[edx+ecx*4]"
        tmp[7] = "push ecx"
        tmp[8] = "push eax"
        tmp[9] = "mov eax,0047F950"
        tmp[10] = "call eax"
        tmp[11] = "add esp,08"
        call(HWND, tmp, 2, 30)
        arrayclear(tmp)
        target = null
    end
end
//普通轉向或轉向+NPC對話
function SetFaceDirection(HWND, dir, type = 0)
    //traceprint(strformat("%X %s", dir, type))
    if(bchwnd > 0 && LoginPreCheck && loginstate && !combatstate)
        if(!isint(dir))
            return false
        end
        if(dir > 8 || dir < 0)
            return false
        end
        wmint(HWND, #00E91350, 0, dir)
        wmint(HWND, #00E91370, 2, type)
        var tmp = array()
        tmp[0] = "3c9fqOUqswbreIvAC7petQ=="
        call(HWND, tmp, 2, 31)
        arrayclear(tmp)
        dir = null
        type = null
        wmint(HWND, #00E91350, 0, 0)
        wmint(HWND, #00E91370, 2, 0)
    end
end
//一般信
function SetNormalMail(HWND, target, content)
    if(bchwnd > 0 && LoginPreCheck && loginstate)
        //traceprint(strformat("%s %s", target, content))
        if(!isint(target) || content == "")
            return false
        end
        wmstring(HWND, #00CD8868, content)
        bc.Delay(100)
        var tmp = array()
        tmp[0] = "mov ebx,01"
        tmp[1] = "push 00400"
        tmp[2] = "push 00CD8868"
        tmp[3] = "push 00CD8868"
        tmp[4] = "call 00522B80"
        tmp[5] = "add esp,0C"
        tmp[6] = "mov ecx,[00D0CEA0]"
        tmp[7] = "push 00"
        tmp[8] = "push 00CD8868"
        tmp[9] = strformat("push 0%X", target)
        tmp[10] = "push ecx"
        tmp[11] = "call 00506E50"
        tmp[12] = "add esp,10"
        tmp[13] = "mov eax,00"
        tmp[14] = "mov [00CD8868],eax"
        call(HWND, tmp, 2, 32)
        arrayclear(tmp)
        target = null
        content = null
    end
end
//寵郵
function SetPackageMail(HWND, target, spot, pet, content = "")
    if(bchwnd > 0 && LoginPreCheck && loginstate)
        if(!isint(target) || !isint(spot) || !isint(pet) || content == "")
            return false
        end
        //traceprint(strformat("%X %s %X %X", target, content, spot + 8, pet))
        wmstring(HWND, #00CD8868, content)
        bc.Delay(10)
        PushAnnounce(HWND, strformat("<系統消息>郵寄物品: %s", itemName[spot]))
        var tmp = array()
        tmp[0] = "push 00000258"
        tmp[1] = "push 00CD8868"
        tmp[2] = "push 00CD8868"
        tmp[3] = "call 00522B80"
        tmp[4] = "add esp,0C"
        tmp[5] = "push 00"
        tmp[6] = "push 00CD8868"
        tmp[7] = strformat("push 0%X", (spot + 8))
        tmp[8] = strformat("push 0%X", pet)
        tmp[9] = strformat("push 0%X", target)
        tmp[10] = "mov ecx,[00D0CEA0]"
        tmp[11] = "push ecx"
        tmp[12] = "call 00506F30"
        tmp[13] = "add esp,14"
        if(content != "")
            tmp[14] = "mov eax,00"
            tmp[15] = "mov [00CD8868],eax"
        end
        call(HWND, tmp, 2, 33)
        arrayclear(tmp)
        target = null
        content = null
        spot = null
    end
end
//登入
function LogIn(HWND, acct, pw, type = 0)
    if(bchwnd > 0 && !LoginPreCheck && !loginstate)
        if(acct == "" || pw == "")
            return false
        end
        if(type == 0)
            wmstring(HWND, #009274A0, pw)
            wmstring(HWND, #009271B8, acct)
            bc.Delay(100)
        end
        var tmp = array()
        tmp[0] = "mov edx,dword ptr ds:[00FCDF7C]"
        tmp[1] = "push edx"
        tmp[2] = "push 009274A0"
        tmp[3] = "call 00528DA0"
        tmp[4] = "mov eax,dword ptr ds:[00FCDF7C]"
        tmp[5] = "push eax"
        tmp[6] = "push 009271B8"
        tmp[7] = "add esp,10"
        tmp[8] = "mov eax,04"
        tmp[9] = "mov dword ptr ds:[00F62954],eax"
        call(HWND, tmp, 2, 34)
        arrayclear(tmp)
        acct = null
        pw = null
        type = null
    end
end
//打開ESC介面
function GetESCScreen(HWND)
    if(bchwnd > 0 && LoginPreCheck)
        var tmp = array()
        tmp[0] = "mov eax,[00C1CCDC]"
        tmp[1] = "push 0"
        tmp[2] = "push 0"
        tmp[3] = "push 1"
        tmp[4] = "push 18"
        tmp[5] = "call 0046E830"
        tmp[6] = "add esp,10"
        call(HWND, tmp, 2, 35)
        arrayclear(tmp)
        return #00C1CCDC
    end
end
//銷毀一般面板
function DestoryNormalScreen(HWND, addr)
    if(bchwnd > 0 && LoginPreCheck)
        //traceprint(addr)
        var tmp = array()
        tmp[0] = strformat("mov eax,dword ptr ds:[%X]", addr)//存句柄地址 
        tmp[1] = "mov edi,[eax]"
        tmp[2] = "or edi,00008000"
        tmp[3] = "mov [eax],edi"
        call(HWND, tmp, 2, 36)
        arrayclear(tmp)
        addr = null
    end
end
//安開啟安全密碼面板或其他面板
function GetSecurtyCodeScreen(HWND)
    if(bchwnd > 0 && LoginPreCheck)
        var tmp = array()
        tmp[0] = "mov eax,00"
        tmp[1] = "mov ecx,01"
        tmp[2] = "mov esi,0F0"
        tmp[3] = "mov ebx,01C0"
        tmp[4] = "mov edi,060"
        tmp[5] = "push 00"
        tmp[6] = "push eax"
        tmp[7] = "push ecx"
        tmp[8] = "push 25"
        tmp[9] = "push esi"
        tmp[10] = "push ebx"
        tmp[11] = "push 06C"
        tmp[12] = "push edi"
        tmp[13] = "call 0046E6E0"
        tmp[14] = "add esp,20"
        call(HWND, tmp, 2, 37)
        arrayclear(tmp)
    end
end
//解除安全密碼
function SetSecurtyCodeFree(HWND, code, type = 0)
    if(bchwnd > 0 && LoginPreCheck)
        if(code == "")
            return false
        end
        if(type == 1)
            var addr = GetESCScreen(HWND)
            bc.Delay(300)
            DestoryNormalScreen(HWND, addr)
        end
        wmstring(HWND, #00EFC800, code)
        bc.Delay(10)
        var tmp = array()
        tmp[0] = "push 000000FF"
        tmp[1] = "lea eax,[esp+0C]"
        tmp[2] = "push eax"
        tmp[3] = "push 00EFC800"
        tmp[4] = "call 00522B80"
        tmp[5] = "add esp,0C"
        tmp[6] = "mov edx,[00C32AB0]"
        tmp[7] = "mov eax,[00C32AAC]"
        tmp[8] = "lea ecx,[esp+08]"
        tmp[9] = "push ecx"
        tmp[10] = "push 01"
        tmp[11] = "push edx"
        tmp[12] = "push eax"
        tmp[13] = "mov ecx,00970400"
        tmp[14] = "call 00401EA0"
        tmp[15] = "push eax"
        tmp[16] = "mov ecx,009703E8"
        tmp[17] = "call 00401EA0"
        tmp[18] = "mov ecx,[00D0CEA0]"
        tmp[19] = "push eax"
        tmp[20] = "push ecx"
        tmp[21] = "call 005084A0"
        tmp[22] = "add esp,1C"
        tmp[23] = "mov eax,00"
        tmp[24] = "mov [00EFC800],eax"
        call(HWND, tmp, 2, 38)
        arrayclear(tmp)
        code = null
        type = null
    end
end
//開啟生產製造類面板
function GetMakingScreen(HWND, sec, type)
    if(bchwnd > 0 && LoginPreCheck && !combatstate)
        var tmp = array()
        tmp[0] = "push 0"
        tmp[1] = strformat("push 0%X", sec)
        tmp[2] = strformat("push 0%X", type)
        tmp[3] = "call 00476310"
        tmp[4] = "add esp,0C"
        call(HWND, tmp, 2, 39)
        arrayclear(tmp)
    end
end
//開啟裝飾製造面板
function GetMakingScreenEx(HWND)
    if(bchwnd > 0 && LoginPreCheck && !combatstate)
        var tmp = array()
        tmp[0] = "push 0"
        tmp[1] = "push 0"
        tmp[2] = "call 00476610"
        tmp[3] = "add esp,0C"
        call(HWND, tmp, 2, 40)
        arrayclear(tmp)
    end
end
//開始採集
function GetCollectionScreen(HWND, sec)
    if(bchwnd > 0 && LoginPreCheck && !combatstate)
        var tmp = array()
        tmp[0] = strformat("mov edx,0%X", sec)
        tmp[1] = "mov ebx,0"
        tmp[2] = "push ebx"
        tmp[3] = "push edx"
        tmp[4] = "call 0047DC20"
        tmp[5] = "add esp,08"
        call(HWND, tmp, 2, 41)
        arrayclear(tmp)
    end
end