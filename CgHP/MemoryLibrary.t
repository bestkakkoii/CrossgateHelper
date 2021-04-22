//內存讀寫
var CRK = array()
function rmint(HWND, addr, type)
    return CRK[0].ReadIntAddr(HWND, addr, type)
end
function wmint(HWND, addr, type, value)
    return CRK[0].WriteIntAddr(HWND, addr, type, value)
end
function rmstring(HWND, addr, len)
    return CRK[0].ReadStringAddr(HWND, addr, 0, len)
end
function wmstring(HWND, addr, value)
    return CRK[0].WriteStringAddr(HWND, addr, 0, value)
end
function wmdata(HWND, addr, value)
    return CRK[0].WriteDataAddr(HWND, addr, value)
end
function rmfloat(HWND, addr)
    return CRK[0].ReadFloatAddr(HWND, addr)
end
function wmfloat(HWND, addr, value)
    return CRK[0].WriteFloatAddr(HWND, addr, value)
end
function rmdouble(HWND, addr)
    return CRK[0].ReadDoubleAddr(HWND, addr)
end
//內存遍歷
function traverse(HWND, targetHex, amount, pointer, type, long)
    var subject = array()
    var subjectHex = array()
    //
    for(var i = 0; i < amount; i++)
        if(i == 0)
            subjectHex[i] = targetHex
        else
            subjectHex[i] = subjectHex[i - 1] + pointer
        end
        select(type)
            case 0
            subject[i] = rmint(HWND, subjectHex[i], 0)
            case 1
            subject[i] = rmint(HWND, subjectHex[i], 1)
            case 2
            subject[i] = rmint(HWND, subjectHex[i], 2)
            case 3
            subject[i] = rmstring(HWND, subjectHex[i], long)
            case 4
            subject[i] = rmfloat(HWND, subjectHex[i])
            case 5
            subject[i] = rmdouble(HWND, subjectHex[i])
        end
    end
    freememory()
    return subject
end
//批量初始化
function traverseclear(HWND, targetHex, amount, pointer)
    var subjectHex = array()
    //
    for(var i = 0; i < amount; i++)
        if(i == 0)
            subjectHex[i] = targetHex
        else
            subjectHex[i] = subjectHex[i - 1] + pointer
        end
        wmint(HWND, subjectHex[i], 0, 0)
    end
    arrayclear(subjectHex)
end
//基址緩存
var itemExistHex = array()
var itemNameHex = array()
var itemAmountHex = array()
var petnameHex = array()
var petnicknameHex = array()
var petlevelHex = array()
var skillLVHex = array(array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array())
var petskillHex = array()
var skillExpHex = array()
var skillMaxExpHex = array()
var pethpHex = array()
var petmaxhpHex = array()
var petmpHex = array()
var petmaxmpHex = array()
//基址設置
function GetHexAddr()
    itemExistHex[0] = #00CC7280
    itemAmountHex[0] = #00CC7288
    itemNameHex[0] = #00CC7290
    //
    for(var i = 1; i < 20; i++)
        itemExistHex[i] = itemExistHex[i - 1] + #0C4C
        itemNameHex[i] = itemNameHex[i - 1] + #0C4C
        itemAmountHex[i] = itemAmountHex[i - 1] + #0C4C
    end
    for(var i = 0; i < 14; i++)
        skillLVHex[i][0] = #00E8D728
        if(i != 0)
            var dskil = skillLVHex[i][0]
            var dhex = #04C4C
            for(var k = 0; k < i; k++)
                dskil = dskil + dhex
            end
            skillLVHex[i][0] = dskil
        end
        //
        for(var j = 1; j < 11; j++)
            skillLVHex[i][j] = skillLVHex[i][j - 1] + #094
        end
    end
    petskillHex[0] = #00ED50C6
    var petpos = GetPetPos(bchwnd)
    if(petpos != 0)
        var dskil = petskillHex[0]
        var dhex = #05110
        for(var i = 0; i < petpos; i++)
            dskil = dskil + dhex
        end
        petskillHex[0] = dskil
    end
    //
    for(var i = 1; i < 11; i++)
        petskillHex[i] = petskillHex[i - 1] + #08C
    end
    skillExpHex[0] = #00E8D710
    skillMaxExpHex[0] = #00E8D714
    //
    for(var i = 1; i < 14; i++)
        skillExpHex[i] = skillExpHex[i - 1] + #04C4C
        skillMaxExpHex[i] = skillMaxExpHex[i - 1] + #04C4C
    end
    //
    petnameHex[0] = #00ED5694
    petnicknameHex[0] = #00ED56A5
    petlevelHex[0] = #00ED4FF0
    //
    for(var i = 1; i < 5; i++)
        petnameHex[i] = petnameHex[i - 1] + #5110
        petnicknameHex[i] = petnicknameHex[i - 1] + #5110
        petlevelHex[i] = petlevelHex[i - 1] + #5110
    end
    pethpHex[0] = #00C76018
    petmaxhpHex[0] = #00C7601C
    petmpHex[0] = #00C76020
    petmaxmpHex[0] = #00C76024
    for(var i = 1; i < 4; i++)
        pethpHex[i] = pethpHex[i - 1] + #010
        petmaxhpHex[i] = petmaxhpHex[i - 1] + #010
        petmpHex[i] = petmpHex[i - 1] + #010
        petmaxmpHex[i] = petmaxmpHex[i - 1] + #010
    end
end
//初始化記憶體變量
function RestoreMemoryVar()
    g_TalkDetect = ""
    scriptsp = 150
    routesp = 350
    LoginPreCheck = false
    //非戰鬥一次性變量
    combatUnit = true
    CombatDelay = true
    //非登入一次性變量
    OneTime = true
    OneTime2 = true
    //使用者資訊變量
    WebInformation = array("", "", "", "", "", "", "", "", "", "", "")
    statueL = array(30977, 769, 1, 0, "", "")
    subserverpagecheck = 0
    loginstate = 0
    combatstate = false
    round = 0
    closedpage = 0
    receiveitem = array("", "", "")
    east = 0
    south = 0
    east2 = 0
    south2 = 0
    direction = 0
    combatstatus = array(0, 0, 0)
    aliveinfo = ""
    aliveexist = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    GroupMemberExist = array()
    //一般名片變量
    maillist = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
    maillcontent = array()
    //道具變量
    itemName = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
    itemAmount = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    itemExist = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    //技能變量
    skillname = array("", "", "", "", "", "", "", "", "", "", "", "", "", "")
    skillLVname = array(array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array())
    skillexp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    skillmaxexp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    expdifferance = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    //寵物技能變量
    petskillname = array("", "", "", "", "", "", "", "", "", "", "")
    //使用者資訊變量
    WebInformation = array("", "", "", "", "", "", "", "", "", "", "")
    //戰場存活資訊
    alivename = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
    alivelv = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    alivehp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    alivemaxhp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    alivemp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    alivemaxmp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    //寵物名稱變量
    petname = array("", "", "", "", "")
    petnickname = array("", "", "", "", "")
    petlevel = array(0, 0, 0, 0, 0)
    pethp = array(0, 0, 0, 0, 0)
    petmaxhp = array(0, 0, 0, 0, 0)
    petmp = array(0, 0, 0, 0, 0)
    petmaxmp = array(0, 0, 0, 0, 0)
    //周圍人
    HumanName = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
    //防閃爍變量
    STATUSWORDSAVED = ""
    mxsave = 0
    mysave = 0
    eastsave = 0
    southsave = 0
    directionsave = 0
    mapsave = 0
    mapIDsave = 0
    mainHPsave = 0
    mainMAXHPsave = 0
    mainMPsave = 0
    mainMAXMPsave = 0
    petpossave = -1
    levelsave = 0
    petlevelsave = array(0, 0, 0, 0, 0)
    pethpsave = array(0, 0, 0, 0, 0)
    petmaxhpsave = array(0, 0, 0, 0, 0)
    petmpsave = array(0, 0, 0, 0, 0)
    petmaxmpsave = array(0, 0, 0, 0, 0)
    skillnamesave = array("", "", "", "", "", "", "", "", "", "", "", "", "", "")
    petskillnamesave = array("", "", "", "", "", "", "", "", "", "", "", "", "", "")
    itemNamesave = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
    itemNamesave2 = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
    itemAmountsave = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    WearNamesave = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
    skillexpsave = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    coselectsave = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    Unitsave = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
    infoshowsave = array("戰鬥人物動作", "戰鬥寵物動作")
    savetxsize = 0
    stonevaluesave = 0
    //戰鬥計時
    CombatDuration = 0
    combattimeinfosave = ""
    TotalRound = 0
    TotalDuration = 0
    //異常
    Abnormal = false
    NormalUseItemFlag = false
end
var statueL = array(30977, 769, 1, 0, "", "")
var subserverpagecheck = 0
var loginstate = 0
var closedpage = 0
var round = 0
var combatstate = false
var mainexp = 0
var petexp = 0
var receiveitem = array("", "", "")
var east = 0
var south = 0
var east2 = 0
var south2 = 0
var direction = 0
var combatstatus = array(0, 0, 0)
var aliveinfo = ""
var aliveexist = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var GroupMemberExist = array()
//一般名片變量
var maillist = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
var maillcontent = array()
//道具變量
var itemName = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
var itemAmount = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var itemExist = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var WearName = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
var WearExist = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
//技能變量
var skillname = array("", "", "", "", "", "", "", "", "", "", "", "", "", "")
var skillLVname = array(array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array(), array())
var skillexp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var skillmaxexp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var expdifferance = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
//寵物技能變量
var petskillname = array("", "", "", "", "", "", "", "", "", "", "")
//戰場存活資訊
var alivename = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
var alivelv = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var alivehp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var alivemaxhp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var alivemp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var alivemaxmp = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
//寵物名稱變量
var petname = array("", "", "", "", "")
var petnickname = array("", "", "", "", "")
var petlevel = array(0, 0, 0, 0, 0)
var pethp = array(0, 0, 0, 0, 0)
var petmaxhp = array(0, 0, 0, 0, 0)
var petmp = array(0, 0, 0, 0, 0)
var petmaxmp = array(0, 0, 0, 0, 0)
//周圍人
var HumanName = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
function getcombatstateEx(HWND)
    var precombatstate0 = rmint(HWND, #00598858, 2)
    var precombatstate1 = rmint(HWND, #00F62954, 0)
    if(precombatstate0 == 1 && precombatstate1 == 3)
        return false
    elseif(precombatstate0 == 0)
        return true
    end
end
function GetMapID(HWND)
    //mapID
    return rmint(HWND, #0095C898, 0)
end
function GetGroupState(HWND)
    //groupstate
    return rmint(HWND, #00F62926, 2)
end
function GetWalkSpeed(HWND)
    //walkspeed
    return rmint(HWND, #00F4C460, 0)//B4C460
end
function GetAccountID(HWND)
    //accountID
    return rmstring(HWND, #009271B8, 200)
end
function GetMyName(HWND)
    //myname
    return rmstring(HWND, #00F4C3F8, 50)
end
function GetSuperSpeed(HWND)
    //superspeed
    return rmdouble(HWND, #00548F10)
end
function GetPetPos(HWND)
    //petpos
    return rmint(HWND, #00C462C8, 0)
end
function GetMoneyLeft(HWND)
    //money
    return rmint(HWND, #00F4C3EC, 0)
end
function GetMap(HWND)
    //map
    return rmstring(HWND, #0095C870, 50)
end
function GetTime(HWND)
    //Time
    return rmint(HWND, #00FC2420, 0)
end
function GetRound(HWND)
    //round
    return rmint(HWND, #005988AC, 0)
end
function GetLevel(HWND)
    //level
    return rmint(HWND, #00F4C2F4, 0)
end
//讀取
function ReadMemory(HWND)
    if(loginstate)
        if(!combatstate)
            //非戰鬥
            GetPetskill(HWND)
        end
        //戰鬥//非戰鬥
        iteminfo1 = traverse(HWND, #00C55FD0, 20, #0C44, 3, 100)
        WearExist = traverse(HWND, #00F4C494, 8, #0C5C, 2, 100)
        WearName = traverse(HWND, #00F4C496, 8, #0C5C, 3, 50)
        GetItemInfo(HWND)
        skillname = traverse(HWND, #00E8D6EC, 15, #04C4C, 3, 50)
        GetSkillLV(HWND)
        GetSkilExpInfo(HWND)
        GetPetInfo(HWND)
        GroupMemberExist = traverse(HWND, #00FFD030, 4, #030, 0, 100)
    end
    freememory()
end
//戰場資訊
function GetCombatData(HWND)
    aliveinfo = CRK[0].ReadString(HWND, AESdecrypt("24cde254153ec89bc2c2734494c04c19b6812813f0c1fafe3fbf4748180f18bb"), 0, 15000)
    aliveexist = traverse(HWND, #0058C6C7, 20, #04, 2, 100)
    var alivearray = null
    strsplit(aliveinfo, "|", alivearray)
    var k = 0
    var j = 0
    for(var i = 0; i < 20; i++)
        if(aliveexist[i] > 0 && aliveexist[i] < 255)
            j = k * 12
            k++
            alivename[i] = alivearray[j]
            alivelv[i] = cint(alivearray[j + 3], 1)
            alivehp[i] = cint(alivearray[j + 4], 1)
            alivemaxhp[i] = cint(alivearray[j + 5], 1)
            alivemp[i] = cint(alivearray[j + 6], 1)
            alivemaxmp[i] = cint(alivearray[j + 7], 1)
        else
            alivename[i] = ""
            alivelv[i] = 0
            alivehp[i] = 0
            alivemaxhp[i] = 0
            alivemp[i] = 0
            alivemaxmp[i] = 0
        end
        //traceprint(strformat("%d::::%s LV:%d HP:%d/%d MP:%d/%d", i, alivename[i], alivelv[i], alivehp[i], alivemaxhp[i], alivemp[i], alivemaxmp[i]))
    end
end
//道具遍歷
function GetItemInfo(HWND)
    for(var i = 0; i < 20; i++)
        itemExist[i] = rmint(HWND, itemExistHex[i], 2)
        itemAmount[i] = rmint(HWND, itemAmountHex[i], 0)
        itemName[i] = rmstring(HWND, itemNameHex[i], 100)
    end
end
//技能等級遍歷
function GetSkillLV(HWND)
    for(var i = 0; i < 14; i++)
        skillLVname[i][0] = rmstring(HWND, skillLVHex[i][0], 50)
        for(var j = 1; j < 11; j++)
            skillLVname[i][j] = rmstring(HWND, skillLVHex[i][j], 50)
        end
    end
end
//寵物技能遍歷
function GetPetskill(HWND)
    petskillname[0] = rmstring(HWND, petskillHex[0], 50)
    for(var i = 1; i < 11; i++)
        petskillname[i] = rmstring(HWND, petskillHex[i], 50)
    end
end
//技能經驗遍歷
function GetSkilExpInfo(HWND)
    for(var i = 0; i < 14; i++)
        skillexp[i] = rmint(HWND, skillExpHex[i], 0)
        skillmaxexp[i] = rmint(HWND, skillMaxExpHex[i], 0)
        expdifferance[i] = skillmaxexp[i] - skillexp[i]
    end
end
//寵物資訊遍歷
function GetPetInfo(HWND)
    for(var i = 0; i < 5; i++)
        petname[i] = rmstring(HWND, petnameHex[i], 50)
        petnickname[i] = rmstring(HWND, petnicknameHex[i], 50)
        petlevel[i] = rmint(HWND, petlevelHex[i], 0)
        pethp[i] = rmint(HWND, pethpHex[i], 0)
        petmaxhp[i] = rmint(HWND, petmaxhpHex[i], 0)
        petmp[i] = rmint(HWND, petmpHex[i], 0)
        petmaxmp[i] = rmint(HWND, petmaxmpHex[i], 0)
    end
end