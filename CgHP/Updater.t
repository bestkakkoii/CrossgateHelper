//資源擋自動更新面板
function Updater_init()
    regdll(getrcpath("rc:FTP.dll"), false)
    SetWindowLongA(controlgetchildhwnd("Updater"), 128, 1)
    SetWindowLongA(controlgethandle("gridupdate", "Updater"), GetWindowLongA(controlgethandle("gridupdate", "Updater")) - WS_BORDER)
    var title = array("尋路地圖", "腳本", "其他資源")
    for(var i = 0; i < 3; i++)
        gridsetcontent("gridupdate", i + 1, 0, title[i], "Updater")
        var hwnd = controlgethandle("progress" & i, "Updater")
        windowsendmessage(hwnd, #2001, 0, #FFFFFF)
        windowsendmessage(hwnd, #409, 0, #8080FF)
    end
    windowactivate(controlgetchildhwnd("Updater"))
    threadbegin("DownloadFile", null)
end
var downloadflag = false
var updateflag = false
function DownloadFile()
    regdll(getrcpath("rc:FTP.dll"), true)
    if(isregister("Easy.Outstanding.1"))
        FTP = com("Easy.Outstanding.1")
        var handle = FTP.FtpSignal(AESdecrypt("4cf6422706fa4eb6ba711a4e46813504"), AESdecrypt("c27c68d75056476d0e215a0202f8b02d"), AESdecrypt("b049df7efeba5d18c768deeae8367904"), 21, 0)
        if(handle != 0)
            FTP.FtpServerPath(handle)
            if(updateflag)
                //
                var MapIndex = sysgetpath(5)
                if(!fileexist(MapIndex & "CgHP"))
                    foldercreate(MapIndex & "CgHP")
                end
                //
                downloadflag = false
                threadbegin("DownloadTimer", 0)
                FTP.FtpDownload(handle, "domains/lovesa.cc/public_html/updates/MapFile.zip", "./updatepack0.zip")
                if(!fileexist(MapIndex & "CgHP\\Map"))
                    foldercreate(MapIndex & "CgHP\\Map")
                end
                traceprint(MapIndex & "CgHP\\Map")
                folder_unzip("./updatepack0.zip", MapIndex & "CgHP\\Map")
                sleep(10000, false)
                filedelete("./updatepack0.zip")
                downloadflag = true
                sleep(1000, false)
                downloadflag = false
                threadbegin("DownloadTimer", 1)
                FTP.FtpDownload(handle, "domains/lovesa.cc/public_html/updates/Resource.zip", "./updatepack1.zip")
                if(!fileexist("./Resource"))
                    foldercreate("./Resource")
                end
                folder_unzip("./updatepack1.zip", "./Resource")
                sleep(100, false)
                filedelete("./updatepack1.zip")
                downloadflag = true
                sleep(1000, false)
                //
                downloadflag = false
                threadbegin("DownloadTimer", 2)
                FTP.FtpDownload(handle, "domains/lovesa.cc/public_html/updates/Script.zip", "./updatepack2.zip")
                if(!fileexist("./Script"))
                    foldercreate("./Script")
                end
                folder_unzip("./updatepack2.zip", "./Script")
                sleep(100, false)
                filedelete("./updatepack2.zip")
                FTP.FtpDownload(handle, "domains/lovesa.cc/public_html/updates/resourcefile.zip", rc & "updatepack3.zip")
                folder_unzip(rc & "updatepack3.zip", rc)
                sleep(100, false)
                filedelete(rc & "updatepack3.zip")
                //
                downloadflag = true
                sleep(1000, false)
                var content = httpgetpage("https://www.lovesa.cc/updates/version.txt", "utf-8")
                filewriteini("CgHP", "version", content, ".\\Resource\\System.ini")
            end
            FTP.FtpSignalClose(handle)
        end
    end
    controlclosewindow("Updater", 0)
end
function DownloadTimer(num)
    var i = 0
    while(!downloadflag)
        progresssetprogress("progress" & num, i, "Updater")
        i = i + 2
        sleep(100, false)
    end
    progresssetprogress("progress" & num, 100, "Updater")
    return false
end
//点击关闭_执行操作
function Updater_close()
    sleep(100, false)
    TerminateProcess(GetCurrentProcess())
end
function folder_unzip(path, tarpath = "") //gz pack
    var SetTarPath = ""
    if(strlen(tarpath) > 0) //若不指定解包后路径,则依原包路数还原文件
        SetTarPath = " --directory " & tarpath & ""
    end
    var ret = cmd("tar -x -z -v -f " & path & SetTarPath, true)
end