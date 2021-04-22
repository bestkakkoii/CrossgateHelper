//////////全局變量///////////
var m_hwnd = 0
var bc = null
var FTP = null
var bchwnd = 0
var barhwnd = array(0, 0, 0, 0)
var bcpath = ""
var ALLREGSTATE = 0
var CgHPver = "1.04"
var SubCgHPver = "1.0.4.5"
var rc = ""
var StairProcesshandle = 0
var StairFinderHwnd = 0
var scrollhwnd = array(0, 0)
var g_TalkDetect = ""
//全局血量
var mainHP = 0
var mainMAXHP = 0
var mainMP = 0
var mainMAXMP = 0
var hpstring = "0/0"
var mpstring = "0/0"
//com
var lw = null
var mf = null
var LoginPreCheck = false
//異常狀態變量
var COMBATLIMIT = 20
var NORMALLIMIT = 20
var GROUPLIMIT = 3
var HPLIMIT = 20
var MPLIMIT = 20
//非戰鬥一次性變量
var combatUnit = true
var CombatDelay = true
//非登入一次性變量
var OneTime = true
var OneTime2 = true
//使用者資訊變量
var WebInformation = array("", "", "", "", "", "", "", "", "", "", "")
//線程ID
var AutoCombatSystemID = 0
var AutoCombatSystemID2 = 0
var criticalID = 0
var mainID = 0
var submainID = 0
var FreeProcessMemoryID = 0
var HeartBeatID = 0
var 連線ID = 0
var 連線ID2 = 0
var autoNPCID = 0
var SetServerProcID = 0
var verificationID = 0
var AutoWalkID = 0
var AutoWalkExID = 0
var FINDROUTEID = 0
//全局控件變量
var superspeedstate = 0
var coselect = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var maplock = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var MAPINFO_array = array()
var gridmapOnOff = false
//防閃爍變量
var STATUSWORDSAVED = ""
var mxsave = 0
var mysave = 0
var eastsave = 0
var southsave = 0
var directionsave = 0
var mapsave = 0
var mapIDsave = 0
var levelsave = 0
var mainHPsave = 0
var mainMAXHPsave = 0
var mainMPsave = 0
var mainMAXMPsave = 0
var petpossave = -1
var petlevelsave = array(0, 0, 0, 0, 0)
var pethpsave = array(0, 0, 0, 0, 0)
var petmaxhpsave = array(0, 0, 0, 0, 0)
var petmpsave = array(0, 0, 0, 0, 0)
var petmaxmpsave = array(0, 0, 0, 0, 0)
var skillnamesave = array("", "", "", "", "", "", "", "", "", "", "", "", "", "")
var petskillnamesave = array("", "", "", "", "", "", "", "", "", "", "", "", "", "")
var itemNamesave = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
var itemNamesave2 = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
var itemAmountsave = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var WearNamesave = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
var skillexpsave = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var coselectsave = array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
var Unitsave = array("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
var combattimeinfosave = ""
var infoshowsave = array("戰鬥人物動作", "戰鬥寵物動作")
var savetxsize = 0
var stonevaluesave = 0
//戰鬥動作字符串
var infoshow = array("戰鬥人物動作", "戰鬥寵物動作")
//戰鬥計時
var TickCount = 0
var CombatDuration = 0
var TotalRound = 0
var TotalDuration = 0
//平時計時
var NormalTickCount = 0
var NormalDuration = 0
//動作相關變量
var walkdelay = 500
var walklen = 1
var GBecount = 0
//異常狀態
var Abnormal = false