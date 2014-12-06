//
//  AppDelegate.swift
//  EFIMAN
//
//  Created by Nattapong Pullkhow on 12/2/2557 BE.
//  Copyright (c) 2557 Nattapong Pullkhow. All rights reserved.
//

import Cocoa


class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet var SplashWindow : NSWindow
    @IBOutlet var window: NSWindow
    @IBAction func setCloseClick_(sender : AnyObject) {
        if(window.visible) {
            window.orderOut(window)
        } else if(InfoWindow.visible) {
            setQuit_(self)
        } else if (confirmWindow.visible) {
            confirmWindow.orderOut(confirmWindow)
            getStart(self)
        } else if (miniWin.visible || fullWin.visible) {
            setQuit_(self)
        }
    }
    
    @IBAction func AboutWindowClick_(sender : AnyObject) {
        if(!window.visible) {
            window.orderFront(window)
        }
    }
    
    
    //Mini Window
    @IBOutlet var miniWin : NSPanel
    @IBOutlet var firstTextminiWin : NSTextField
    @IBOutlet var firstPathTextMini : NSTextField
    @IBAction func firstBTNminiWin(sender : AnyObject) {
        //targetDisk = ["mediainfo": firstTextminiWin.stringValue,"devpath":firstPathTextMini.stringValue]
        setConfirmWin(0)
    }
    @IBOutlet var secondTextminiWin : NSTextField
    @IBOutlet var seconPathTextMini : NSTextField
    @IBAction func secondBTNminiWin(sender : AnyObject) {
        //targetDisk =  ["mediainfo": seconPathTextMini.stringValue,"devpath":seconPathTextMini.stringValue]
        setConfirmWin(1)
    }

    //Full Window
    
    @IBAction func setQuit_(sender : AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }


    @IBOutlet var fullWin : NSPanel
    @IBOutlet var firstTextFullWin : NSTextField
    @IBOutlet var firsPathTextFull : NSTextField
    @IBAction func firstBTNFullWin(sender : AnyObject) {
        //targetDisk = ["mediainfo": firstTextFullWin.stringValue,"devpath":firsPathTextFull.stringValue]
        setConfirmWin(0)
    }
    @IBOutlet var secondTextFullWin : NSTextField
    @IBOutlet var secondPathTextFull : NSTextField
    @IBAction func seconBTNFullWin(sender : AnyObject) {
        //targetDisk = ["mediainfo": secondTextFullWin.stringValue,"devpath":secondPathTextFull.stringValue]
        setConfirmWin(1)
    }
    @IBOutlet var thirdTextFullWin : NSTextField
    @IBOutlet var thirdPathTextFull : NSTextField
    @IBAction func thirdBTNFullWin(sender : AnyObject) {
        //targetDisk = ["mediainfo": thirdTextFullWin.stringValue,"devpath":thirdPathTextFull.stringValue]
        setConfirmWin(2)
    }
    
    @IBOutlet var leftArrowFullWin : NSButton
    @IBAction func leftArrowFullWinClick(sender : AnyObject) {
        startPoint = startPoint - 1
        showfullWinDiskIcon()
    }
    @IBOutlet var rightArrowFullWin : NSButton
    @IBAction func rightArrowFullWinClick(sender : AnyObject) {
        startPoint = startPoint + 1
        showfullWinDiskIcon()
    }
    
    
    @IBOutlet var confirmWindow : NSPanel
    @IBOutlet var ConfirmTitle : NSTextField
    @IBOutlet var ConfirmText : NSTextFieldCell
    @IBAction func ConfirmCancelClick_(sender : AnyObject) {
        if(confirmWindow.visible) {
            confirmWindow.orderOut(confirmWindow)
            if(EFIPartList.count > 1) {
                getStart(self)
            } else {
                setQuit_(self)
            }
        }
    }
    @IBAction func CounfirmMountClick(sender : AnyObject) {
        if(confirmWindow.visible) {
            confirmWindow.orderOut(confirmWindow)
            setMount()
        }
    }
    
    
    @IBOutlet var InfoWindow : NSPanel
    @IBOutlet var InfoTitle : NSTextField
    @IBOutlet var InfoText : NSTextField
    @IBAction func InfoCloseClick(sender : AnyObject) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    
    var startPoint:Int = 1
    var target_ = Int()
    //var targetDisk = Dictionary<String,String>()
    var EFIPartList = Array<Dictionary<String,String>>()
    func getStart(sender : AnyObject){
        if(SplashWindow.visible) {
            SplashWindow.orderOut(SplashWindow)
        }
        EFIPartList = listEFIPartiton()
        if(EFIPartList.count >= 3) {
            showFull()
            showfullWinDiskIcon()
        } else if (EFIPartList.count == 2 ) {
            showMini()
            showminiWinDiskIcon()
        } else if (EFIPartList.count == 1 && EFIPartList[0].count > 1) {
            setConfirmWin(0)
        } else if (EFIPartList.count == 1 && EFIPartList[0].count <= 1 ) {
            setInfoNoEFI()
        }
    }

    // Display icon
    func showminiWinDiskIcon() {
        var DiskList = EFIPartList
        firstTextminiWin.stringValue = DiskList[0]["mediainfo"]
        firstPathTextMini.stringValue = DiskList[0]["devpath"]
        secondTextminiWin.stringValue = DiskList[1]["mediainfo"]
        seconPathTextMini.stringValue = DiskList[1]["devpath"]
    }
    func showfullWinDiskIcon() {
        var DiskList = EFIPartList
        firstTextFullWin.stringValue = DiskList[startPoint - 1]["mediainfo"]
        firsPathTextFull.stringValue = DiskList[startPoint - 1]["devpath"]
        secondTextFullWin.stringValue = DiskList[startPoint]["mediainfo"]
        secondPathTextFull.stringValue = DiskList[startPoint]["devpath"]
        thirdTextFullWin.stringValue = DiskList[startPoint + 1]["mediainfo"]
        thirdPathTextFull.stringValue = DiskList[startPoint + 1]["devpath"]
        if(startPoint <= 1) {
            leftArrowFullWin.hidden = true
        } else {
            leftArrowFullWin.hidden = false
        }
        if(DiskList.count - (2 + startPoint) <= 0) {
            rightArrowFullWin.hidden = true
        } else {
            rightArrowFullWin.hidden = false
        }
    }
    // windows Func
    func showMini() {
        if(!miniWin.visible) {
            miniWin.orderFront(miniWin)
        }
    }
    func hideMini() {
        if(miniWin.visible) {
            miniWin.orderOut(miniWin)
        }
    }
    func showFull() {
        if(!fullWin.visible) {
            fullWin.orderFront(fullWin)
        }
    }
    func hideFull() {
        if(fullWin.visible) {
            fullWin.orderOut(fullWin)
        }
    }
    func setInfoError() {
        InfoTitle.stringValue = "Error,Operation Error!"
        InfoText.stringValue = "Operation failed.Please try agian leter."
        if(!InfoWindow.visible) {
            InfoWindow.orderFront(InfoWindow)
        }
    }
    func setInfoSuccess() {
        var _MountDisk:Dictionary<String,String> = EFIPartList[target_]
        var MediaInfo:String = _MountDisk["mediainfo"]!
        var DiskPart:String = _MountDisk["devpath"]!
        var EFIPath:String = _MountDisk["efipath"]!
        InfoTitle.stringValue = "Success, \(MediaInfo)"
        InfoText.stringValue = "Success,Mount \"\(DiskPart)\" to \"\(EFIPath)\""
        if(!InfoWindow.visible) {
            InfoWindow.orderFront(InfoWindow)
        }
    }
    func setInfoAlready() {
        var _MountDisk:Dictionary<String,String> = EFIPartList[target_]
        var MediaInfo:String = _MountDisk["mediainfo"]!
        var DiskPart:String = _MountDisk["devpath"]!
        var EFIPath:String = _MountDisk["efipath"]!
        InfoTitle.stringValue = "Infomation!, \(MediaInfo)"
        InfoText.stringValue = "The\"\(DiskPart)\" Alreay Mounted to \"\(EFIPath)\""
        if(!InfoWindow.visible) {
            InfoWindow.orderFront(InfoWindow)
        }
    }
    func setInfoNoEFI() {
        InfoTitle.stringValue = "Infomation!,No EFI not mount"
        InfoText.stringValue = "All your EFI Partitions Already Mounted or No have GUID (GPT) Disk in The Computer"
        if(!InfoWindow.visible) {
            InfoWindow.orderFront(InfoWindow)
        }
    }
    func setConfirmWin(TargetNumer:Int) {
        hideMini()
        hideFull()
        target_ = TargetNumer
        var _MountDisk:Dictionary<String,String> = EFIPartList[target_]
        var MediaInfo:String = _MountDisk["mediainfo"]!
        var DiskPart:String = _MountDisk["devpath"]!
        var EFIPath:String = setEFIVolumesPath()
        EFIPartList[target_]["efipath"] = "\(EFIPath)"
        if(!confirmWindow.visible) {
            confirmWindow.orderFront(confirmWindow)
        }
        ConfirmTitle.stringValue = "\(MediaInfo)"
        ConfirmText.stringValue = "Do you want to Mount \"\(DiskPart)\" to \"\(setEFIVolumesPath())\" ?"
    }
    
    func listEFIPartiton()->Array<Dictionary<String,String>> {
        var Task = NSTask()
        Task.launchPath = "/usr/sbin/diskutil"
        Task.arguments = ["list"]
        let _pipe = NSPipe()
        Task.standardOutput = _pipe
        Task.launch()
        let data = _pipe.fileHandleForReading.readDataToEndOfFile()
        let t = "\(NSString(data: data,encoding: NSUTF8StringEncoding))"
        let temp_:Array<String> = "\(NSString(data: data,encoding: NSUTF8StringEncoding))".componentsSeparatedByString("\n")
        var EFIList = Array<String>()
        for i in temp_ {
            if(i.rangeOfString("EFI") && i.rangeOfString("s1")) {
                EFIList += i.stringByReplacingOccurrencesOfString(" ", withString: "").stringByReplacingOccurrencesOfString("EFI", withString: "").stringByReplacingOccurrencesOfString("1:", withString: "").stringByReplacingOccurrencesOfString("209.7MB", withString: "")
            }
        }
        if(EFIList.count > 0) {
            var tmp_d = Array<Dictionary<String,String>>()
            for  i in EFIList {
                if(!isMountedDev(i)) {
                    tmp_d += ["devpath" : "/dev/\(i)","mediainfo" :"\(getDiskMediaInfo(i))"]
                }
            }
            if(tmp_d.count > 0) {
                return tmp_d
            } 
        }
        return [["":""]]
    }
    
    func isMountedDev(dev:String)->Bool{
        var Task = NSTask()
        Task.launchPath = "/usr/sbin/diskutil"
        Task.arguments = ["info","\(dev)"]
        let _pipe = NSPipe()
        Task.standardOutput = _pipe
        Task.launch()
        let data = _pipe.fileHandleForReading.readDataToEndOfFile()
        let tmp_:Array<String> = "\(NSString(data: data,encoding: NSUTF8StringEncoding))".componentsSeparatedByString("\n")
        for i in tmp_ {
            if(i.rangeOfString("Mounted:") && i.rangeOfString("Yes")) {
                return true
            }
        }
        return false
    }
    func setMount() {
        var _MountDisk:Dictionary<String,String> = EFIPartList[target_]
        var MediaInfo:String = _MountDisk["mediainfo"]!
        var DiskPart:String = _MountDisk["devpath"]!
        var EFIPath:String = _MountDisk["efipath"]!
        if(!isMountedPath(EFIPath) || !isMountedDev(DiskPart)) {
            var Task = NSTask()
            Task.launchPath = "/usr/bin/osascript"
            Task.arguments = [ "-e","try","-e","do shell script \"mount_msdos \(DiskPart) \(EFIPath);echo Done\" with administrator privileges","-e","on error","-e","set x to \"cancel\"","-e","end try" ]
            let _pipe = NSPipe()
            Task.standardOutput = _pipe
            Task.launch()
            let data = _pipe.fileHandleForReading.readDataToEndOfFile()
            let output: String = removeWhiteSpace(NSString(data: data,encoding: NSUTF8StringEncoding))
            if(output.rangeOfString("cancel")) {
                if(EFIPartList.count > 1) {
                    getStart(self)
                } else {
                    setQuit_(self)
                }
            }
            if((!output.rangeOfString("Done") || !isMountedDev(DiskPart)) && !output.rangeOfString("cancel")) {
                var Task = NSTask()
                Task.launchPath = "/usr/bin/osascript"
                Task.arguments = [ "-e","try","-e","do shell script \"mount_msdos \(DiskPart) \(EFIPath);echo Done\" with administrator privileges","-e","on error","-e","set x to \"cancel\"","-e","end try" ]
                let _pipe = NSPipe()
                Task.standardOutput = _pipe
                Task.launch()
                let data = _pipe.fileHandleForReading.readDataToEndOfFile()
                let output: String = removeWhiteSpace(NSString(data: data,encoding: NSUTF8StringEncoding))
                if(!output.rangeOfString("Done") || !isMountedDev(DiskPart)) {
                    setInfoError()
                } else if(output.rangeOfString("Done") && isMountedDev(DiskPart)) {
                    setInfoSuccess()
                    openEFIFinder(EFIPath)
                }
            } else {
                if(output.rangeOfString("Done") && isMountedPath(EFIPath) && isMountedDev(DiskPart)) {
                    setInfoSuccess()
                    openEFIFinder(EFIPath)
                }
            }
        } else {
            setInfoAlready()
        }
    }
    
    func openEFIFinder(EFIPath:String) {
        var Task = NSTask()
        Task.launchPath = "/usr/bin/osascript"
        Task.arguments = [ "-e","do shell script \"open \(EFIPath) \""]
        Task.launch()
    }
    func isMountedPath(path:String)->Bool{
        var Task = NSTask()
        Task.launchPath = "/sbin/mount"
        let _pipe = NSPipe()
        Task.standardOutput = _pipe
        Task.launch()
        let data = _pipe.fileHandleForReading.readDataToEndOfFile()
        let y = "\(NSString(data: data,encoding: NSUTF8StringEncoding))"
        let x:Array<String> = y.componentsSeparatedByString("\n")
        for i in x {
            if(i.rangeOfString("\(path) ")) {
                return true
            }
        }
        return false
    }
    func setEFIVolumesPath()->String{
        var efiPath = String()
        var FManager = NSFileManager.defaultManager()
        for var i = 0; i <= 15;++i {
            if(i == 0) {
                efiPath = "/Volumes/EFI"
            } else {
                efiPath = "/Volumes/EFI\(i)"
            }
            if(!isMountedPath(efiPath)) {
                if(!FManager.fileExistsAtPath( efiPath )) {
                    FManager.createDirectoryAtPath(efiPath, attributes: nil)
                    return efiPath
                } else {
                    FManager.removeFileAtPath( efiPath, handler: nil)
                    FManager.createDirectoryAtPath(efiPath, attributes: nil)
                    return efiPath
                }
            }
        }

        return ""
    }
    func getDiskMediaInfo(dev:String)->String{
        var device = dev
        if(dev.rangeOfString("s1")) {
         device = dev.stringByReplacingOccurrencesOfString("s1", withString: "")
        }
        var Task = NSTask()
        Task.launchPath = "/usr/sbin/diskutil"
        Task.arguments = ["info", "\(device)"]
        let _pipe = NSPipe()
        Task.standardOutput = _pipe
        Task.launch()
        let data = _pipe.fileHandleForReading.readDataToEndOfFile()
        let temp_:Array<String> = "\(NSString(data: data,encoding: NSUTF8StringEncoding))".componentsSeparatedByString("\n")
        for i in temp_ {
            if(i.rangeOfString("Device / Media Name: ")) {
                return i.stringByReplacingOccurrencesOfString("Device / Media Name: ", withString: "").stringByReplacingOccurrencesOfString(" Media", withString: "").stringByReplacingOccurrencesOfString("        ", withString: "")
            }
        }
        return ""
    }

    
    func removeWhiteSpace(string:String)->String {
        let text = string.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter({!$0.isEmpty})
        return " ".join(text)
    }
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        var getStartTimer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "getStart:", userInfo: nil, repeats: false)
        //println(NSBundle.mainBundle().bundlePath)
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }
}

