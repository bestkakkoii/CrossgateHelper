//個人設置讀取與存檔
function SaveSet(HWND)
    var name = ""
    var myname = GetMyName(HWND)
    if(myname == "")
        name = "General"
    else
        name = myname
    end
    var pathdat = "./AccountSetting/Setting-" & name & ".dat"
    var pathini = ".\\AccountSetting\\Setting2-" & name & ".ini"
    filedelete(pathini)
    filewriteini("BC", "安全密碼", AESencrypt(editgettext("edit12")), pathini)
    filewriteini("BC", "遊戲帳號", AESencrypt(editgettext("edit15")), pathini)
    filewriteini("BC", "遊戲密碼", AESencrypt(editgettext("edit16")), pathini)
    for(var i = 0; i < arraysize(dropitem); i++)
        filewriteini("BC", "自動丟棄道具列表" & i, dropitem[i], pathini)
    end
    var listcount = listgetcount("list0")
    arrayclear(maplock)
    for(var i = 0; i < listcount; i++)
        maplock[i] = listgettext("list0", i)
    end
    for(var i = 0; i < arraysize(maplock); i++)
        if(maplock[i] != "")
            filewriteini("BC", "掛機地圖列表" & i, maplock[i], pathini)
        end
    end
    for(var i = 0; i < arraysize(preHumanName); i++)
        if(preHumanName[i] != "")
            filewriteini("BC", "自動登出名單" & i, preHumanName[i], pathini)
        end
    end
    filewriteini("BC", "0x0", walkdelay, pathini)
    filewriteini("BC", "0x1", walklen, pathini)
    filewriteini("BC", "0x2", HPLIMIT, pathini)
    filewriteini("BC", "0x3", MPLIMIT, pathini)
    filewriteini("BC", "0x4", GROUPLIMIT, pathini)
    filewriteini("BC", "0x5", NORMALLIMIT, pathini)
    filewriteini("BC", "0x6", COMBATLIMIT, pathini)
    var controlsave0 = array()
    var controlsave1 = array()
    var controlsave2 = array()
    var controlsave3 = array()
    var controlsave4 = array()
    var controlsave5 = array()
    var controlsave6 = array()
    var controlsave7 = array()
    var controlsave8 = array()
    var controlsave9 = array()
    for(var i = 0; i < 68; i++)
        controlsave0[i] = checkgetstate("check" & i)
    end
    for(var i = 0; i < 23; i++)
        controlsave1[i] = editgettext("edit" & i)
    end
    for(var i = 0; i < 10; i++)
        controlsave2[i] = combogetcursel("combobox" & i)
    end
    for(var i = 0; i < 7; i++)
        controlsave3[i] = combogetcursel("co" & i)
        controlsave4[i] = combogetcursel("col" & i)
    end
    for(var i = 0; i < 3; i++)
        controlsave5[i] = combogetcursel("pco" & i)
    end
    controlsave7 = Target_array
    controlsave8 = Target_array2
    var saveset_array = array()
    saveset_array[0] = controlsave0
    saveset_array[1] = controlsave1
    saveset_array[2] = controlsave2
    saveset_array[3] = controlsave3
    saveset_array[4] = controlsave4
    saveset_array[5] = controlsave5
    saveset_array[6] = controlsave6
    saveset_array[7] = controlsave7
    saveset_array[8] = controlsave8
    saveset_array[9] = controlsave9
    filedelete(pathdat)
    filewriteex(pathdat, AESencrypt(saveset_array), 2)
    if(fileexist(pathdat) != 1)
        msgbox("存檔失敗", 4)
    end
end
var pathdatLoad = ""
function LoadSet(type = 0)
    var pathdat = ""
    if(type == 0)
        pathdat = filedialog(1, "dat|*.dat||")
        pathdatLoad = pathdat
    else
        pathdat = pathdatLoad
    end
    if(pathdat == "")
        return false
    end
    var temppath = strcut(pathdat, 4, false)
    var temparray
    strsplit(temppath, "Setting-", temparray)
    var pathini = temparray[0] & "Setting2-" & temparray[1] & ".ini"
    editsettext("edit12", AESdecrypt(filereadini("BC", "安全密碼", pathini)))
    editsettext("edit15", AESdecrypt(filereadini("BC", "遊戲帳號", pathini)))
    editsettext("edit16", AESdecrypt(filereadini("BC", "遊戲密碼", pathini)))
    dropitem = array()
    var tmpcount = 0
    for(var i = 0; i < 100; i++)
        var temp = filereadini("BC", "自動丟棄道具列表" & i, pathini)
        if(temp != "")
            arraypush(dropitem, temp)
        elseif(tmpcount > 10)
            break
        else
            tmpcount++
        end
    end
    maplock = array()
    tmpcount = 0
    for(var i = 0; i < 100; i++)
        var temp = filereadini("BC", "掛機地圖列表" & i, pathini)
        if(temp != "")
            arraypush(maplock, temp)
        elseif(tmpcount > 10)
            break
        else
            tmpcount++
        end
    end
    preHumanName = array()
    tmpcount = 0
    for(var i = 0; i < 100; i++)
        var temp = filereadini("BC", "自動登出名單" & i, pathini)
        if(temp != "")
            arraypush(preHumanName, temp)
        elseif(tmpcount > 10)
            break
        else
            tmpcount++
        end
    end
    listdeleteall("list0")
    for(var i = 0; i < arraysize(maplock); i++)
        if(maplock[i] != "")
            listaddtext("list0", maplock[i])
        end
    end
    walkdelay = filewriteini("BC", "0x0", walkdelay, pathini)
    if(walkdelay == "" || !isint(walkdelay))
        walkdelay = 500
    end
    staticsettext("static44", walkdelay)
    walklen = filereadini("BC", "0x1", pathini)
    if(walklen == "" || !isint(walklen))
        walklen = 1
    end
    staticsettext("static45", walklen)
    HPLIMIT = filereadini("BC", "0x2", pathini)
    if(HPLIMIT == "" || !isint(HPLIMIT))
        HPLIMIT = 20
    end
    checksettext("check55", strformat("血量＜ %d％", HPLIMIT))
    MPLIMIT = filereadini("BC", "0x3", pathini)
    if(MPLIMIT == "" || !isint(MPLIMIT))
        MPLIMIT = 20
    end
    checksettext("check56", strformat("魔力＜ %d％", MPLIMIT))
    GROUPLIMIT = filereadini("BC", "0x4", pathini)
    if(GROUPLIMIT == "" || !isint(GROUPLIMIT))
        GROUPLIMIT = 3
    end
    checksettext("check57", strformat("隊伍人數＜ %d", GROUPLIMIT))
    NORMALLIMIT = filereadini("BC", "0x5", pathini)
    if(NORMALLIMIT == "" || !isint(NORMALLIMIT))
        NORMALLIMIT = 20
    end
    checksettext("check58", strformat("平時超時%d分鐘", NORMALLIMIT))
    COMBATLIMIT = filereadini("BC", "0x6", pathini)
    if(COMBATLIMIT == "" || !isint(COMBATLIMIT))
        COMBATLIMIT = 20
    end
    checksettext("check59", strformat("戰鬥超時%d分鐘", COMBATLIMIT))
    var saveset_array = stringtoarray(AESdecrypt(filereadex(pathdat)))
    if(!isarray(saveset_array))
        msgbox("所選擇檔案不正確", 4)
        return false
    end
    var controlsave0 = saveset_array[0]
    var controlsave1 = saveset_array[1]
    var controlsave2 = saveset_array[2]
    var controlsave3 = saveset_array[3]
    var controlsave4 = saveset_array[4]
    var controlsave5 = saveset_array[5]
    var controlsave6 = saveset_array[6]
    var controlsave7 = saveset_array[7]
    var controlsave8 = saveset_array[8]
    var controlsave9 = saveset_array[9]
    for(var i = 0; i < 68; i++)
        if(vartype(controlsave0[i]) == "bool")
            if(i != 24 && i != 29 && i != 10)
                checksetstate("check" & i, controlsave0[i])
            end
        end
    end
    for(var i = 0; i < 23; i++)
        if(controlsave1[i] != "")
            if(i != 12 && i != 15 && i != 16 && i != 9)
                editsettext("edit" & i, controlsave1[i])
                select(i)
                    case 17
                    var tmp
                    var size = strsplit(controlsave1[i], "|", tmp)
                    for(var j = 0; j < size; j++)
                        if(tmp[j] != "")
                            arraypush(preitemuse[1], tmp[j])
                        end
                    end
                    case 18
                    var tmp
                    var size = strsplit(controlsave1[i], "|", tmp)
                    for(var j = 0; j < size; j++)
                        if(tmp[j] != "")
                            arraypush(preitemuse[2], tmp[j])
                        end
                    end
                    case 19
                    var tmp
                    var size = strsplit(controlsave1[i], "|", tmp)
                    for(var j = 0; j < size; j++)
                        if(tmp[j] != "")
                            arraypush(preitemuse[3], tmp[j])
                        end
                    end
                    case 20
                    var tmp
                    var size = strsplit(controlsave1[i], "|", tmp)
                    for(var j = 0; j < size; j++)
                        if(tmp[i] != "")
                            arraypush(preitemuse[4], tmp[j])
                        end
                    end
                end
            end
        end
    end
    for(var i = 0; i < 10; i++)
        if(controlsave2[i] == "" || controlsave2[i] == -1)
            controlsave2[i] = 0
        end
        if(i == 0 && type == 0)
            combosetcursel("combobox" & i, controlsave2[i])
            ComboServer()
        elseif(i == 1 && type == 1)
            combosetcursel("combobox" & i, controlsave2[i])
        elseif(i != 0 && i != 0)
            combosetcursel("combobox" & i, controlsave2[i])
        end
    end
    for(var i = 0; i < 7; i++)
        if(controlsave3[i] == -1 || controlsave3[i] == "")
            controlsave3[i] = 0
        end
        combosetcursel("co" & i, controlsave3[i])
        SetColContent(i)
        combosetcursel("col" & i, controlsave4[i])
    end
    for(var i = 0; i < 3; i++)
        combosetcursel("pco" & i, controlsave5[i])
    end
    Target_array = controlsave7
    Target_array2 = controlsave8
end