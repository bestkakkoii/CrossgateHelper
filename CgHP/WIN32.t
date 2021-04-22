//WINAPI常量
var WM_CHAR = #0102
var EM_GETSEL = #00B0
var EM_SETSEL = #00B1
var EM_LINEINDEX = #00BB
var EM_LINEFROMCHAR = #00C9
var EM_GETLINECOUNT = #00BA
var SB_LINEUP = 0      // Scrolls one line up.
var SB_LINELEFT = 0
var SB_LINEDOWN = 1      // Scrolls one line down. 
var SB_LINERIGHT = 1
var SB_PAGEUP = 2      // Scrolls one page up. 
var SB_PAGELEFT = 2
var SB_PAGEDOWN = 3      // Scrolls one page down. 
var SB_PAGERIGHT = 3
var SB_TOP = 6      // Scrolls to the upper left. 
var SB_LEFT = 6
var SB_BOTTOM = 7      // Scrolls to the lower right.
var SB_RIGHT = 7
var SB_ENDSCROLL = 8 
var LVM_SCROLL = #1014
var WM_VSCROLL = #0115
var SBM_SETSCROLLINFO = #00E9
var SBM_GETPOS = #00E1
var SBM_GETRANGE = #E3
var SIF_POS = #0004
var SB_VERT = #1
var I_GROUPIDNONE = -2
var LVIF_TEXT = #0001
var LVM_SETITEMTEXT = #102D
var LVM_SETTEXTBKCOLOR = #1026
var SS_SUNKEN = #1000
var WM_GETFONT = #0031
var WM_SETFONT = #0030
var EM_SETEXTENDEDSTYLE = #00E0
var LB_ADDSTRING = #0180
var LB_INSERTSTRING = #0181
var LB_DELETESTRING = #0182
var LB_SELITEMRANGEEX = #0183
var LB_RESETCONTENT = #0184
var LB_SETSEL = #0185
var LB_SETCURSEL = #0186
var LB_GETSEL = #0187
var LB_GETCURSEL = #0188
var LB_GETTEXT = #0189
var LB_GETTEXTLEN = #018A
var LB_GETCOUNT = #018B
var LB_SELECTSTRING = #018C
var LB_DIR = #018D
var LB_GETTOPINDEX = #018E
var LB_FINDSTRING = #018F
var LB_GETSELCOUNT = #0190
var LB_GETSELITEMS = #0191
var LB_SETTABSTOPS = #0192
var LB_GETHORIZONTALEXTENT = #0193
var LB_SETHORIZONTALEXTENT = #0194
var LB_SETCOLUMNWIDTH = #0195
var LB_ADDFILE = #0196
var LB_SETTOPINDEX = #0197
var LB_GETITEMRECT = #0198
var LB_GETITEMDATA = #0199
var LB_SETITEMDATA = #019A
var LB_SELITEMRANGE = #019B
var LB_SETANCHORINDEX = #019C
var LB_GETANCHORINDEX = #019D
var LB_SETCARETINDEX = #019E
var LB_GETCARETINDEX = #019F
var LB_SETITEMHEIGHT = #01A0
var LB_GETITEMHEIGHT = #01A1
var LB_FINDSTRINGEXACT = #01A2
var LB_SETLOCALE = #01A5
var LB_GETLOCALE = #01A6
var LB_SETCOUNT = #01A7
var LB_INITSTORAGE = #01A8
var LB_ITEMFROMPOINT = #01A9
var LB_MULTIPLEADDSTRING = #01B1
var LB_GETLISTBOXINFO = #01B2
var LB_MSGMAX_501 = #01B3
var LB_MSGMAX_WCE4 = #01B1
var LB_MSGMAX_4 = #01B0
var LB_MSGMAX_PRE4 = #01A8
var EM_SETMODIFY = 188
var CB_INSERTSTRING = #014A
var CB_DELETESTRING = #0144
var CB_SETEDITSEL = #0142
var CB_GETCOMBOBOXINFO = #0164
var WM_SETCURSOR = #20 //#20 如果鼠标引起光标在某个窗口中移动且鼠标输入没有被捕获时,就发消息给某个窗口 
var TVM_GETNEXTITEM = 4362 //#110a 取项目句柄
var TVM_EXPAND = 4354
var TVIS_BOLD = 16 //#10 加粗
var TVS_HASBUTTONS = 1 //#1 //使用加减框
var TVS_HASLINES = 2 //#2 //使用连线 
var TVS_LINESATROOT = 4 //#4 //使用根部线
var TVS_SINGLEEXPAND = #400
var TVM_INSERTITEMW = 4402 //#1132 插入项目W
var TVIF_CHILDREN = 64 //#40 是否有子
var TVIF_IMAGE = 2 //#2 图象
var TVIF_PARAM = 4 //#4 项目数值 
var TVIF_SELECTEDIMAGE = 32 //#20 选择图象 
var TVIF_STATE = 8 //#8 状态
var TVIF_TEXT = 1 //#1 文本 
var TTVI_LAST = 4294901762 //# //在列表尾部插入
var LVM_SETEXTENDEDLISTVIEWSTYLE = #1036
var LVM_INSERTCOLUMNW = #1061
var LVS_EX_COLUMNOVERFLOW = #80000000
var LVS_EX_COLUMNSNAPPOINTS = #40000000
var LVS_EX_GRIDLINES = #1
var LVS_REPORT = #1
var LVS_EX_HEADERINALLVIEWS = #02000000
var LVS_LIST = #003
var LVS_SINGLESEL = #4
var LVS_EDITLABELS = #200
var STAP_ALLOW_NONCLIENT = #00000001
var STAP_ALLOW_CONTROLS = #00000002
var STAP_ALLOW_WEBCONTENT = #00000004
var TCS_BUTTONS = #100
var TCS_FLATBUTTONS = #0008
var TCS_EX_FLATSEPARATORS = #1
var TCM_SETEXTENDEDSTYLE = #1334
var PBS_SMOOTH = #00000001
var PBM_SETPOS = #402
var WS_EX_NOREDIRECTIONBITMAP = #00200000
// Window Styles 可组合 
var WS_OVERLAPPED = #00000000 
var WS_POPUP = #80000000 
var WS_CHILD = #40000000 
var WS_MINIMIZE = #20000000 
var WS_VISIBLE = #10000000 
var WS_DISABLED = #08000000 
var WS_CLIPSIBLINGS = #04000000 
var WS_CLIPCHILDREN = #02000000 
var WS_MAXIMIZE = #01000000 
var WS_CAPTION = #00C00000   // WS_BORDER + WS_DLGFRAME 
var WS_BORDER = #00800000 
var WS_DLGFRAME = #00400000 
var WS_VSCROLL = #00200000 
var WS_HSCROLL = #00100000 
var WS_SYSMENU = #00080000 
var WS_THICKFRAME = #00040000 
var WS_GROUP = #00020000 
var WS_TABSTOP = #00010000 
var WS_MINIMIZEBOX = #00020000 
var WS_MAXIMIZEBOX = #00010000 
var WS_TILED = #00000000  //WS_OVERLAPPED 
var WS_ICONIC = #20000000 //WS_MINIMIZE 
var WS_SIZEBOX = #00040000 //WS_THICKFRAME 
//WS_OVERLAPPEDWINDOW 
var WS_TILEDWINDOW 
// Common Window Styles 
//(WS_OVERLAPPED + WS_CAPTION + WS_SYSMENU + WS_THICKFRAME + WS_MINIMIZEBOX +WS_MAXIMIZEBOX) 
var WS_OVERLAPPEDWINDOW 
//(WS_POPUP + WS_BORDER +WS_SYSMENU) 
var WS_POPUPWINDOW  
//WS_CHILD 
var WS_CHILDWINDOW = #40000000 
// Extended Window Styles可组合 
var WS_EX_DLGMODALFRAME = #00000001 
var WS_EX_NOPARENTNOTIFY = #00000004 
var WS_EX_TOPMOST = #00000008 
var WS_EX_ACCEPTFILES = #00000010 
var WS_EX_TRANSPARENT = #00000020 
var WS_EX_MDICHILD = #00000040 
var WS_EX_TOOLWINDOW = #00000080 
var WS_EX_WINDOWEDGE = #00000100 
var WS_EX_CLIENTEDGE = #00000200 
var WS_EX_CONTEXTHELP = #00000400 
var WS_EX_RIGHT = #00001000 
var WS_EX_LEFT = #00000000 
var WS_EX_RTLREADING = #00002000 
var WS_EX_LTRREADING = #00000000 
var WS_EX_LEFTSCROLLBAR = #00004000 
var WS_EX_RIGHTSCROLLBAR = #00000000 
var WS_EX_CONTROLPARENT = #00010000 
var WS_EX_STATICEDGE = #00020000 
var WS_EX_APPWINDOW = #00040000 
//(WS_EX_WINDOWEDGE | WS_EX_CLIENTEDGE) 
var WS_EX_OVERLAPPEDWINDOW   
//(WS_EX_WINDOWEDGE | WS_EX_TOOLWINDOW | WS_EX_TOPMOST) 
var WS_EX_PALETTEWINDOW     
var WS_EX_LAYERED = #00080000 
var WS_EX_NOINHERITLAYOUT = #00100000  // Disable inheritence of mirroring by children 
var WS_EX_LAYOUTRTL = #00400000  // Right to left mirroring 
var WS_EX_COMPOSITED = #02000000 
var WS_EX_NOACTIVATE = #08000000 
//ChildWindowFromPointEx可取如下值 
var CWP_ALL = #0000 //处理所有的子窗口 
var CWP_SKIPINVISIBLE = #0001 //忽略不可见的子窗口 
var CWP_SKIPDISABLED = #0002 //忽略无效的子窗口 
var CWP_SKIPTRANSPARENT = #0004 //忽略透明的子窗口 
//GetWindow可取如下值 
var GW_HWNDFIRST = 0 //要获取的窗口和原窗口处于同一级别，但它的 Z 序最大 
var GW_HWNDLAST = 1 //要获取的窗口和原窗口处于同一级别，但它的 Z 序最小 
var GW_HWNDNEXT = 2 //要获取的窗口和原窗口处于同一级别，并且它的 Z 序恰好在原窗口之下 
var GW_HWNDPREV = 3 //要获取的窗口和原窗口处于同一级别，并且它的 Z 序恰好在原窗口之上 
var GW_OWNER = 4 //要获取的窗口为拥有原窗口的窗口 
var GW_CHILD = 5 //要获取的窗口为原窗口的子窗口 
var GW_ENABLEDPOPUP = 6 //获取的窗口为属于原窗口的活跃弹出式窗口 
//GetWindowLong 
var GWL_WNDPROC = -4 //窗口过程的地址，或代表窗口过程的地址的句柄。必须使用CallWindowProc函数调用窗口过程 
var GWL_HINSTANCE = -6 //检索应用程序实例的句柄 
var GWL_HWNDPARENT = -8 //如果父窗口存在,获得父窗口句柄。 
var GWL_STYLE = -16 //窗口风格 
var GWL_EXSTYLE = -20 //新的窗口扩展方式 
var GWL_USERDATA = -21 //与窗口有关的32位值。每一个窗口均有一个由创建该窗口的应用程序使用的32位值 
var GWL_ID = -12 //窗口标识 
//SetWindowPos 
var HWND_TOP = 0 
var HWND_BOTTOM = 1 
var HWND_TOPMOST = -1 
var HWND_NOTOPMOST = -2 
//SetWindowPos Flags可组合 
var SWP_NOSIZE = #0001 
var SWP_NOMOVE = #0002 
var SWP_NOZORDER = #0004 
var SWP_NOREDRAW = #0008 
var SWP_NOACTIVATE = #0010 
var SWP_FRAMECHANGED = #0020   
var SWP_SHOWWINDOW = #0040 
var SWP_HIDEWINDOW = #0080 
var SWP_NOCOPYBITS = #0100 
var SWP_NOOWNERZORDER = #0200   
var SWP_NOSENDCHANGING = #0400   
var SWP_DRAWFRAME       //SWP_FRAMECHANGED 
var SWP_NOREPOSITION    //SWP_NOOWNERZORDER 
var SWP_DEFERERASE = #2000 
var SWP_ASYNCWINDOWPOS = #4000 
//WINDOWPLACEMENT结构体 flags 
var WPF_SETMINPOSITION = #0001 
var WPF_RESTORETOMAXIMIZED = #0002 
var WPF_ASYNCWINDOWPLACEMENT = #0004 
// ShowWindow() Commands可取如下值之一 
var SW_HIDE = 0 //隐藏该窗口并使另一个窗口活动 
var SW_SHOWNORMAL = 1 //激活并显示一个窗口。若其为图标或全屏方式，则恢复为它的原始尺寸和位置 
var SW_NORMAL = 1 //以当前状态显示窗口。当前活动的窗口仍保持活动 
var SW_SHOWMINIMIZED = 2 //激活并以以图标方式显示一个窗口 
var SW_SHOWMAXIMIZED = 3 //激活并以全屏方式显示一个窗口 
var SW_MAXIMIZE = 3 //指定的窗口最大化 
var SW_SHOWNOACTIVATE = 4 //以最近的尺寸和位置显示一个窗口。当前活动的窗口仍保持活动 
var SW_SHOW = 5 //激活窗口,显示当前的大小和位置 
var SW_MINIMIZE = 6 //使指定窗口变成图标，并激活窗口管理表中的顶层窗口 
var SW_SHOWMINNOACTIVE = 7 //以图标方式显示窗口。当前活动的窗口仍保持活动 
var SW_SHOWNA = 8 //以当前状态显示窗口。当前活动的窗口仍保持活动 
var SW_RESTORE = 9 //同 SW_SHOWNORMOAL 
var SW_SHOWDEFAULT = 10 //在启动一个应用程序时所用 
var SW_FORCEMINIMIZE = 11 //在WindowNT5.0中最小化窗口，即使拥有窗口的线程被挂起也会最小化。在从其他线程最小化窗口时才使用这个参数 
var SW_MAX = 11 // 
// Old ShowWindow() Commands 
var HIDE_WINDOW = 0 
var SHOW_OPENWINDOW = 1 
var SHOW_ICONWINDOW = 2 
var SHOW_FULLSCREEN = 3 
var SHOW_OPENNOACTIVATE = 4 
//Identifiers for the WM_SHOWWINDOW message 
var SW_PARENTCLOSING = 1 
var SW_OTHERZOOM = 2 
var SW_PARENTOPENING = 3 
var SW_OTHERUNZOOM = 4 
//LockSetForgroundWindow 
var LSFW_LOCK = 1 //禁用 SetForegroundWindow 函数 
var LSFW_UNLOCK = 2 //启用 SetForegroundWindow 函数 
// MessageBox() Flags 取下列值之一 
var MB_OK = #00000000 //消息框显示停止符号图标 
var MB_OKCANCEL = #00000001 //消息框含有两个按钮： OK 和 Cancel 
var MB_ABORTRETRYIGNORE = #00000002 //消息框中含有三个按钮： Abort， Retry 和 Ignore 
var MB_YESNOCANCEL = #00000003 
var MB_YESNO = #00000004 
var MB_RETRYCANCEL = #00000005 //消息框含有两个按钮： Retry 和 Cancel 
var MB_CANCELTRYCONTINUE = #00000006 
var MB_ICONHAND = #00000010 //消息框显示错误图标（播放由SystemHand定义的声音） 
var MB_ICONQUESTION = #00000020 //消息框显示问号图标（播放由SystemQuestion定义的声音） 
var MB_ICONEXCLAMATION = #00000030 //消息框显示惊叹号图标（播放由SystemExclamation定义的声音） 
var MB_ICONASTERISK = #00000040 //（播放由SystemAsterisk定义的声音 
var MB_USERICON = #00000080 
var MB_ICONWARNING = #00000030           //MB_ICONEXCLAMATION 
var MB_ICONERROR                //MB_ICONHAND 
var MB_ICONINFORMATION = #00000040         //MB_ICONASTERISK 
var MB_ICONSTOP = #00000010               //MB_ICONHAND//消息框显示停止符号图标 
var MB_DEFBUTTON1 = #00000000 //第一个按钮是缺省按钮。注意：如果没有设定 MB_DEFBUTTON2 或MB_DEFBUTTON3或MB_DEFBUTTON4 ，那么第一个按钮总是缺省按钮。 
var MB_DEFBUTTON2 = #00000100 //第二个按钮是缺省按钮 
var MB_DEFBUTTON3 = #00000200 //第三个按钮是缺省按钮 
var MB_DEFBUTTON4 = #00000300 //第四个按钮是缺省按钮 
var MB_APPLMODAL = #00000000 
var MB_SYSTEMMODAL = #00001000 
var MB_TASKMODAL = #00002000 
var MB_HELP = #00004000 // Help Button 
var MB_NOFOCUS = #00008000 
var MB_SETFOREGROUND = #00010000 
var MB_DEFAULT_DESKTOP_ONLY = #00020000 
var MB_TOPMOST = #00040000 
var MB_RIGHT = #00080000 
var MB_RTLREADING = #00100000 
//Mapping Modes 
var MM_TEXT = 1 //每个逻辑单位转换为一个图素，X正方向向右，Y正方向向下 
var MM_LOMETRIC = 2 //每个逻辑单位转换为0.1毫米，X正方向向右，Y正方向向上 
var MM_HIMETRIC = 3 //每个逻辑单位转换为0.01毫米，X正方向向右，Y的正方向向上 
var MM_LOENGLISH = 4 //每个逻辑单位转换为0.01英寸，X正方向向右，Y正方向向上 
var MM_HIENGLISH = 5 //每个逻辑单位转换为0.001英寸，X的正方向向右，Y的正方向向上 
var MM_TWIPS = 6 //每个逻辑单位转换为打印点的1/20（即1/1440英寸），X正方向向右，Y方向向上 
var MM_ISOTROPIC = 7 //逻辑单位转换成具有均等比例轴的任意单位，即沿X轴的一个单位等于沿Y轴的一个单位，用SetWindowExt和SetViewportExt函数可以指定该轴的单位和方向。图形设备界面（GDI）需要进行调整，以保证X和Y的单位保持相同大小（当设置窗口范围时，视口将被调整以达到单位大小相同） 
var MM_ANISOTROPIC = 8 //逻辑单位转换成具有任意比例轴的任意单位，用SetWindowExt和SetViewportExt函数可指定单位、方向和比例 
//FLASHWINFO结构体 dwFlags可组合 
var FLASHW_STOP = 0 //停止闪烁。系统窗口恢复到原来的状态。 
var FLASHW_CAPTION = #00000001 //Flash的窗口标题 
var FLASHW_TRAY = #00000002 //Flash任务栏按钮。 
var FLASHW_ALL         // (FLASHW_CAPTION | FLASHW_TRAY)//Flash窗口标题和任务栏按钮。这相当于设置FLASHW_CAPTION + FLASHW_TRAY组合 
var FLASHW_TIMER = #00000004 //闪光灯不断,直到FLASHW_STOP标志被设置 
var FLASHW_TIMERNOFG = #0000000C //闪光灯不断,直到窗口的前景。 
// Dialog Box Command IDs MessageBoxW返回值 
var IDOK = 1 //Ok 按钮被按下 
var IDCANCEL = 2 //Cancel 按钮被按下 
var IDABORT = 3 //Abort 按钮被按下 
var IDRETRY = 4 //Retry 按钮被按下 
var IDIGNORE = 5 //Ignore 按钮被按下 
var IDYES = 6 //Yes 按钮被按下 
var IDNO = 7 //No 按钮被按下 
var IDCLOSE = 8 //Close 按钮被按下 
var IDHELP = 9 //Help 按钮被按下 
var IDTRYAGAIN = 10 //Tryagain 按钮被按下 
var IDCONTINUE = 11 //Continue按钮被按下 
//MENUITEMINFO结构体 所用的常量 
//一个菜单可以用用文本和位图两种方式中的一种方式显示菜单项，而不能同时使用 
//fMask 检索或设置,这个成员可以使用一个或多个以下值 
var MIIM_STATE = #00000001 //检索或设置fState成员 
var MIIM_ID = #00000002 //检索或设置wID成员 
var MIIM_SUBMENU = #00000004 //检索或设置hSubMenu成员 
var MIIM_CHECKMARKS = #00000008 //检索或设置hbmpChecked和hbmpUnchecked成员 
var MIIM_TYPE = #00000010 // 
var MIIM_DATA = #00000020 //检索或设置dwItemData成员 
var MIIM_STRING = #00000040 // 
var MIIM_BITMAP = #00000080 // 
var MIIM_FTYPE = #00000100 //检索或设置fType和dwTypeData成员 
//fType 菜单项类型.这个成员可以使用一个或多个这些值 只有在设置了fMask为MIIM_TYPE时才能使用fType 
var MFT_STRING = #00000000 // 用一个文本字符串显示菜单项.dwTypeData成员指示一个以NULL结尾的字符串,并且cch成员是字符串的长度 
var MFT_BITMAP = #00000004 //使用一个位图显示菜单项.dwTypeData低位字是该位图的句柄.并且cch被忽视 
var MFT_MENUBARBREAK = #00000020 //放置菜单项在新行上(适用于菜单栏)或在新列内(适用于下拉菜单，子菜单,快捷菜单).对于下拉菜单，子菜单，或快捷菜单，用垂直线分隔以前的列和新的列 
var MFT_MENUBREAK = #00000040 //放置菜单项在新行上(适用于菜单栏)或在新列内(适用于下拉菜单，子菜单,快捷菜单).对于下拉菜单，子菜单，或快捷菜单，这个列不被垂直线分开 
var MFT_OWNERDRAW = #00000100 //分配责任到那个窗体菜单绘制自己的菜单项.在菜单第一次显示之前窗体收到一条WM_MEASUREITEM消息,和菜单项必须更新时收到一条WM_DRAWITEM消息。如果该值被指定，则dwTypeData成员包含一个应用程序定义的值 
var MFT_RADIOCHECK = #00000200 //如果hbmpChecked成员是NULL ,显示选中的菜单项使用一个单选按钮来代替一个复选标记 
var MFT_SEPARATOR = #00000800 //指定那个菜单项是一个分隔条.一个分隔条菜单项显示为一条水平分隔线 
var MFT_RIGHTORDER = #00002000 // 
var MFT_RIGHTJUSTIFY = #00004000 //向右对齐菜单项和所有后来的项,如果菜单项在菜单栏内这个值才是唯一有效的 
//fState 使用fState前应设置了fMask的MIIM_STATE标记 
var MFS_GRAYED = #00000003 //菜单项无效并变灰使得它不能被选择.等效于MFS_DISABLED. 
var MFS_DISABLED = #00000003 //菜单项无效并变灰使得它不能被选择.等效于MFS_GRAYED 
var MFS_CHECKED = #00000008 //复选的菜单项.至于更多关于菜单项选中的信息,看hbmpChecked成员 
var MFS_HILITE = #00000080 //菜单项高亮显示 
var MFS_ENABLED = #00000000 //激活菜单项使它可以被选择。这是默认的状态. 
var MFS_UNCHECKED = #00000000 //取消复选菜单项.至于更多关于菜单项unchecked信息，看hbmpUnchecked成员变量 
var MFS_UNHILITE = #00000000 //移除菜单项的高亮显示,这是默认状态 
var MFS_DEFAULT = #00001000 //指定默认的菜单项。一个菜单仅仅只可以包含一个默认的菜单项,用粗体显示 
//hbmpItem 菜单项上显示位图的句柄，它可能是以下标记中的一个，该项只有在设置了fMask成员的MIIM_BITMAP标记时才能使用 
var HBMMENU_CALLBACK = -1 //一个由拥有该菜单的窗口绘制的位图。应用程序必须处理WM_MEASUREITEM和WM_DRAWITEM消息 
var HBMMENU_SYSTEM = 1 // Windows图标或是在dwItemData中由窗口指定的图标 
var HBMMENU_MBAR_RESTORE = 2 //菜单栏的还原按钮 
var HBMMENU_MBAR_MINIMIZE = 3 //菜单栏的最小化按钮 
var HBMMENU_MBAR_CLOSE = 5 //菜单栏的关闭按钮 
var HBMMENU_MBAR_CLOSE_D = 6 //禁用菜单栏的关闭按钮 
var HBMMENU_MBAR_MINIMIZE_D = 7 //禁用菜单栏的最小化按钮 
var HBMMENU_POPUP_CLOSE = 8 //子菜单的关闭按钮 
var HBMMENU_POPUP_RESTORE = 9 //子菜单的还原按钮 
var HBMMENU_POPUP_MAXIMIZE = 10 //子菜单的最大化按钮 
var HBMMENU_POPUP_MINIMIZE = 11 //子菜单的最小化按钮 
var MF_INSERT = #00000000 
var MF_CHANGE = #00000080 
var MF_APPEND = #00000100 
var MF_DELETE = #00000200 
var MF_REMOVE = #00001000 
var MF_BYCOMMAND = #00000000 
var MF_BYPOSITION = #00000400 
var MF_SEPARATOR = #00000800 
var MF_ENABLED = #00000000 
var MF_GRAYED = #00000001 
var MF_DISABLED = #00000002 
var MF_UNCHECKED = #00000000 
var MF_CHECKED = #00000008 
var MF_USECHECKBITMAPS = #00000200 
var MF_STRING = #00000000 
var MF_BITMAP = #00000004 
var MF_OWNERDRAW = #00000100 
var MF_POPUP = #00000010 
var MF_MENUBARBREAK = #00000020 
var MF_MENUBREAK = #00000040 
var MF_UNHILITE = #00000000 
var MF_HILITE = #00000080 
var MF_DEFAULT = #00001000 
var MF_SYSMENU = #00002000 
var MF_HELP = #00004000 
var MF_RIGHTJUSTIFY = #00004000 
var MF_MOUSESELECT = #00008000 
var MF_END = #00000080 
//GetMenuDefaultItem gmdiFlags 
var GMDI_USEDISABLED = #0001 //指示如果缺省菜单是一个带有子菜单的菜单项，则函数将进入子菜单去搜素缺省菜单项，如果在子菜单中没有缺省菜单项，则函数返回打开该子菜单的菜单项，函数在缺省情况下返回第一个缺省菜单，而不管其是否是带有子菜单的菜单项 
var GMDI_GOINTOPOPUPS = #0002 //指示如果缺省菜单为无效的，函数也将返回该菜单项。函数在缺省情况下跳过无效的菜单项 
//Flags for TrackPopupMenu 
var TPM_LEFTBUTTON = #0000 
var TPM_RIGHTBUTTON = #0002 
var TPM_LEFTALIGN = #0000 
var TPM_CENTERALIGN = #0004 
var TPM_RIGHTALIGN = #0008 
var TPM_TOPALIGN = #0000 
var TPM_VCENTERALIGN = #0010 
var TPM_BOTTOMALIGN = #0020 
var TPM_HORIZONTAL = #0000    
var TPM_VERTICAL = #0040    
var TPM_NONOTIFY = #0080     
var TPM_RETURNCMD = #0100 
var TPM_RECURSE = #0001 
var TPM_HORPOSANIMATION = #0400 
var TPM_HORNEGANIMATION = #0800 
var TPM_VERPOSANIMATION = #1000 
var TPM_VERNEGANIMATION = #2000 
var TPM_NOANIMATION = #4000 
var TPM_LAYOUTRTL = #8000 
var TPM_WORKAREA = #10000 
//LoadImage( 
// HINSTANCE hinst, // handle to instance 
// LPCTSTR lpszName, // image to load 
// UINT uType, // image type 
// int cxDesired, // desired width 
// int cyDesired, // desired height 
// UINT fuLoad // load options 
//); 
//LoadImage uType 
var IMAGE_BITMAP = 0 //装载一幅位图 
var IMAGE_ICON = 1 //装载一个图标 
var IMAGE_CURSOR = 2 //装载一个光标 
//LoadImage fuLoad 
var LR_DEFAULTCOLOR = #00000000 //缺省标志；它不作任何事情。它的含义是“无LR_MONOCHROME” 
var LR_MONOCHROME = #00000001 //装载黑白图 
var LR_COLOR = #00000002 // 
var LR_COPYRETURNORG = #00000004 // 
var LR_COPYDELETEORG = #00000008 // 
var LR_LOADFROMFILE = #00000010 //根据参数lpszName的值装载图像。若标记未被给定，lpszName的值为资源名称 
var LR_LOADTRANSPARENT = #00000020 // 
var LR_DEFAULTSIZE = #00000040 //若 cxDesired或cyDesired被设为零，使用系统指定的公制值标识光标或图标的宽和高。如果这个参数不被设置且cxDesired或cyDesired被设为零，函数使用实际资源尺寸。如果资源包含多个图像，则使用第一个图像的大小 
var LR_VGACOLOR = #00000080 // 
var LR_LOADMAP3DCOLORS = #00001000 //查找图像的颜色表并且按下面相应的3D颜色表的灰度进行替换 
var LR_CREATEDIBSECTION = #00002000 //当参数uType指定为IMAGE_BITMAP时，使得函数返回一个DIB部分位图，而不是一个兼容的位图。这个标志在装载一个位图，而不是映射它的颜色到显示设备时非常有用 
var LR_COPYFROMRESOURCE = #00004000 // 
var LR_SHARED = #00008000 //若图像将被多次装载则共享。如果LR_SHARED未被设置，则再向同一个资源第二次调用这个图像时就会再装载一遍这个图像且返回不同的句柄 
//Local Memory Flags 
var LMEM_FIXED = #0000 
var LMEM_MOVEABLE = #0002 
var LMEM_NOCOMPACT = #0010 
var LMEM_NODISCARD = #0020 
var LMEM_ZEROINIT = #0040 
var LMEM_MODIFY = #0080 
var LMEM_DISCARDABLE = #0F00 
var LMEM_VALID_FLAGS = #0F72 
var LMEM_INVALID_HANDLE = #8000 
//BitBlt Function dwRop param 
var SRCCOPY = #00CC0020  //dest = source 
var SRCPAINT = #00EE0086  //dest = source OR dest 
var SRCAND = #008800C6  //dest = source AND dest 
var SRCINVERT = #00660046 // dest = source XOR dest 
var SRCERASE = #00440328  //dest = source AND (NOT dest ) 
var NOTSRCCOPY = #00330008  //dest = (NOT source) 
var NOTSRCERASE = #001100A6  //dest = (NOT src) AND (NOT dest) 
var MERGECOPY = #00C000CA  //dest = (source AND pattern) 
var MERGEPAINT = #00BB0226  //dest = (NOT source) OR dest 
var PATCOPY = #00F00021  //dest = pattern 
var PATPAINT = #00FB0A09  //dest = DPSnoo 
var PATINVERT = #005A0049  //dest = pattern XOR dest 
var DSTINVERT = #00550009  //dest = (NOT dest) 
var BLACKNESS = #00000042  //dest = BLACK 
var WHITENESS = #00FF0062  //dest = WHITE 
var NOMIRRORBITMAP = #80000000  //Do not Mirror the bitmap in this call 
var CAPTUREBLT = #40000000  //Include layered windows 
//GetDCEx() flags 
var DCX_WINDOW = #00000001 //返回与窗口矩形而不是用户矩形对应的 DC 
var DCX_CACHE = #00000002 //从高速缓冲存储区而不是从 OWNDC 或 CLASSDC 窗口返回一个 DC，实际上作废 CS_OWNDC 和 CS_ CLASSDC 
var DCX_NORESETATTRS = #00000004 //当释放一个 DC 时不回复该设备的默认属性值 
var DCX_CLIPCHILDREN = #00000008 //将 hWnd 参数指定的窗口下的所有子窗口的可见域排除在外 
var DCX_CLIPSIBLINGS = #00000010 //将 hWnd 参数所指定的窗口之上的所有兄弟窗口的可见域排除在外 
var DCX_PARENTCLIP = #00000020 //使用父窗口的可见区域 
var DCX_EXCLUDERGN = #00000040 //由 hRgnClip 指定的剪贴域被排除在返回 DC 的可见域之外 
var DCX_INTERSECTRGN = #00000080 //由 hRgnClip 指定的剪贴域与返回 DC 的可见域相交 
var DCX_EXCLUDEUPDATE = #00000100 // 
var DCX_INTERSECTUPDATE = #00000200 // 
var DCX_LOCKWINDOWUPDATE = #00000400 //即使有 LockWindowUpdate 调节在起作用，仍允许绘图，其他情况，此调用将排除该窗口。此标志可用于跟踪时绘图 
var DCX_VALIDATE = #00200000 // 
//Object Definitions for EnumObjects() 
var OBJ_PEN = 1 //返回当前选择的笔 
var OBJ_BRUSH = 2 //返回当前选定的刷 
var OBJ_DC = 3 
var OBJ_METADC = 4 
var OBJ_PAL = 5 //返回当前选择的调色板 
var OBJ_FONT = 6 //返回当前选中的字体 
var OBJ_BITMAP = 7 //返回当前所选位图 
var OBJ_REGION = 8 
var OBJ_METAFILE = 9 
var OBJ_MEMDC = 10 
var OBJ_EXTPEN = 11 
var OBJ_ENHMETADC = 12 
var OBJ_ENHMETAFILE = 13 
var OBJ_COLORSPACE = 14 //返回当前的颜色空间 
var GDI_OBJ_LAST 
// GetSystemMetrics() codes 
var SM_CXSCREEN = 0 //指定屏幕的宽度 
var SM_CYSCREEN = 1 //指定屏幕的高度 
var SM_CXVSCROLL = 2 //垂直滚动条上箭头位图的宽度 
var SM_CYHSCROLL = 3 //水平滚动条上箭头位图的高度 
var SM_CYCAPTION = 4 //正常标题域的高度 
var SM_CXBORDER = 5 //窗口边框的宽度（以像素为单位）。在 3-D 显示方式的窗口下该值和SM_CXEDGE 相同 
var SM_CYBORDER = 6 //窗口边框的高度（以像素为单位）。在 3-D 显示方式的窗口下该值和SM_CXEDGE 相同 
var SM_CXDLGFRAME = 7 //和 SM_CXFIXEDFRAME 相同 
var SM_CYDLGFRAME = 8 //和 SM_CYFIXEDFRAME 相同 
var SM_CYVTHUMB = 9 //垂直滚动条上滑动块的高度 
var SM_CXHTHUMB = 10 //水平滚动条上滑动块的宽度 
var SM_CXICON = 11 //图标的缺省宽度， LoadIcon 函数只能装载该宽度的图标 
var SM_CYICON = 12 //图标的缺省高度， LoadIcon 函数只能装载该高度的图标 
var SM_CXCURSOR = 13 //鼠标的宽度（以像素为单位），系统不能生成其他尺寸的鼠标 
var SM_CYCURSOR = 14 //鼠标的高度（以像素为单位），系统不能生成其他尺寸的鼠标 
var SM_CYMENU = 15 //单行菜单条的高度 
var SM_CXFULLSCREEN = 16 //屏幕的宽度（包含系统任务栏） 
var SM_CYFULLSCREEN = 17 //屏幕的高度（包含系统任务栏），若要获取不包含任务栏的屏幕大小，可以用 SPI_GETWORKAREA 来调用 SystemParametersInfo 函数 
var SM_CYKANJIWINDOW = 18 //汉字窗口的高度 
var SM_MOUSEPRESENT = 19 //指定系统是否安装了鼠标，非零表示安装了鼠标，零表示没安装 
var SM_CYVSCROLL = 20 //垂直滚动条上箭头位图的高度 
var SM_CXHSCROLL = 21 //水平滚动条上箭头位图的宽度 
var SM_DEBUG = 22 //如果为TRUE或不为0的值表明系统安装了debug版本的USER.EXE,为FALSE或0则不是 
var SM_SWAPBUTTON = 23 //指定系统是否交换了鼠标的左右按钮功能。非零表示交换，零表示没有交换 
var SM_RESERVED1 = 24 // 
var SM_RESERVED2 = 25 // 
var SM_RESERVED3 = 26 // 
var SM_RESERVED4 = 27 // 
var SM_CXMIN = 28 //指定窗口的最小宽度 
var SM_CYMIN = 29 //指定窗口的最小高度 
var SM_CXSIZE = 30 //指定窗口标题栏中按钮的宽度 
var SM_CYSIZE = 31 //指定窗口标题栏中按钮的高度 
var SM_CXFRAME = 32 //和 SM_CXSIZEFRAME 相同 
var SM_CYFRAME = 33 //和 SM_CYSIZEFRAME 相同 
var SM_CXMINTRACK = 34 //指定可变大小窗口的最小宽度 
var SM_CYMINTRACK = 35 //指定可变大小窗口的最小高度，用户可以通过处理WM_GETMINMAXINFO 消息来改变该值 
var SM_CXDOUBLECLK = 36 //系统在判断鼠标双击事件时所限定的环绕第一个点击点的矩形大小。第二次点击只有在该矩形内才认为是双击（两次点击必须发生在一定时间范围内）。该参数指定该矩形的宽度 
var SM_CYDOUBLECLK = 37 //指定上述矩形的高度 
var SM_CXICONSPACING = 38 //当列表框等中的元素以图标方式显示时，给每个图标分配的方格大小。该参数指定该方格的宽度，它不应该比 SM_CXICON 值小 
var SM_CYICONSPACING = 39 //该参数指定上述方格的高度，它不应该比 SM_CYICON 值小 
var SM_MENUDROPALIGNMENT = 40 //如果为TRUE或不为0的值下拉菜单是右对齐的否则是左对齐的 
var SM_PENWINDOWS = 41 // 
var SM_DBCSENABLED = 42 //如果为TRUE或不为0的值表明系统安装了双字节版本的USER.EXE,为FALSE或0则不是 
var SM_CMOUSEBUTTONS = 43 //鼠标上按钮的个数， 0 代表没有安装鼠标 
var SM_SECURE = 44 //指定系统是否有安全机制，非零表示有，零表示没有 
var SM_CXEDGE = 45 //3-D 方式的窗口的边框宽度，与一般窗口的 SM_CXBORDER 对应 
var SM_CYEDGE = 46 //3-D 方式的窗口的边框高度，与一般窗口的 SM_CYBORDER 对应 
var SM_CXMINSPACING = 47 //排列最小化窗口时为其分配的方格宽度，应该大于或等于SM_CXMINIMIZED 
var SM_CYMINSPACING = 48 //排列最小化窗口时为其分配的方格高度，应该大于或等于SM_CYMINIMIZED 
var SM_CXSMICON = 49 //小图标的推荐宽度 
var SM_CYSMICON = 50 //小图标的推荐高度 
var SM_CYSMCAPTION = 51 //小标题的高度 
var SM_CXSMSIZE = 52 //小标题按钮的宽度 
var SM_CYSMSIZE = 53 //小标题按钮的高度 
var SM_CXMENUSIZE = 54 //指定菜单条按钮的宽度 
var SM_CYMENUSIZE = 55 //指定菜单条按钮的高度 
var SM_ARRANGE = 56 //获取系统排列最小化窗口的方式 
var SM_CXMINIMIZED = 57 //指定正常状况下最小化窗口的宽度 
var SM_CYMINIMIZED = 58 //指定正常状况下最小化窗口的高度 
var SM_CXMAXTRACK = 59 //指定可变大小窗口的最大宽度 
var SM_CYMAXTRACK = 60 //指定可变大小窗口的最大高度，用户可以通过处理WM_GETMINMAXINFO 消息来改变该值 
var SM_CXMAXIMIZED = 61 //指定最大化窗口的缺省宽度 
var SM_CYMAXIMIZED = 62 //指定最大化窗口的缺省高度 
var SM_NETWORK = 63 // 
var SM_CLEANBOOT = 67 //获取系统启动的方式： 0 为正常启动； 1 为安全方式； 2 为安全方式并且有网络功能。安全方式将绕过用户的启动文件 
var SM_CXDRAG = 68 //系统为了避免无目的拖动的发生，在起始拖动点周围定义一个矩形，鼠标在其内拖动不会被认为是拖放操作。该参数指定该矩形的宽度 
var SM_CYDRAG = 69 //指定上述矩形的高度 
var SM_SHOWSOUNDS = 70 // 
var SM_CXMENUCHECK = 71   //指定菜单项选中位图的缺省宽度 
var SM_CYMENUCHECK = 72 //指定菜单项选中位图的缺省高度 
var SM_SLOWMACHINE = 73 //指定系统是否安装了一个低端的处理器， TRUE 表示有， FALSE 表示没有 
var SM_MIDEASTENABLED = 74 // 
var SM_MOUSEWHEELPRESENT = 75 // 
var SM_XVIRTUALSCREEN = 76 // 
var SM_YVIRTUALSCREEN = 77 // 
var SM_CXVIRTUALSCREEN = 78 // 
var SM_CYVIRTUALSCREEN = 79 // 
var SM_CMONITORS = 80 //在 Windows NT 5.0 中指定监视器的数量 
var SM_SAMEDISPLAYFORMAT = 81 // 
var SM_CXFIXEDFRAME          //有标题栏但不能改变大小的窗口中的水平边框厚度（以像素为单位） //SM_CXDLGFRAME //// ;win40 name change */ 
var SM_CYFIXEDFRAME         //有标题栏但不能改变大小的窗口中的垂直边框厚度（以像素为单位） // SM_CYDLGFRAME //// ;win40 name change */ 
var SM_CXSIZEFRAME           //指定可变大小窗口的水平边框的厚度，和 SM_CXFRAME 相同 //SM_CXFRAME //// ;win40 name change */ 
var SM_CYSIZEFRAME           //指定可变大小窗口的垂直边框的厚度，和 SM_CYFRAME 相同 //SM_CYFRAME //// ;win40 name change */ 
//Parameter for SystemParametersInfo. 
var SPI_GETBEEP = #0001 
var SPI_SETBEEP = #0002 
var SPI_GETMOUSE = #0003 
var SPI_SETMOUSE = #0004 
var SPI_GETBORDER = #0005 
var SPI_SETBORDER = #0006 
var SPI_GETKEYBOARDSPEED = #000A 
var SPI_SETKEYBOARDSPEED = #000B 
var SPI_LANGDRIVER = #000C 
var SPI_ICONHORIZONTALSPACING = #000D 
var SPI_GETSCREENSAVETIMEOUT = #000E 
var SPI_SETSCREENSAVETIMEOUT = #000F 
var SPI_GETSCREENSAVEACTIVE = #0010 
var SPI_SETSCREENSAVEACTIVE = #0011 
var SPI_GETGRIDGRANULARITY = #0012 
var SPI_SETGRIDGRANULARITY = #0013 
var SPI_SETDESKWALLPAPER = #0014 
var SPI_SETDESKPATTERN = #0015 
var SPI_GETKEYBOARDDELAY = #0016 
var SPI_SETKEYBOARDDELAY = #0017 
var SPI_ICONVERTICALSPACING = #0018 
var SPI_GETICONTITLEWRAP = #0019 
var SPI_SETICONTITLEWRAP = #001A 
var SPI_GETMENUDROPALIGNMENT = #001B 
var SPI_SETMENUDROPALIGNMENT = #001C 
var SPI_SETDOUBLECLKWIDTH = #001D 
var SPI_SETDOUBLECLKHEIGHT = #001E 
var SPI_GETICONTITLELOGFONT = #001F 
var SPI_SETDOUBLECLICKTIME = #0020 
var SPI_SETMOUSEBUTTONSWAP = #0021 
var SPI_SETICONTITLELOGFONT = #0022 
var SPI_GETFASTTASKSWITCH = #0023 
var SPI_SETFASTTASKSWITCH = #0024 
var SPI_SETDRAGFULLWINDOWS = #0025 
var SPI_GETDRAGFULLWINDOWS = #0026 
var SPI_GETNONCLIENTMETRICS = #0029 
var SPI_SETNONCLIENTMETRICS = #002A 
var SPI_GETMINIMIZEDMETRICS = #002B 
var SPI_SETMINIMIZEDMETRICS = #002C 
var SPI_GETICONMETRICS = #002D 
var SPI_SETICONMETRICS = #002E 
var SPI_SETWORKAREA = #002F 
var SPI_GETWORKAREA = #0030 
var SPI_SETPENWINDOWS = #0031 
var SPI_GETHIGHCONTRAST = #0042 
var SPI_SETHIGHCONTRAST = #0043 
var SPI_GETKEYBOARDPREF = #0044 
var SPI_SETKEYBOARDPREF = #0045 
var SPI_GETSCREENREADER = #0046 
var SPI_SETSCREENREADER = #0047 
var SPI_GETANIMATION = #0048 
var SPI_SETANIMATION = #0049 
var SPI_GETFONTSMOOTHING = #004A 
var SPI_SETFONTSMOOTHING = #004B 
var SPI_SETDRAGWIDTH = #004C 
var SPI_SETDRAGHEIGHT = #004D 
var SPI_SETHANDHELD = #004E 
var SPI_GETLOWPOWERTIMEOUT = #004F 
var SPI_GETPOWEROFFTIMEOUT = #0050 
var SPI_SETLOWPOWERTIMEOUT = #0051 
var SPI_SETPOWEROFFTIMEOUT = #0052 
var SPI_GETLOWPOWERACTIVE = #0053 
var SPI_GETPOWEROFFACTIVE = #0054 
var SPI_SETLOWPOWERACTIVE = #0055 
var SPI_SETPOWEROFFACTIVE = #0056 
var SPI_SETCURSORS = #0057 
var SPI_SETICONS = #0058 
var SPI_GETDEFAULTINPUTLANG = #0059 
var SPI_SETDEFAULTINPUTLANG = #005A 
var SPI_SETLANGTOGGLE = #005B 
var SPI_GETWINDOWSEXTENSION = #005C 
var SPI_SETMOUSETRAILS = #005D 
var SPI_GETMOUSETRAILS = #005E 
var SPI_SETSCREENSAVERRUNNING = #0061 
var SPI_SCREENSAVERRUNNING     //SPI_SETSCREENSAVERRUNNING 
var SPI_GETFILTERKEYS = #0032 
var SPI_SETFILTERKEYS = #0033 
var SPI_GETTOGGLEKEYS = #0034 
var SPI_SETTOGGLEKEYS = #0035 
var SPI_GETMOUSEKEYS = #0036 
var SPI_SETMOUSEKEYS = #0037 
var SPI_GETSHOWSOUNDS = #0038 
var SPI_SETSHOWSOUNDS = #0039 
var SPI_GETSTICKYKEYS = #003A 
var SPI_SETSTICKYKEYS = #003B 
var SPI_GETACCESSTIMEOUT = #003C 
var SPI_SETACCESSTIMEOUT = #003D 
var SPI_GETSERIALKEYS = #003E 
var SPI_SETSERIALKEYS = #003F 
var SPI_GETSOUNDSENTRY = #0040 
var SPI_SETSOUNDSENTRY = #0041 
var SPI_GETSNAPTODEFBUTTON = #005F 
var SPI_SETSNAPTODEFBUTTON = #0060 
var SPI_GETMOUSEHOVERWIDTH = #0062 
var SPI_SETMOUSEHOVERWIDTH = #0063 
var SPI_GETMOUSEHOVERHEIGHT = #0064 
var SPI_SETMOUSEHOVERHEIGHT = #0065 
var SPI_GETMOUSEHOVERTIME = #0066 
var SPI_SETMOUSEHOVERTIME = #0067 
var SPI_GETWHEELSCROLLLINES = #0068 
var SPI_SETWHEELSCROLLLINES = #0069 
var SPI_GETMENUSHOWDELAY = #006A 
var SPI_SETMENUSHOWDELAY = #006B 
var SPI_GETWHEELSCROLLCHARS = #006C 
var SPI_SETWHEELSCROLLCHARS = #006D 
var SPI_GETSHOWIMEUI = #006E 
var SPI_SETSHOWIMEUI = #006F 
var SPI_GETMOUSESPEED = #0070 
var SPI_SETMOUSESPEED = #0071 
var SPI_GETSCREENSAVERRUNNING = #0072 
var SPI_GETDESKWALLPAPER = #0073 
var SPI_GETAUDIODESCRIPTION = #0074 
var SPI_SETAUDIODESCRIPTION = #0075 
var SPI_GETSCREENSAVESECURE = #0076 
var SPI_SETSCREENSAVESECURE = #0077 
var SPI_GETHUNGAPPTIMEOUT = #0078 
var SPI_SETHUNGAPPTIMEOUT = #0079 
var SPI_GETWAITTOKILLTIMEOUT = #007A 
var SPI_SETWAITTOKILLTIMEOUT = #007B 
var SPI_GETWAITTOKILLSERVICETIMEOUT = #007C 
var SPI_SETWAITTOKILLSERVICETIMEOUT = #007D 
var SPI_GETMOUSEDOCKTHRESHOLD = #007E 
var SPI_SETMOUSEDOCKTHRESHOLD = #007F 
var SPI_GETPENDOCKTHRESHOLD = #0080 
var SPI_SETPENDOCKTHRESHOLD = #0081 
var SPI_GETWINARRANGING = #0082 
var SPI_SETWINARRANGING = #0083 
var SPI_GETMOUSEDRAGOUTTHRESHOLD = #0084 
var SPI_SETMOUSEDRAGOUTTHRESHOLD = #0085 
var SPI_GETPENDRAGOUTTHRESHOLD = #0086 
var SPI_SETPENDRAGOUTTHRESHOLD = #0087 
var SPI_GETMOUSESIDEMOVETHRESHOLD = #0088 
var SPI_SETMOUSESIDEMOVETHRESHOLD = #0089 
var SPI_GETPENSIDEMOVETHRESHOLD = #008A 
var SPI_SETPENSIDEMOVETHRESHOLD = #008B 
var SPI_GETDRAGFROMMAXIMIZE = #008C 
var SPI_SETDRAGFROMMAXIMIZE = #008D 
var SPI_GETSNAPSIZING = #008E 
var SPI_SETSNAPSIZING = #008F 
var SPI_GETDOCKMOVING = #0090 
var SPI_SETDOCKMOVING = #0091 
var SPI_GETACTIVEWINDOWTRACKING = #1000 
var SPI_SETACTIVEWINDOWTRACKING = #1001 
var SPI_GETMENUANIMATION = #1002 
var SPI_SETMENUANIMATION = #1003 
var SPI_GETCOMBOBOXANIMATION = #1004 
var SPI_SETCOMBOBOXANIMATION = #1005 
var SPI_GETLISTBOXSMOOTHSCROLLING = #1006 
var SPI_SETLISTBOXSMOOTHSCROLLING = #1007 
var SPI_GETGRADIENTCAPTIONS = #1008 
var SPI_SETGRADIENTCAPTIONS = #1009 
var SPI_GETKEYBOARDCUES = #100A 
var SPI_SETKEYBOARDCUES = #100B 
var SPI_GETMENUUNDERLINES               //SPI_GETKEYBOARDCUES 
var SPI_SETMENUUNDERLINES              // SPI_SETKEYBOARDCUES 
var SPI_GETACTIVEWNDTRKZORDER = #100C 
var SPI_SETACTIVEWNDTRKZORDER = #100D 
var SPI_GETHOTTRACKING = #100E 
var SPI_SETHOTTRACKING = #100F 
var SPI_GETMENUFADE = #1012 
var SPI_SETMENUFADE = #1013 
var SPI_GETSELECTIONFADE = #1014 
var SPI_SETSELECTIONFADE = #1015 
var SPI_GETTOOLTIPANIMATION = #1016 
var SPI_SETTOOLTIPANIMATION = #1017 
var SPI_GETTOOLTIPFADE = #1018 
var SPI_SETTOOLTIPFADE = #1019 
var SPI_GETCURSORSHADOW = #101A 
var SPI_SETCURSORSHADOW = #101B 
var SPI_GETMOUSESONAR = #101C 
var SPI_SETMOUSESONAR = #101D 
var SPI_GETMOUSECLICKLOCK = #101E 
var SPI_SETMOUSECLICKLOCK = #101F 
var SPI_GETMOUSEVANISH = #1020 
var SPI_SETMOUSEVANISH = #1021 
var SPI_GETFLATMENU = #1022 
var SPI_SETFLATMENU = #1023 
var SPI_GETDROPSHADOW = #1024 
var SPI_SETDROPSHADOW = #1025 
var SPI_GETBLOCKSENDINPUTRESETS = #1026 
var SPI_SETBLOCKSENDINPUTRESETS = #1027 
var SPI_GETUIEFFECTS = #103E 
var SPI_SETUIEFFECTS = #103F 
var SPI_GETDISABLEOVERLAPPEDCONTENT = #1040 
var SPI_SETDISABLEOVERLAPPEDCONTENT = #1041 
var SPI_GETCLIENTAREAANIMATION = #1042 
var SPI_SETCLIENTAREAANIMATION = #1043 
var SPI_GETCLEARTYPE = #1048 
var SPI_SETCLEARTYPE = #1049 
var SPI_GETSPEECHRECOGNITION = #104A 
var SPI_SETSPEECHRECOGNITION = #104B 
var SPI_GETFOREGROUNDLOCKTIMEOUT = #2000 
var SPI_SETFOREGROUNDLOCKTIMEOUT = #2001 
var SPI_GETACTIVEWNDTRKTIMEOUT = #2002 
var SPI_SETACTIVEWNDTRKTIMEOUT = #2003 
var SPI_GETFOREGROUNDFLASHCOUNT = #2004 
var SPI_SETFOREGROUNDFLASHCOUNT = #2005 
var SPI_GETCARETWIDTH = #2006 
var SPI_SETCARETWIDTH = #2007 
var SPI_GETMOUSECLICKLOCKTIME = #2008 
var SPI_SETMOUSECLICKLOCKTIME = #2009 
var SPI_GETFONTSMOOTHINGTYPE = #200A 
var SPI_SETFONTSMOOTHINGTYPE = #200B 
//constants for SPI_GETFONTSMOOTHINGTYPE and SPI_SETFONTSMOOTHINGTYPE: 
var FE_FONTSMOOTHINGSTANDARD = #0001 
var FE_FONTSMOOTHINGCLEARTYPE = #0002 
var SPI_GETFONTSMOOTHINGCONTRAST = #200C 
var SPI_SETFONTSMOOTHINGCONTRAST = #200D 
var SPI_GETFOCUSBORDERWIDTH = #200E 
var SPI_SETFOCUSBORDERWIDTH = #200F 
var SPI_GETFOCUSBORDERHEIGHT = #2010 
var SPI_SETFOCUSBORDERHEIGHT = #2011 
var SPI_GETFONTSMOOTHINGORIENTATION = #2012 
var SPI_SETFONTSMOOTHINGORIENTATION = #2013 
// constants for SPI_GETFONTSMOOTHINGORIENTATION and SPI_SETFONTSMOOTHINGORIENTATION: 
var FE_FONTSMOOTHINGORIENTATIONBGR = #0000 
var FE_FONTSMOOTHINGORIENTATIONRGB = #0001 
var SPI_GETMINIMUMHITRADIUS = #2014 
var SPI_SETMINIMUMHITRADIUS = #2015 
var SPI_GETMESSAGEDURATION = #2016 
var SPI_SETMESSAGEDURATION = #2017 
// SystemParametersInfo Flags 
var SPIF_UPDATEINIFILE = #0001 //将新系统设置写到用户配置文件中 
var SPIF_SENDWININICHANGE = #0002 //更新系统设置并向整个系统发送 WM_SETTINGCHANGE 消息 
var SPIF_SENDCHANGE       //SPIF_SENDWININICHANGE 
//SetComputerNameExW 
var ComputerNameNetBIOS = 0 
var ComputerNameDnsHostname = 1 
var ComputerNameDnsDomain = 2 
var ComputerNameDnsFullyQualified = 3 
var ComputerNamePhysicalNetBIOS = 4 
var ComputerNamePhysicalDnsHostname = 5 
var ComputerNamePhysicalDnsDomain = 6 
var ComputerNamePhysicalDnsFullyQualified = 7 
var ComputerNameMax = 8 
//////////////CreateFont/////////////// 
// Font Weights 
var FW_DONTCARE = 0 
var FW_THIN = 100 
var FW_EXTRALIGHT = 200 
var FW_LIGHT = 300 
var FW_NORMAL = 400 
var FW_MEDIUM = 500 
var FW_SEMIBOLD = 600 
var FW_BOLD = 700 
var FW_EXTRABOLD = 800 
var FW_HEAVY = 900 
var FW_ULTRALIGHT     // FW_EXTRALIGHT 
var FW_REGULAR        // FW_NORMAL 
var FW_DEMIBOLD       // FW_SEMIBOLD 
var FW_ULTRABOLD      // FW_EXTRABOLD 
var FW_BLACK          // FW_HEAVY 
//Font fdwCharSet 
var ANSI_CHARSET = 0 
var DEFAULT_CHARSET = 1 
var SYMBOL_CHARSET = 2 
var SHIFTJIS_CHARSET = 128 
var HANGEUL_CHARSET = 129 
var HANGUL_CHARSET = 129 
var GB2312_CHARSET = 134 
var CHINESEBIG5_CHARSET = 136 
var OEM_CHARSET = 255 
var JOHAB_CHARSET = 130 
var HEBREW_CHARSET = 177 
var ARABIC_CHARSET = 178 
var GREEK_CHARSET = 161 
var TURKISH_CHARSET = 162 
var VIETNAMESE_CHARSET = 163 
var THAI_CHARSET = 222 
var EASTEUROPE_CHARSET = 238 
var RUSSIAN_CHARSET = 204 
var MAC_CHARSET = 77 
var BALTIC_CHARSET = 186 
//Font fdwOutputPrecision 
var OUT_DEFAULT_PRECIS = 0 
var OUT_STRING_PRECIS = 1 
var OUT_CHARACTER_PRECIS = 2 
var OUT_STROKE_PRECIS = 3 
var OUT_TT_PRECIS = 4 
var OUT_DEVICE_PRECIS = 5 
var OUT_RASTER_PRECIS = 6 
var OUT_TT_ONLY_PRECIS = 7 
var OUT_OUTLINE_PRECIS = 8 
var OUT_SCREEN_OUTLINE_PRECIS = 9 
var OUT_PS_ONLY_PRECIS = 10 
//Font fdwClipPrecision 
var CLIP_DEFAULT_PRECIS = 0 
var CLIP_CHARACTER_PRECIS = 1 
var CLIP_STROKE_PRECIS = 2 
var CLIP_MASK = #f 
var CLIP_LH_ANGLES = 12 //(1<<4) 
var CLIP_TT_ALWAYS = 32 //(2<<4) 
var CLIP_DFA_DISABLE = 64 //(4<<4) 
var CLIP_EMBEDDED = 128 //(8<<4) 
//Font fdwQuality 
var DEFAULT_QUALITY = 0 
var DRAFT_QUALITY = 1 
var PROOF_QUALITY = 2 
var NONANTIALIASED_QUALITY = 3 
var ANTIALIASED_QUALITY = 4 
//Font fdwPitchAndFamily 
var DEFAULT_PITCH = 0 
var FIXED_PITCH = 1 
var VARIABLE_PITCH = 2 
var FF_DONTCARE = 0 //(0<<4) // Don't care or don't know. */ 
var FF_ROMAN = 16 //(1<<4) // Variable stroke width, serifed. */ 
// Times Roman, Century Schoolbook, etc. */ 
var FF_SWISS = 32 //(2<<4) // Variable stroke width, sans-serifed. */ 
// Helvetica, Swiss, etc. */ 
var FF_MODERN = 48 //(3<<4) // Constant stroke width, serifed or sans-serifed. */ 
// Pica, Elite, Courier, etc. */ 
var FF_SCRIPT = 64 //(4<<4) // Cursive, etc. */ 
var FF_DECORATIVE = 80 //(5<<4) // Old English, etc. */ 
//DrawText() Format Flags 可组合 
var DT_TOP = #00000000 
var DT_LEFT = #00000000 
var DT_CENTER = #00000001 
var DT_RIGHT = #00000002 
var DT_VCENTER = #00000004 
var DT_BOTTOM = #00000008 
var DT_WORDBREAK = #00000010 
var DT_SINGLELINE = #00000020 
var DT_EXPANDTABS = #00000040 
var DT_TABSTOP = #00000080 
var DT_NOCLIP = #00000100 
var DT_EXTERNALLEADING = #00000200 
var DT_CALCRECT = #00000400 
var DT_NOPREFIX = #00000800 
var DT_INTERNAL = #00001000 
var DT_EDITCONTROL = #00002000 
var DT_PATH_ELLIPSIS = #00004000 
var DT_END_ELLIPSIS = #00008000 
var DT_MODIFYSTRING = #00010000 
var DT_RTLREADING = #00020000 
var DT_WORD_ELLIPSIS = #00040000 
var DT_NOFULLWIDTHCHARBREAK = #00080000 
var DT_HIDEPREFIX = #00100000 
var DT_PREFIXONLY = #00200000 
var ETO_OPAQUE = #0002 
var ETO_CLIPPED = #0004 
var ETO_GLYPH_INDEX = #0010 
var ETO_RTLREADING = #0080 
var ETO_NUMERICSLOCAL = #0400 
var ETO_NUMERICSLATIN = #0800 
var ETO_IGNORELANGUAGE = #1000 
var ETO_PDY = #2000 
var ETO_REVERSE_INDEX_MAP = #10000 
// Text Alignment Options 
var TA_NOUPDATECP = 0 
var TA_UPDATECP = 1 
var TA_LEFT = 0 
var TA_RIGHT = 2 
var TA_CENTER = 6 
var TA_TOP = 0 
var TA_BOTTOM = 8 
var TA_BASELINE = 24 
var TA_RTLREADING = 256 
var VTA_BASELINE //TA_BASELINE 
var VTA_LEFT     //TA_BOTTOM 
var VTA_RIGHT    //TA_TOP 
var VTA_CENTER   //TA_CENTER 
var VTA_BOTTOM   //TA_RIGHT 
var VTA_TOP      //TA_LEFT 
// Background Modes 
var TRANSPARENT = 1 
var OPAQUE = 2 
var BKMODE_LAST = 2 
// Pen Styles 
var PS_SOLID = 0 
var PS_DASH = 1       // ------- */ 
var PS_DOT = 2       // ....... */ 
var PS_DASHDOT = 3       // _._._._ */ 
var PS_DASHDOTDOT = 4       // _.._.._ */ 
var PS_NULL = 5 
var PS_INSIDEFRAME = 6 
var PS_USERSTYLE = 7 
var PS_ALTERNATE = 8 
var PS_STYLE_MASK = #0000000F 
var PS_ENDCAP_ROUND = #00000000 
var PS_ENDCAP_SQUARE = #00000100 
var PS_ENDCAP_FLAT = #00000200 
var PS_ENDCAP_MASK = #00000F00 
var PS_JOIN_ROUND = #00000000 
var PS_JOIN_BEVEL = #00001000 
var PS_JOIN_MITER = #00002000 
var PS_JOIN_MASK = #0000F000 
var PS_COSMETIC = #00000000 
var PS_GEOMETRIC = #00010000 
var PS_TYPE_MASK = #000F0000 
// Brush Styles */ 
var BS_SOLID = 0 
var BS_NULL = 1 
var BS_HOLLOW         // = BS_NULL 
var BS_HATCHED = 2 
var BS_PATTERN = 3 
var BS_INDEXED = 4 
var BS_DIBPATTERN = 5 
var BS_DIBPATTERNPT = 6 
var BS_PATTERN8X8 = 7 
var BS_DIBPATTERN8X8 = 8 
var BS_MONOPATTERN = 9 
// Hatch Styles */ 
var HS_HORIZONTAL = 0       //水平线阴影 
var HS_VERTICAL = 1       //垂直线阴影 
var HS_FDIAGONAL = 2       //45o下斜线阴影（从右到左） 
var HS_BDIAGONAL = 3       //45o下斜线阴影（从左到右） 
var HS_CROSS = 4       //水平线和垂直线组成的交叉线阴影 
var HS_DIAGCROSS = 5       //45o交叉线组成的阴影 
function Win32ApiInit() 
    // Window Styles 
    WS_TILEDWINDOW = (WS_OVERLAPPED + WS_CAPTION + WS_SYSMENU + WS_THICKFRAME + WS_MINIMIZEBOX + WS_MAXIMIZEBOX) 
    WS_OVERLAPPEDWINDOW = (WS_OVERLAPPED + WS_CAPTION + WS_SYSMENU + WS_THICKFRAME + WS_MINIMIZEBOX + WS_MAXIMIZEBOX) 
    WS_POPUPWINDOW = (WS_POPUP + WS_BORDER + WS_SYSMENU) 
    // Extended Window Styles 
    WS_EX_OVERLAPPEDWINDOW = WS_EX_WINDOWEDGE + WS_EX_CLIENTEDGE 
    WS_EX_PALETTEWINDOW = WS_EX_WINDOWEDGE + WS_EX_TOOLWINDOW + WS_EX_TOPMOST 
    //SetWindowPos Flags 
    SWP_DRAWFRAME = SWP_FRAMECHANGED 
    SWP_NOREPOSITION = SWP_NOOWNERZORDER 
    //MessageBox flags 
    MB_ICONWARNING = MB_ICONEXCLAMATION 
    MB_ICONERROR = MB_ICONHAND 
    MB_ICONINFORMATION = MB_ICONASTERISK 
    MB_ICONSTOP = MB_ICONHAND 
    //FLASHWINFO结构体 dwFlags可组合 
    FLASHW_ALL = FLASHW_CAPTION + FLASHW_TRAY 
    //Object Definitions for EnumObjects() 
    GDI_OBJ_LAST = OBJ_COLORSPACE 
    // GetSystemMetrics() codes 
    SM_CXFIXEDFRAME = SM_CXDLGFRAME   
    SM_CYFIXEDFRAME = SM_CYDLGFRAME   
    SM_CXSIZEFRAME = SM_CXFRAME      
    SM_CYSIZEFRAME = SM_CYFRAME     
    //Parameter for SystemParametersInfo. 
    SPI_SCREENSAVERRUNNING = SPI_SETSCREENSAVERRUNNING     
    SPI_GETMENUUNDERLINES = SPI_GETKEYBOARDCUES 
    SPI_SETMENUUNDERLINES = SPI_SETKEYBOARDCUES 
    // SystemParametersInfo Flags 
    SPIF_SENDCHANGE = SPIF_SENDWININICHANGE 
    // Font Weights 
    FW_ULTRALIGHT = FW_EXTRALIGHT 
    FW_REGULAR = FW_NORMAL 
    FW_DEMIBOLD = FW_SEMIBOLD 
    FW_ULTRABOLD = FW_EXTRABOLD 
    FW_BLACK = FW_HEAVY 
    // Text Alignment Options 
    VTA_BASELINE = TA_BASELINE 
    VTA_LEFT = TA_BOTTOM 
    VTA_RIGHT = TA_TOP 
    VTA_CENTER = TA_CENTER 
    VTA_BOTTOM = TA_RIGHT 
    VTA_TOP = TA_LEFT 
    // Brush Styles */ 
    BS_HOLLOW = BS_NULL 
end
function GetLVITEMAStruc(num, text)
    var LVITEMAStruc = array()
    LVITEMAStruc["mask"] = array("int" = 0, "value" = LVIF_TEXT)
    LVITEMAStruc["iItem"] = array("int" = 0, "value" = num)
    LVITEMAStruc["iSubItem"] = array("int" = 0, "value" = 0)
    LVITEMAStruc["state"] = array("int" = 0, "value" = 0)
    LVITEMAStruc["stateMask"] = array("int" = 0, "value" = -1)
    LVITEMAStruc["pszText"] = array("int" = 0, "value" = text)
    LVITEMAStruc["cchTextMax"] = array("int" = 0, "value" = null)
    LVITEMAStruc["iImage"] = array("int" = 0, "value" = 0)
    LVITEMAStruc["lParam"] = array("int" = 0, "value" = 0)
    LVITEMAStruc["iIndent"] = array("int" = 0, "value" = 0)
    LVITEMAStruc["iGroupId"] = array("int" = 0, "value" = I_GROUPIDNONE)
    LVITEMAStruc["cColumns"] = array("int" = 0, "value" = 0)
    LVITEMAStruc["puColumns"] = array("int" = 0, "value" = 0)
    LVITEMAStruc["piColFmt"] = array("int" = 0, "value" = 0)
    LVITEMAStruc["iGroup"] = array("int" = 0, "value" = 0)
    var addr = structmalloc(LVITEMAStruc)
    return addr
end