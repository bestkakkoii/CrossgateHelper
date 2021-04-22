//自動戰鬥
/////////////////////
//人物動作
function SetAI(HWND, target, skillc, skilllvc, skill)
    if(skillc != 0 && skillc != 1 && skillc != 2)
        SetSkillAttack(HWND, skillc - 3, skilllvc, target)
    elseif(skill == "攻擊")
        SetBasicAttack(HWND, target)
    elseif(skill == "防禦")
        SetDefend(HWND)
    elseif(skill == "逃跑")
        SetRunaway(HWND)
    end
end
function AutoCombatSystem(HWND)
    if(HWND > 0 && !closedpage)
        var type = 1
        var status = GetCombatStatus(HWND)
        var petpos = GetPetPos(HWND)
        var myname = GetMyName(HWND)
        if(status == 1 || status == 2)
            if(checkgetstate("check37") && CombatDelay)
                var tmp = editgettext("edit2") * 1000
                bc.Delay(tmp)
            end
            GBecount = GetEnemyCount(HWND)
            if(checkgetstate("check51") && GBecount > 0)
                if(int(CombatDuration) > GBecount + 1)
                    CombatDelay = false
                end
            end
            if(round == 0 && checkgetstate("check38") && CombatDelay && GBecount > 0)
                PushAnnounce(HWND, AESdecrypt("0b1d03bbea95574bff2d460359fe1d80f33a6e57210a43a30e27c309c4adbe83"))
                var tmp = 1000 * GBecount
                bc.Delay(tmp)
            end
            //自動逃跑
            if(checkgetstate("check27"))
                SetRunaway(HWND)
                return true
            end
            //指定回合動作
            if(combogetcursel("combobox4") != 0)
                var roundsel = combogetcursel("combobox4")
                if(roundsel != 0 && roundsel == (round + 1))
                    type = 0
                    var skillc = combogetcursel("co0")
                    var skill = combogettext("co0")
                    var skilllvc = combogetcursel("col0")
                    if(checkgetstate("check36"))
                        SetAI(HWND, GetRandom(), skillc, skilllvc, skill)
                        return true
                    else
                        SetAI(HWND, GetTargetSel(type), skillc, skilllvc, skill)
                        return true
                    end
                end
            end
            //指定敵人數量動作
            if(combogetcursel("combobox5") != 0)
                var enemyamount = GetEnemyCount(HWND)
                if(enemyamount <= combogetcursel("combobox5"))
                    type = 3
                    var skillc = combogetcursel("co3")
                    var skill = combogettext("co3")
                    var skilllvc = combogetcursel("col3")
                    if(checkgetstate("check36"))
                        SetAI(HWND, GetRandom(), skillc, skilllvc, skill)
                        return true
                    else
                        SetAI(HWND, GetTargetSel(type), skillc, skilllvc, skill)
                        return true
                    end
                end
            end
            //指定氣餘量動作
            var mplimit = editgettext("edit0")
            if(mplimit > 0 && mainMP < mplimit)
                type = 4
                var skillc = combogetcursel("co4")
                var skill = combogettext("co4")
                var skilllvc = combogetcursel("col4")
                if(checkgetstate("check36"))
                    SetAI(HWND, GetRandom(), skillc, skilllvc, skill)
                    return true
                else
                    SetAI(HWND, GetTargetSel(type), skillc, skilllvc, skill)
                    return true
                end
            end
            //精靈復活動作
            if(checkgetstate("check42"))
                type = 6
                for(var i = 0; i < 10; i++)
                    if(aliveexist[i] > 0 && alivehp[i] <= 0)
                        //traceprint(strformat("編號: %d, 存在:%d, 血: %d,寵名:%s, 寵名2: %s, 對象:%s", i, aliveexist[i], alivehp[i], petnickname[petpos], alivename[i], Target_array[type][1]))
                        var skillc = combogetcursel("co6")
                        if(Target_array[type][1] && petnickname[petpos] == alivename[i])
                            if(skillc != 0 && skillc != 1 && skillc != 2)
                                skillc = skillc - 3
                            end
                            SetSkillAttack(HWND, skillc, combogetcursel("col6"), i)
                            return true
                        elseif(Target_array[type][2])
                            if(skillc != 0 && skillc != 1 && skillc != 2)
                                skillc = skillc - 3
                            end
                            SetSkillAttack(HWND, skillc, combogetcursel("col6"), i)
                            return true
                        end
                    end
                end
            end
            //戰鬥道具補血動作
            if(checkgetstate("check41"))
                type = 7
                var itemlocate = GetPreitemSpot(1)
                for(var i = 0; i < 10; i++)
                    if(aliveexist[i] > 0 && alivehp[i] > 0)
                        if(Target_array[type][0] && GetPercentage(mainHP, mainMAXHP) < editgettext("edit3") && alivename[i] == myname)
                            SetItemAttack(HWND, itemlocate, i)
                            return true
                        elseif(Target_array[type][1] && GetPercentage(pethp[petpos], petmaxhp[petpos]) < editgettext("edit4") && alivename[i] == petnickname[petpos])
                            SetItemAttack(HWND, itemlocate, i)
                            return true
                        elseif(Target_array[type][2] && GetPercentage(alivehp[i], alivemaxhp[i]) < editgettext("edit5"))
                            SetItemAttack(HWND, itemlocate, i)
                            return true
                        end
                    end
                end
            end
            //精靈補血動作
            if(checkgetstate("check40"))
                type = 5
                var skillc = combogetcursel("co5")
                var skill = combogettext("co5")
                var skilllvc = combogetcursel("col5")
                for(var i = 0; i < 10; i++)
                    if(aliveexist[i] > 0 && alivehp[i] > 0)
                        var Percent = GetPercentage(alivehp[i], alivemaxhp[i])
                        //traceprint(strformat("編號: %d, 存在:%d, 血: %d, 百分比: %d", i, aliveexist[i], alivehp[i], Percent))
                        if(Target_array[type][0] && GetPercentage(mainHP, mainMAXHP) < editgettext("edit3") && alivename[i] == myname)
                            SetAI(HWND, i, skillc, skilllvc, skill)
                            return true
                        elseif(Target_array[type][1] && GetPercentage(pethp[petpos], petmaxhp[petpos]) < editgettext("edit4") && alivename[i] == petnickname[petpos])
                            SetAI(HWND, i, skillc, skilllvc, skill)
                            return true
                        elseif(Target_array[type][2] && Percent < editgettext("edit5"))
                            SetAI(HWND, i, skillc, skilllvc, skill)
                            return true
                        elseif(Target_array[type][3])
                            if(Percent < editgettext("edit3") || Percent < editgettext("edit4") || Percent < editgettext("edit5"))
                                SetAI(HWND, GetTargetSel(type), skillc, skilllvc, skill)
                                return true
                            end
                        end
                    end
                end
            end
            //一般動作
            type = 1
            if(!checkgetstate("check34"))
                var skillc = combogetcursel("co1")
                var skill = combogettext("co1")
                var skilllvc = combogetcursel("col1")
                if(checkgetstate("check35"))
                    skilllvc = GetFixSkillLV(HWND, skill, skilllvc)
                end
                if(checkgetstate("check36"))
                    SetAI(HWND, GetRandom(), skillc, skilllvc, skill)
                    return true
                else
                    SetAI(HWND, GetTargetSel(type), skillc, skilllvc, skill)
                    return true
                end
            else
                var skill = combogettext("co1")
                if(skill == "攻擊")
                    if(checkgetstate("check36"))
                        SetBasicAttack(HWND, GetRandom())
                        return true
                    else
                        SetBasicAttack(HWND, GetTargetSel(type))
                        return true
                    end
                elseif(skill == "防禦")
                    SetDefend(HWND)
                    return true
                elseif(skill == "逃跑")
                    SetRunaway(HWND)
                    return true
                else
                    var item = combogettext("co1")
                    if(checkgetstate("check36"))
                        SetItemAttack(HWND, GetPreitemSpot(2), GetRandom())
                        return true
                    else
                        SetItemAttack(HWND, GetPreitemSpot(2), GetTargetSel(type))
                        return true
                    end
                end
            end
        end
        if(petpos == -1 || petpos == 0)
            if(status == 3)
                //二次動作
                type = 2
                var skillc = combogetcursel("co2")
                var skill = combogettext("co2")
                var skilllvc = combogetcursel("col2")
                if(checkgetstate("check36"))
                    SetAI(HWND, GetRandom(), skillc, skilllvc, skill)
                    return true
                else
                    SetAI(HWND, GetTargetSel(type), skillc, skilllvc, skill)
                    return true
                end
            end
        end
    end
    return false
end
//寵物動作
function AutoCombatSystem2(HWND)
    if(bchwnd > 0 && !closedpage)
        var type = 9
        var status = GetCombatStatus(HWND)
        var petpos = GetPetPos(HWND)
        if(status == 4 || status == 5)
            if(checkgetstate("check37") && CombatDelay)
                var tmp = editgettext("edit2") * 1000
                bc.Delay(tmp)
            end
            //寵物指定回合動作
            if(combogetcursel("combobox6") != 0)
                var roundsel = combogetcursel("combobox6")
                if(roundsel != 0 && roundsel == (round + 1))
                    type = 8
                    var skillc = combogetcursel("pco0")
                    var skill = combogettext("pco0")
                    if(checkgetstate("check36"))
                        SetPetAttack(HWND, GetRandom(), skillc)
                        return true
                    else
                        SetPetAttack(HWND, GetTargetSel(HWND, type), skillc)
                        return true
                    end
                end
            end
            //寵物指定氣餘量動作
            var petmplimit = editgettext("edit1")
            if(petmplimit > 0 && petmp[petpos] < petmplimit)
                type = 10
                var skillc = combogetcursel("pco2")
                var skill = combogettext("pco2")
                if(checkgetstate("check36"))
                    SetPetAttack(HWND, GetRandom(), skillc)
                    return true
                else
                    SetPetAttack(HWND, GetTargetSel(type), skillc)
                    return true
                end
            end
            //寵物一般動作
            type = 9
            var skillc = combogetcursel("pco1")
            var skill = combogettext("pco1")
            if(checkgetstate("check36"))
                SetPetAttack(HWND, GetRandom(), skillc)
                return true
            else
                SetPetAttack(HWND, GetTargetSel(type), skillc)
                return true
            end
        end
    end
    return false
end
function GetFixSkillLV(HWND, skill, skilllvc)
    //指定敵數量對應技能等級
    var enemyamount = GetEnemyCount(HWND)
    var max = combogetcount("col1")
    select(enemyamount)
        case 1
        skilllvc = 1
        case 2
        skilllvc = 3
        case 3
        skilllvc = 5
        case 4
        skilllvc = 8
        case 5
        skilllvc = 9
        default
        skilllvc = int(max)
    end
    if(skill == "亂射")
        skilllvc = int(enemyamount)
    end
    if(enemyamount > max)
        skilllvc = int(max)
    elseif(enemyamount == 10)
        skilllvc = int(max)
    end
    if(skilllvc < 0)
        skilllvc = 0
    else
        skilllvc--
    end
    if(skilllvc >= 0)
        return skilllvc
    else
        return 0
    end
end
//隨機目標
function GetRandom(loword = 10, hiword = 20)
    var temp = array()
    for(var i = loword; i < hiword + 1; i++)
        if(alivehp[i] > 0)
            arraypush(temp, i)
        end
    end
    var r = rnd(0, arraysize(temp) - 1)
    return temp[r]
end
//取得指定條件目標編號
function GetTargetSel(HWND, type = 1)
    var petpos = GetPetPos(HWND)
    var myname = GetMyName(HWND)
    if(Target_array[type][4])//敵人
        for(var i = 15; i < 20; i++)
            if(aliveexist[i] > 0)
                return i
            end
        end
    end
    if(Target_array[type][5])//敵方全體
        return 41
    end
    if(Target_array[type][6])//敵方前排
        for(var i = 15; i < 20; i++)
            if(aliveexist[i] > 0)
                return i + 20//4格範圍技能
            end
        end
    end
    if(Target_array[type][7])//敵方後排
        for(var i = 10; i < 15; i++)
            if(aliveexist[i] > 0)
                return i + 20//4格範圍技能
            end
        end
    end
    if(Target_array[type][0])//自己
        var Self = arrayfindvalue(alivename, myname)
        return Self
    end
    if(Target_array[type][1])//戰寵
        var Pet = arrayfindvalue(alivename, petnickname[petpos])
        return Pet
    end
    if(Target_array[type][2])//我方任意
        for(var i = 0; i < 10; i++)
            if(aliveexist[i] > 0)
                return i
            end
        end
    end
    if(Target_array[type][3])//我方全體
        return 40
    end
    //我方指定單一對象
    for(var i = 0; i < 10; i++)
        if(Target_array2[type][i] && aliveexist[i] > 0)
            return i
        end
    end
    return 15
end
//技能分類數組
//function GetSkillArray()
//    var 全體技能數組 = array("超強中毒魔法", "巫毒的奧秘", "超強昏睡魔法", "催眠小夜曲", "超強石化魔法", "梅杜莎之怨", "超強酒醉魔法", "酒精含量200%", "超強混亂魔法", "亂到最高點", "超強遺忘魔法", "記憶喪失", "超強補血魔法", "神之愛", "超強恢復魔法", "超強再生術", "超強隕石魔法", "禍害的降臨", "超強冰凍魔法", "無情的冰雨", "超強火焰魔法", "毀滅的核爆", "超強風刃魔法", "凜冽的狂風", "吸血魔法", "血之盟約")
//    var 一排範圍技能數組 = array("精神衝擊波", "高感應電流")
//    var 部分範圍技能數組 = array("強力補血魔法", "神之慈悲", "強力恢復魔法", "強力再生術", "強力隕石魔法", "不詳的預兆", "強力冰凍魔法", "冷酷的冰雹", "強力火焰魔法", "炙熱的地獄", "強力風刃魔法", "刺骨的寒風", "強力昏睡魔法", "安眠之歌", "強力石化魔法", "梅杜莎的詛咒", "強力酒醉魔法", "酒精含量150%", "強力混亂魔法", "黑白不分", "強力遺忘魔法", "忘情雨")
//    var 無對象技能數組 = array("明鏡止水", "臥薪嘗膽", "騎乘", "頂級騎乘", "陽炎", "神眼", "聖盾", "聖盾之魂", "攻擊魔法防禦", "大地的祈禱", "大地之愛", "海洋的祈禱", "海洋之心", "火焰的祈禱", "火之舞", "雲群的祈禱", "天空的祝福", "騎士之譽", "迅速果斷", "烈．迅速果斷")
//    var 被動技能數組 = array("抗毒", "百毒不侵", "抗昏睡", "懸樑刺股", "抗石化", "鏡盾反射", "抗酒醉", "眾人皆醉我獨醒", "抗混亂", "亂中有序", "抗遺忘", "永生難忘", "虛死為上", "虛死為上完", "調教", "日夜鞭策", "寵物強化", "斯巴達教育", "精靈的盟約", "百丟百中")
//    var 非戰鬥技能數組 = array("治療", "急救", "鑑定", "刻印", "武器修理", "防具修理", "變身", "變裝", "裝飾", "挖掘體驗", "伐木體驗", "狩獵體驗", "剪取體驗", "裝飾", "鍛造體驗", "挖掘", "伐木", "狩獵", "剪取", "料理", "製藥", "鑄劍", "造槍", "造斧", "造杖", "造弓", "造小刀", "造投擲武器", "制頭盔", "制帽子", "制鎧甲", "製衣服", "制長袍", "制靴子", "制鞋子", "制盾", "炸彈轉化", "飾品鑄造", "療傷藥", "外傷藥", "仙術煉成")
//end