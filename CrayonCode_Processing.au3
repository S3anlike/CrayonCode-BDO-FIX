#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ico\earth.ico
#AutoIt3Wrapper_Outfile=ico\vlad.Exe
#AutoIt3Wrapper_Outfile_x64=ico\vlod.Exe
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ico\earth.ico
#AutoIt3Wrapper_Outfile=ico\vlad_relogfix.Exe
#AutoIt3Wrapper_Outfile_x64=ico\vlod.Exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ico\earth.ico
#AutoIt3Wrapper_Outfile=ico\vlad_s.Exe
#AutoIt3Wrapper_Outfile_x64=ico\vlod_s.Exe
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ico\earth.ico
#AutoIt3Wrapper_Outfile=ico\vlad.Exe
#AutoIt3Wrapper_Outfile_x64=ico\vlod.Exe
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ico\earth.ico
#AutoIt3Wrapper_Outfile=ico\vlad.Exe
#AutoIt3Wrapper_Outfile_x64=ico\vlod.Exe
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ico\earth.ico
#AutoIt3Wrapper_Outfile=ico\vlad.Exe
#AutoIt3Wrapper_Outfile_x64=ico\vlod.Exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ico\earth.ico
#AutoIt3Wrapper_Outfile=ico\vlad.Exe
#AutoIt3Wrapper_Outfile_x64=ico\vlod.Exe
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ico\earth.ico
#AutoIt3Wrapper_Outfile=ico\vlad.Exe
#AutoIt3Wrapper_Outfile_x64=ico\vlod.Exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.14.2
	Author:         CrayonCode
	Version:		 Alpha 0.21
	Contact:		 http://www.elitepvpers.com/forum/black-desert/4268940-autoit-crayoncode-bot-project-opensource-free.html

#ce ----------------------------------------------------------------------------

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y  ;required for ImageSearch.au3
#AutoIt3Wrapper_UseX64=y  ;required for ImageSearch.au3
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#RequireAdmin
#include "ImageSearch.au3"
#include "FastFind.au3"
#include <File.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <ListViewConstants.au3>
#include <GuiListView.au3>
#include <WinAPI.au3>
#include <Array.au3>
#include <GuiEdit.au3>

#Region - Autoupdate

Global $VersionsInfo = "https://raw.githubusercontent.com/davidgao93/CrayonCode-BDO-Project/master/config/version.ini"
Global $ChangelogLink = "https://raw.githubusercontent.com/davidgao93/CrayonCode-BDO-Project/master/config/changelog.txt"
Global $oldVersion = IniRead("config\updater.ini","Version","PVersion","NotFound")
Global $newVersion = "0.0"

$Ini = InetGet($VersionsInfo,@ScriptDir & "\config\version.ini") ;download version.ini
$Changelog = InetGet($ChangelogLink, @ScriptDir & "\config\changelog.txt") ;download changelog.txt

If $Changelog = 0 Then
	MsgBox(0, "ERROR", "Unable to fetch changelog from Github, are you connected to the network? Attempting to check for version...")
EndIf

If $Ini = 0 Then ;was the download of version.ini successful?
    MsgBox(0,"ERROR","Unable to fetch from Github - maybe it's down?")
Else
    $newVersion = IniRead (@ScriptDir & "\config\version.ini","Version","PVersion","") ;reads the new version out of version.ini
    If $NewVersion = $oldVersion Then ;compare old and new
        ;MsgBox (0,"Autoupdate","You're running version " & $NewVersion)
    Else
        $msg = MsgBox (4,"Autoupdate","Update available, revision: " & $newVersion & ". You are currently on revision: " & $oldVersion & ". Do you want to update?")
        If $msg = 7 Then ;No was pressed
            ;FileDelete(@ScriptDir & "\config\version.ini")
            ;Exit
        ElseIf $msg = 6 Then ;OK was pressed
            $downloadLink = IniRead(@ScriptDir & "\config\version.ini","Version","Pdownload","NotFound")
            $dlhandle = InetGet($downloadLink,@ScriptDir & "\CrayonCode_Processing" & $newVersion & ".au3",1,1)
            ProgressOn("", "", "",-1,-1,16) ;creates an progressbar
            $Size = InetGetSize($downloadLink,1) ;get the size of the update
            While Not InetGetInfo($dlhandle, 2)
                $Percent = (InetGetInfo($dlhandle,0)/$Size)*100
                ProgressSet( $Percent, $Percent & " percent");update progressbar
                Sleep(1)
            WEnd
            ProgressSet(100 , "Done", "Complete");show complete progressbar
            sleep(500)
            ProgressOff() ;close progress window
            IniWrite("config\updater.ini","Version","PVersion",$NewVersion) ;updates update.ini with the new version
            InetClose($dlhandle)
            $File1 =  (@ScriptDir & "\config\changelog.txt")
			MsgBox(-1, "Autoupdate", FileRead($File1, FileGetSize($File1)))
			;FileDelete(@ScriptDir & "\version.ini")
			_terminate()
            EndIf
    EndIf
EndIf
;FileDelete(@ScriptDir & "\version.ini")
#EndRegion - Autoupdate

#Region - Global
OnAutoItExitRegister(_ImageSearchShutdown)
OnAutoItExitRegister(CloseLog)
Opt("MouseClickDownDelay", 100+random(1,20,1))
Opt("MouseClickDelay", 50+random(1,10,1))
Opt("SendKeyDelay", 50+random(1,10,1))
Global $hBDO = "BLACK DESERT -"
Global $Processing = False
Global $LogFile = ""
;Global $LogFileEnable = 1
Global $LastGUIStatus
Global $ResOffset[4] = [0, 0, 0, 0]
Global $Days[7] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
Global $Customs[14][8]
Global $CustomsValues[14][8]
Global $DefaultBatchSize = 100
Global $MaxLogCharsInLogwindow = 2000
Global $MinProcessTime = 20
Global $WorkerFeedingTime = 30
Global $Buff1Enable = True, $Buff2Enable = True, $BuffCD1 = 30, $BuffCD2 = 90
Global $BuffKey1 = 7, $BuffKey2 = 8
Global $AlchemyStoneEnable = 1
Global $TestingMode = False
Global $HorseLoading = False
Global $Res[4] = [0, 0, @DesktopWidth, @DesktopHeight]

Global $newtitle = ""

HotKeySet("^{F1}", "_terminate")
HotKeySet("^{F2}", "Save")
HotKeySet("^{F3}", "PauseToggle")
HotKeySet("^{F4}", "ProcessCustom")
HotKeySet("^{F5}", "ProcessSimple")
HotKeySet("^{F6}", "WorkerFeed")
HotKeySet("^{F7}", "LoadHorse")
HotKeySet("^{F8}", "ProductionActivityCheck")
HotKeySet("^{F9}", "CleadLogWindow")
#EndRegion - Global


#Region ### START Koda GUI section ### Form=c:\program files (x86)\autoit3\scite\koda\forms\processing.kxf
$Form1 = GUICreate("CrayonCode Processing", 615, 450, 196, 143)
$Tab1 = GUICtrlCreateTab(0, 0, 614, 400)
$TabSheet1 = GUICtrlCreateTabItem("Simple Processing")
$MAterial_Settings = GUICtrlCreateGroup("Material Settings", 8, 30, 596, 300)
$lumber_category = GUICtrlCreateCheckbox("Lumber", 45, 50, 97, 18)
$lumber_acacia = GUICtrlCreateCheckbox("Acacia", 59, 72, 97, 18)
$lumber_ash = GUICtrlCreateCheckbox("Ash", 59, 89, 97, 18)
$lumber_birch = GUICtrlCreateCheckbox("Birch", 59, 107, 97, 18)
$lumber_cedar = GUICtrlCreateCheckbox("Cedar", 59, 125, 97, 18)
$lumber_eldertree = GUICtrlCreateCheckbox("Elder Tree", 59, 143, 97, 18)
$lumber_fir = GUICtrlCreateCheckbox("Fir", 59, 161, 97, 18)
$lumber_maple = GUICtrlCreateCheckbox("Maple", 59, 179, 97, 18)
$lumber_palm = GUICtrlCreateCheckbox("Palm", 59, 198, 97, 18)
$lumber_pine = GUICtrlCreateCheckbox("Pine", 59, 216, 97, 18)
$lumber_whitecedar = GUICtrlCreateCheckbox("White Cedar", 59, 234, 97, 18)
;-----
$plank_category = GUICtrlCreateCheckbox("Plank", 171, 50, 97, 18)
$plank_acacia = GUICtrlCreateCheckbox("Acacia", 195, 72, 97, 18)
$plank_ash = GUICtrlCreateCheckbox("Ash", 195, 89, 97, 18)
$plank_birch = GUICtrlCreateCheckbox("Birch", 195, 107, 97, 18)
$plank_cedar = GUICtrlCreateCheckbox("Cedar", 195, 125, 97, 18)
$plank_eldertree = GUICtrlCreateCheckbox("Elder Tree", 195, 143, 97, 18)
$plank_fir = GUICtrlCreateCheckbox("Fir", 195, 161, 97, 18)
$plank_maple = GUICtrlCreateCheckbox("Maple", 195, 179, 97, 18)
$plank_palm = GUICtrlCreateCheckbox("Palm", 195, 198, 97, 18)
$plank_pine = GUICtrlCreateCheckbox("Pine", 195, 216, 97, 18)
$plank_whitecedar = GUICtrlCreateCheckbox("White Cedar", 195, 234, 97, 18)
;-----
$ore_category = GUICtrlCreateCheckbox("Ore", 307, 50, 97, 18)
$ore_copper = GUICtrlCreateCheckbox("Copper", 331, 72, 97, 18)
$ore_gold = GUICtrlCreateCheckbox("Gold", 331, 89, 97, 18)
$ore_iron = GUICtrlCreateCheckbox("Iron", 331, 107, 97, 18)
$ore_lead = GUICtrlCreateCheckbox("Lead", 331, 125, 97, 18)
$ore_mythril = GUICtrlCreateCheckbox("Mythril", 331, 143, 97, 18)
$ore_platinum = GUICtrlCreateCheckbox("Platinum", 331, 161, 97, 18)
$ore_silver = GUICtrlCreateCheckbox("Silver", 331, 179, 97, 18)
$ore_tin = GUICtrlCreateCheckbox("Tin", 331, 198, 97, 18)
$ore_titanium = GUICtrlCreateCheckbox("Titanium", 331, 216, 97, 18)
$ore_vanadium = GUICtrlCreateCheckbox("Vanadium", 331, 234, 97, 18)
$ore_zinc = GUICtrlCreateCheckbox("Zinc", 331, 252, 97, 18)
$ore_coal = GUICtrlCreateCheckbox("Coal", 331, 270, 97, 18)
;-----
$meltedshard_category = GUICtrlCreateCheckbox("Melted Shard", 443, 50, 97, 18)
$meltedshard_copper = GUICtrlCreateCheckbox("Copper", 467, 72, 97, 18)
$meltedshard_gold = GUICtrlCreateCheckbox("Gold", 467, 89, 97, 18)
$meltedshard_iron = GUICtrlCreateCheckbox("Iron", 467, 107, 97, 18)
$meltedshard_lead = GUICtrlCreateCheckbox("Lead", 467, 125, 97, 18)
$meltedshard_mythril = GUICtrlCreateCheckbox("Mythril", 467, 143, 97, 18)
$meltedshard_platinum = GUICtrlCreateCheckbox("Platinum", 467, 161, 97, 18)
$meltedshard_silver = GUICtrlCreateCheckbox("Silver", 467, 179, 97, 18)
$meltedshard_tin = GUICtrlCreateCheckbox("Tin", 467, 198, 97, 18)
$meltedshard_titanium = GUICtrlCreateCheckbox("Titanium", 467, 216, 97, 18)
$meltedshard_vanadium = GUICtrlCreateCheckbox("Vanadium", 467, 234, 97, 18)
$meltedshard_zinc = GUICtrlCreateCheckbox("Zinc", 467, 252, 97, 18)

$TabSheet2 = GUICtrlCreateTabItem("Custom Processing")
CreateCustoms()
$Label1 = GUICtrlCreateLabel("Method", 16, 32, 45, 17)
$Label2 = GUICtrlCreateLabel("Ingredient 1", 115, 32, 70, 17)
$Label3 = GUICtrlCreateLabel("Batch", 240, 32, 35, 17)
$Label5 = GUICtrlCreateLabel("Ingredient 2", 365, 32, 70, 17)
$Label6 = GUICtrlCreateLabel("Batch", 488, 32, 35, 17)
$Label4 = GUICtrlCreateLabel("Max", 288, 32, 30, 17)
$Label7 = GUICtrlCreateLabel("Max", 536, 32, 30, 17)
$TabSheet4 = GUICtrlCreateTabItem("Control Panel")
GUICtrlSetState(-1,$GUI_SHOW)

$ELog = GUICtrlCreateEdit("", 5, 155, 600, 230, BitOR($GUI_SS_DEFAULT_EDIT,$ES_READONLY))
GUICtrlSetData(-1, "")
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
$Processing_Settings = GUICtrlCreateGroup("Processing Settings - [STEALTH Edition]", 8, 35, 594, 95)
$I_DefaultBatchSize = GUICtrlCreateInput("", 139, 60, 55, 24)
GUICtrlSetTip(-1, "Items taken from storage. Customize depending on your LT")
$Label8 = GUICtrlCreateLabel("Default Batch Size:", 19, 62, 120, 17)
GUICtrlSetTip(-1, "Items taken from storage. Customize depending on your LT")
$I_MinProcessTime = GUICtrlCreateInput("", 139, 90, 55, 24)
GUICtrlSetTip(-1, "Minimum seconds to wait before checking if actually processing")
$Label9 = GUICtrlCreateLabel("Delay in seconds:", 19, 92, 125, 17)
GUICtrlSetTip(-1, "Minimum seconds to wait before checking if actually processing")
$Label10 = GUICtrlCreateLabel("Buff 1 key:", 240, 62, 68, 17)
$CBuffkey1 = GUICtrlCreateCombo("", 306, 62, 35, 25, BitOR($GUI_SS_DEFAULT_COMBO,$CBS_SIMPLE))
GUICtrlSetData(-1, "")
$Label11 = GUICtrlCreateLabel("delay:", 348, 62, 67, 17)
$I_BuffCD1 = GUICtrlCreateInput("", 390, 62, 30, 24)
GUICtrlSetTip(-1, "Time in Minutes. Set 0 to Deactivate.")
$Label12 = GUICtrlCreateLabel("Buff 2 key:", 240, 92, 68, 17)
$CBuffkey2 = GUICtrlCreateCombo("", 306, 92, 35, 25, BitOR($GUI_SS_DEFAULT_COMBO,$CBS_SIMPLE))
GUICtrlSetData(-1, "")
$Label13 = GUICtrlCreateLabel("delay:", 348, 92, 67, 17)
$I_BuffCD2 = GUICtrlCreateInput("", 390, 92, 30, 24)
GUICtrlSetTip(-1, "Time in Minutes. Set 0 to Deactivate.")
$CB_AlchemyStone = GUICtrlCreateCheckbox("Worker Feed", 470, 62, 120, 18)
$CB_LogFile = GUICtrlCreateCheckbox("Log File to Disk", 470, 92, 120, 18)
;$Label14 = GUICtrlCreateLabel("Will feed every 1h", 176, 288, 146, 17)
$jumpi=" "
$Label14 = GUICtrlCreateLabel("Live Logs (Ctrl+F9 to Clear)", 8, 140, 179, 20)

GUICtrlCreateTabItem("")
$BQuit = GUICtrlCreateButton("Quit" & @CRLF & "(Ctrl+F1)", 8, 404, 80, 41, $BS_MULTILINE)
$BSave = GUICtrlCreateButton("Save" & @CRLF & "(Ctrl+F2)", 91, 404, 80, 41, $BS_MULTILINE)
$BPause = GUICtrlCreateButton("Un/Pause" & @CRLF & "(Ctrl+F3)", 174, 404, 80, 41, $BS_MULTILINE)
$BCustom = GUICtrlCreateButton("Custom" & @CRLF & "(Ctrl+F4)", 257, 404, 80, 41, $BS_MULTILINE)
$BSimple = GUICtrlCreateButton("Simple" & @CRLF & "(Ctrl+F5)", 340, 404, 80, 41, $BS_MULTILINE)
$BWorkerTest = GUICtrlCreateButton("Test Workers" & @CRLF & "(Ctrl+F6)", 423, 404, 100, 41, $BS_MULTILINE)
$BBuffsTest = GUICtrlCreateButton("Load Horse" & @CRLF & "(Ctrl+F7)", 526, 404, 80, 41, $BS_MULTILINE)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Func StoreGUI()
	; Global Settings
	IniWrite("config/processing.ini", "Global", "DefaultBatchSize", GUICtrlRead($I_DefaultBatchSize))
	IniWrite("config/processing.ini", "Global", "MinProcessTime", GUICtrlRead($I_MinProcessTime))
	;IniWrite("config/processing.ini", "Global", "LogFileEnable", cbt($CB_LogFile))
	IniWrite("config/processing.ini", "Global", "AlchemyStoneEnable", cbt($CB_AlchemyStone))

	; Buff Settings
	IniWrite("config/processing.ini", "Buff", "BuffCD1", GUICtrlRead($I_BuffCD1))
	IniWrite("config/processing.ini", "Buff", "BuffCD2", GUICtrlRead($I_BuffCD2))
	IniWrite("config/processing.ini", "Buff", "BuffKey1", GUICtrlRead($CBuffkey1))
	IniWrite("config/processing.ini", "Buff", "BuffKey2", GUICtrlRead($CBuffkey2))

	; Lumber
	IniWrite("config/processing.ini", "lumber", "lumber_category", cbt($lumber_category))
	IniWrite("config/processing.ini", "lumber", "lumber_acacia", cbt($lumber_acacia))
	IniWrite("config/processing.ini", "lumber", "lumber_ash", cbt($lumber_ash))
	IniWrite("config/processing.ini", "lumber", "lumber_birch", cbt($lumber_birch))
	IniWrite("config/processing.ini", "lumber", "lumber_cedar", cbt($lumber_cedar))
	IniWrite("config/processing.ini", "lumber", "lumber_eldertree", cbt($lumber_eldertree))
	IniWrite("config/processing.ini", "lumber", "lumber_fir", cbt($lumber_fir))
	IniWrite("config/processing.ini", "lumber", "lumber_maple", cbt($lumber_maple))
	IniWrite("config/processing.ini", "lumber", "lumber_palm", cbt($lumber_palm))
	IniWrite("config/processing.ini", "lumber", "lumber_pine", cbt($lumber_pine))
	IniWrite("config/processing.ini", "lumber", "lumber_whitecedar", cbt($lumber_whitecedar))

	; Plank
	IniWrite("config/processing.ini", "plank", "plank_category", cbt($plank_category))
	IniWrite("config/processing.ini", "plank", "plank_acacia", cbt($plank_acacia))
	IniWrite("config/processing.ini", "plank", "plank_ash", cbt($plank_ash))
	IniWrite("config/processing.ini", "plank", "plank_birch", cbt($plank_birch))
	IniWrite("config/processing.ini", "plank", "plank_cedar", cbt($plank_cedar))
	IniWrite("config/processing.ini", "plank", "plank_eldertree", cbt($plank_eldertree))
	IniWrite("config/processing.ini", "plank", "plank_fir", cbt($plank_fir))
	IniWrite("config/processing.ini", "plank", "plank_maple", cbt($plank_maple))
	IniWrite("config/processing.ini", "plank", "plank_palm", cbt($plank_palm))
	IniWrite("config/processing.ini", "plank", "plank_pine", cbt($plank_pine))
	IniWrite("config/processing.ini", "plank", "plank_whitecedar", cbt($plank_whitecedar))

	; Ore
	IniWrite("config/processing.ini", "ore", "ore_category", cbt($ore_category))
	IniWrite("config/processing.ini", "ore", "ore_copper", cbt($ore_copper))
	IniWrite("config/processing.ini", "ore", "ore_gold", cbt($ore_gold))
	IniWrite("config/processing.ini", "ore", "ore_iron", cbt($ore_iron))
	IniWrite("config/processing.ini", "ore", "ore_lead", cbt($ore_lead))
	IniWrite("config/processing.ini", "ore", "ore_mythril", cbt($ore_mythril))
	IniWrite("config/processing.ini", "ore", "ore_platinum", cbt($ore_platinum))
	IniWrite("config/processing.ini", "ore", "ore_silver", cbt($ore_silver))
	IniWrite("config/processing.ini", "ore", "ore_tin", cbt($ore_tin))
	IniWrite("config/processing.ini", "ore", "ore_titanium", cbt($ore_titanium))
	IniWrite("config/processing.ini", "ore", "ore_vanadium", cbt($ore_vanadium))
	IniWrite("config/processing.ini", "ore", "ore_zinc", cbt($ore_zinc))
	IniWrite("config/processing.ini", "ore", "ore_coal", cbt($ore_coal))

	; MeltedShard
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_category", cbt($meltedshard_category))
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_copper", cbt($meltedshard_copper))
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_gold", cbt($meltedshard_gold))
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_iron", cbt($meltedshard_iron))
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_lead", cbt($meltedshard_lead))
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_mythril", cbt($meltedshard_mythril))
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_platinum", cbt($meltedshard_platinum))
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_silver", cbt($meltedshard_silver))
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_tin", cbt($meltedshard_tin))
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_titanium", cbt($meltedshard_titanium))
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_vanadium", cbt($meltedshard_vanadium))
	IniWrite("config/processing.ini", "meltedshard", "meltedshard_zinc", cbt($meltedshard_zinc))


	For $i = 0 To UBound($Customs) - 1
		For $j = 0 To UBound($CustomsValues, 2) - 2
			$CustomsValues[$i][$j] = GUICtrlRead($Customs[$i][$j])
		Next
	Next
	_FileWriteFromArray("config/processing_custom.txt", $CustomsValues)


	InitGUI()
EndFunc   ;==>StoreGUI

Func InitGUI()
	SetGUIStatus(StringFormat("Initializing..."))
	; Global Settings
	$DefaultBatchSize = IniRead("config/processing.ini", "Global", "DefaultBatchSize", $DefaultBatchSize)
	GUICtrlSetData($I_DefaultBatchSize, $DefaultBatchSize)
	$MinProcessTime = IniRead("config/processing.ini", "Global", "MinProcessTime", $MinProcessTime)
	GUICtrlSetData($I_MinProcessTime, $MinProcessTime + Random (0, 5, 1))
	;$LogFileEnable =  cbt(IniRead("config/processing.ini", "Global", "LogFileEnable", $LogFileEnable))
	;GUICtrlSetState($CB_LogFile, $LogFileEnable)
	$AlchemyStoneEnable =  cbt(IniRead("config/processing.ini", "Global", "AlchemyStoneEnable", $AlchemyStoneEnable))
	GUICtrlSetState($CB_AlchemyStone, $AlchemyStoneEnable)

	; Buff Settings
	$BuffCD1 = IniRead("config/processing.ini", "Buff", "BuffCD1", $BuffCD1)
	GUICtrlSetData($I_BuffCD1, $BuffCD1)
	$BuffCD2 = IniRead("config/processing.ini", "Buff", "BuffCD2", $BuffCD2)
	GUICtrlSetData($I_BuffCD2, $BuffCD2)
	$BuffKey1 = IniRead("config/processing.ini", "Buff", "BuffKey1", $BuffKey1)
	GUICtrlSetData($CBuffKey1, "1|2|3|4|5|6|7|8|9|0", $BuffKey1)
	$BuffKey2 = IniRead("config/processing.ini", "Buff", "BuffKey2", $BuffKey2)
	GUICtrlSetData($CBuffKey2, "1|2|3|4|5|6|7|8|9|0", $BuffKey2)

	If ($BuffCD1 = 0 And $BuffCD2 = 0) Then
		$Buff1Enable = False
		$Buff2Enable = False
		SetGUIStatus(StringFormat("Buff timers are 0, will not attempt to use buffs"))
	Else
		SetGUIStatus(StringFormat("Buff(s) are enabled"))
		If Not ($BuffCD1 = 0) Then
		SetGUIStatus(StringFormat("Buff1 key: " & $BuffKey1 & " with delay of " & $BuffCD1 & " minutes."))
		Else
		SetGUIStatus(StringFormat("Buff1 Disabled"))
		$Buff1Enable = False
		EndIf
		If Not ($BuffCD2 = 0) Then
		SetGUIStatus(StringFormat("Buff2 key: " & $BuffKey2 & " with delay of " & $BuffCD2 & " minutes."))
		Else
		SetGUIStatus(StringFormat("Buff2 Disabled"))
		$Buff2Enable = False
		EndIf
	EndIf

	; Lumber
	GUICtrlSetState($lumber_category, cbt(IniRead("config/processing.ini", "lumber", "lumber_category", 0)))
	GUICtrlSetState($lumber_acacia, cbt(IniRead("config/processing.ini", "lumber", "lumber_acacia", 0)))
	GUICtrlSetState($lumber_ash, cbt(IniRead("config/processing.ini", "lumber", "lumber_ash", 0)))
	GUICtrlSetState($lumber_birch, cbt(IniRead("config/processing.ini", "lumber", "lumber_birch", 0)))
	GUICtrlSetState($lumber_cedar, cbt(IniRead("config/processing.ini", "lumber", "lumber_cedar", 0)))
	GUICtrlSetState($lumber_eldertree, cbt(IniRead("config/processing.ini", "lumber", "lumber_eldertree", 0)))
	GUICtrlSetState($lumber_fir, cbt(IniRead("config/processing.ini", "lumber", "lumber_fir", 0)))
	GUICtrlSetState($lumber_maple, cbt(IniRead("config/processing.ini", "lumber", "lumber_maple", 0)))
	GUICtrlSetState($lumber_palm, cbt(IniRead("config/processing.ini", "lumber", "lumber_palm", 0)))
	GUICtrlSetState($lumber_pine, cbt(IniRead("config/processing.ini", "lumber", "lumber_pine", 0)))
	GUICtrlSetState($lumber_whitecedar, cbt(IniRead("config/processing.ini", "lumber", "lumber_whitecedar", 0)))
	Global $lumber_array[10] = [$lumber_acacia, $lumber_ash, $lumber_birch, $lumber_cedar, $lumber_eldertree, $lumber_fir, $lumber_maple, $lumber_palm, $lumber_pine, $lumber_whitecedar]
	de_acvtivate_array($lumber_category, $lumber_array)
	Global $lumber_list = IniReadSection("config/processing.ini", "lumber")

	; Plank
	GUICtrlSetState($plank_category, cbt(IniRead("config/processing.ini", "plank", "plank_category", 0)))
	GUICtrlSetState($plank_acacia, cbt(IniRead("config/processing.ini", "plank", "plank_acacia", 0)))
	GUICtrlSetState($plank_ash, cbt(IniRead("config/processing.ini", "plank", "plank_ash", 0)))
	GUICtrlSetState($plank_birch, cbt(IniRead("config/processing.ini", "plank", "plank_birch", 0)))
	GUICtrlSetState($plank_cedar, cbt(IniRead("config/processing.ini", "plank", "plank_cedar", 0)))
	GUICtrlSetState($plank_eldertree, cbt(IniRead("config/processing.ini", "plank", "plank_eldertree", 0)))
	GUICtrlSetState($plank_fir, cbt(IniRead("config/processing.ini", "plank", "plank_fir", 0)))
	GUICtrlSetState($plank_maple, cbt(IniRead("config/processing.ini", "plank", "plank_maple", 0)))
	GUICtrlSetState($plank_palm, cbt(IniRead("config/processing.ini", "plank", "plank_palm", 0)))
	GUICtrlSetState($plank_pine, cbt(IniRead("config/processing.ini", "plank", "plank_pine", 0)))
	GUICtrlSetState($plank_whitecedar, cbt(IniRead("config/processing.ini", "plank", "plank_whitecedar", 0)))
	Global $plank_array[10] = [$plank_acacia, $plank_ash, $plank_birch, $plank_cedar, $plank_eldertree, $plank_fir, $plank_maple, $plank_palm, $plank_pine, $plank_whitecedar]
	de_acvtivate_array($plank_category, $plank_array)
	Global $plank_list = IniReadSection("config/processing.ini", "plank")

	; Ore
	GUICtrlSetState($ore_category, cbt(IniRead("config/processing.ini", "ore", "ore_category", 0)))
	GUICtrlSetState($ore_copper, cbt(IniRead("config/processing.ini", "ore", "ore_copper", 0)))
	GUICtrlSetState($ore_gold, cbt(IniRead("config/processing.ini", "ore", "ore_gold", 0)))
	GUICtrlSetState($ore_iron, cbt(IniRead("config/processing.ini", "ore", "ore_iron", 0)))
	GUICtrlSetState($ore_lead, cbt(IniRead("config/processing.ini", "ore", "ore_lead", 0)))
	GUICtrlSetState($ore_mythril, cbt(IniRead("config/processing.ini", "ore", "ore_mythril", 0)))
	GUICtrlSetState($ore_platinum, cbt(IniRead("config/processing.ini", "ore", "ore_platinum", 0)))
	GUICtrlSetState($ore_silver, cbt(IniRead("config/processing.ini", "ore", "ore_silver", 0)))
	GUICtrlSetState($ore_tin, cbt(IniRead("config/processing.ini", "ore", "ore_tin", 0)))
	GUICtrlSetState($ore_titanium, cbt(IniRead("config/processing.ini", "ore", "ore_titanium", 0)))
	GUICtrlSetState($ore_vanadium, cbt(IniRead("config/processing.ini", "ore", "ore_vanadium", 0)))
	GUICtrlSetState($ore_zinc, cbt(IniRead("config/processing.ini", "ore", "ore_zinc", 0)))
	GUICtrlSetState($ore_coal, cbt(IniRead("config/processing.ini", "ore", "ore_coal", 0)))
	Global $ore_array[12] = [$ore_copper, $ore_gold, $ore_iron, $ore_lead, $ore_mythril, $ore_platinum, $ore_silver, $ore_tin, $ore_titanium, $ore_vanadium, $ore_zinc, $ore_coal]
	de_acvtivate_array($ore_category, $ore_array)
	Global $ore_list = IniReadSection("config/processing.ini", "ore")

	; MeltedShard
	GUICtrlSetState($meltedshard_category, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_category", 0)))
	GUICtrlSetState($meltedshard_copper, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_copper", 0)))
	GUICtrlSetState($meltedshard_gold, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_gold", 0)))
	GUICtrlSetState($meltedshard_iron, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_iron", 0)))
	GUICtrlSetState($meltedshard_lead, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_lead", 0)))
	GUICtrlSetState($meltedshard_mythril, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_mythril", 0)))
	GUICtrlSetState($meltedshard_platinum, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_platinum", 0)))
	GUICtrlSetState($meltedshard_silver, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_silver", 0)))
	GUICtrlSetState($meltedshard_tin, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_tin", 0)))
	GUICtrlSetState($meltedshard_titanium, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_titanium", 0)))
	GUICtrlSetState($meltedshard_vanadium, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_vanadium", 0)))
	GUICtrlSetState($meltedshard_zinc, cbt(IniRead("config/processing.ini", "meltedshard", "meltedshard_zinc", 0)))
	Global $meltedshard_array[11] = [$meltedshard_copper, $meltedshard_gold, $meltedshard_iron, $meltedshard_lead, $meltedshard_mythril, $meltedshard_platinum, $meltedshard_silver, $meltedshard_tin, $meltedshard_titanium, $meltedshard_vanadium, $meltedshard_zinc]
	de_acvtivate_array($meltedshard_category, $meltedshard_array)
	Global $meltedshard_list = IniReadSection("config/processing.ini", "meltedshard")

	_FileReadToArray("config/processing_custom.txt", $CustomsValues, 0, "|")
	For $i = 0 To UBound($Customs) - 1
		For $j = 0 To UBound($CustomsValues, 2) - 2
			If $CustomsValues[$i][$j] <> "" Then GUICtrlSetData($Customs[$i][$j], $CustomsValues[$i][$j])
		Next
	Next

	SetGUIStatus(StringFormat("Initializing done..."))
EndFunc   ;==>InitGUI

Func cbt($handle) ; Transforms Checkbox values for ini
	Local $Switch
	If IsString($handle) Then
		$Switch = $handle
	Else
		$Switch = GUICtrlRead($handle)
	EndIf
	Switch Int($Switch)
		Case 1
			Return 1
		Case 4
			Return 0
		Case 0
			Return 4
	EndSwitch
EndFunc   ;==>cbt

Func de_acvtivate_array($cbtrigger, ByRef $uitargets, $on_active = False)
	Local $ONOFF[2] = [4, 1]

	If $on_active = True Then
		$ONOFF[0] = 1
		$ONOFF[1] = 4
	EndIf

	If GUICtrlRead($cbtrigger) = $ONOFF[0] Then
		For $i = 0 To UBound($uitargets) - 1
			GUICtrlSetState($uitargets[$i], 128) ; Control will be greyed out.
		Next
		Return True
	ElseIf GUICtrlRead($cbtrigger) = $ONOFF[1] Then
		For $i = 0 To UBound($uitargets) - 1
			GUICtrlSetState($uitargets[$i], 64) ; Control will be enabled.
		Next
		Return True
	EndIf
EndFunc   ;==>de_acvtivate_array

#Region - CrayonCode Support
Func _terminate()
	Exit (0)
EndFunc   ;==>_terminate

Func PauseToggle()
	If not $Processing then
		SetGUIStatus("No process running.")
		Else
			Local Static $PauseToggle = False
			$PauseToggle = Not $PauseToggle
			If $PauseToggle = False Then
				SetGUIStatus("Resume operations")
				Return True
			EndIf
			SetGUIStatus("Pausing operations - worker feed will continue...")
			While $PauseToggle
				GSleep(500)
			WEnd
			Return True
		EndIf
	SetGUIStatus("Pause not enabled!")
EndFunc

Func cw($text)
	ConsoleWrite(@CRLF & $text)
EndFunc   ;==>cw

Func CoSe($key, $raw = 0)
	Dim $hTitle
	$hwnd = WinActive($hTitle)
	If $hwnd = 0 Then $hwnd = WinActivate($hTitle)

	Local $Pos = WinGetPos($hwnd)
	If @error Then
		Local $Pos[4] = [0, 0, @DesktopWidth, @DesktopHeight]
	EndIf

	Opt("MouseCoordMode", 2)
	If MouseGetPos(0) < 0 Or MouseGetPos(0) > $Pos[2] Or MouseGetPos(1) < 0 Or MouseGetPos(1) > $Pos[3] Then StealthMouseMove(100, 100, 0)
	Opt("MouseCoordMode", 1)

	ControlSend($hwnd, "", "", $key, $raw)
EndFunc   ;==>CoSe

Func SetGUIStatus($data)
	RemLineLogWindow()
	If $data <> $LastGUIStatus Then
		ConsoleWrite(@CRLF & @HOUR & ":" & @MIN & "." & @SEC & " " & $data)
		;If $LogFileEnable = True Then
		LogData(@HOUR & ":" & @MIN & "." & @SEC & " " & $data)
		_GUICtrlEdit_AppendText($ELog, "[" & $Days[@WDAY-1] & "]" & @HOUR & ":" & @MIN & " > " &  $data & @CRLF)
		$LastGUIStatus = $data
	EndIf
EndFunc   ;==>SetGUIStatus

Func LogData($text)
	If $LogFile = "" Then $LogFile = FileOpen("logs\ProcessingLOGFILE.txt", 9)
	FileWriteLine($LogFile, $text)
EndFunc   ;==>LogData

Func CloseLog()
	If $LogFile <> "" Then
		FileClose($LogFile)
	EndIf
EndFunc   ;==>CloseLog

Func DetectFullscreenToWindowedOffset() ; Returns $Offset[4] left, top, right, bottom (Fullscreen returns 0, 0, Width, Height)

	Local $x1, $x2, $y1, $y2
	Local $Offset[4]
	Local $ClientZero[4] = [0, 0, 0, 0]

	WinActivate($hBDO)
	WinWaitActive($hBDO, "", 5)
	WinActivate($hBDO)
	Local $Client = WinGetPos($hBDO)
	If Not IsArray($Client) Then
		SetGUIStatus("E: ClientSize could not be detected")
		Return ($ClientZero)
	EndIf

	If $Client[2] = @DesktopWidth And $Client[3] = @DesktopHeight Then
		SetGUIStatus("Fullscreen detected (" & $Client[2] & "x" & $Client[3] & ") - No Offsets")
		Return ($Client)
	EndIf

	If Not VisibleCursor() Then CoSe("{LCTRL}")
	Opt("MouseCoordMode", 2)
	MouseMove(0, 0, 0)
	Opt("MouseCoordMode", 1)
	$x1 = MouseGetPos(0)
	$y1 = MouseGetPos(1)
	Opt("MouseCoordMode", 0)
	MouseMove(0, 0, 0)
	Opt("MouseCoordMode", 1)
	$x2 = MouseGetPos(0)
	$y2 = MouseGetPos(1)
	MouseMove($x1, $y1, 0)


	$Offset[0] = $Client[0] + $x1 - $x2
	$Offset[1] = $Client[1] + $y1 - $y2
	$Offset[2] = $Client[0] + $Client[2]
	$Offset[3] = $Client[1] + $Client[3]
	For $i = 0 To 3
		SetGUIStatus("ScreenOffset(" & $i & "): " & $Offset[$i])
	Next

	Return ($Offset)
EndFunc   ;==>DetectFullscreenToWindowedOffset

Func OCInventory($open = True) ; Adpated (Removed $Fish)
	Local Const $Offset[2] = [-298, 48] ; Offset from reference_inventory to left border of first Inventory Slot. For future use.
	Local $IS = False
	Local $C[2]
	Local $timer = TimerInit()
	While Not $IS And $Processing
		Sleep(250)
		$IS = _ImageSearchArea("res/reference_inventory.png", 0, $ResOffset[0], $ResOffset[1], $ResOffset[2], $ResOffset[3], $C[0], $C[1], 40, 0)
		Sleep(250)
		If $IS = True Then
			If $open = True Then
				$C[0] += $Offset[0]
				$C[1] += $Offset[1]
				Return ($C)
			ElseIf $open = False Then
				CoSe("i")
				Sleep(500)
			EndIf
		ElseIf $IS = False Then
			If $open = True Then
				CoSe("i")
				StealthMouseMove($ResOffset[0] + 30, $ResOffset[1] + 30)
				Sleep(500)
			ElseIf $open = False Then
				SetGUIStatus("Inventory closed")
				Return False
			EndIf
		EndIf
		If TimerDiff($timer) / 1000 >= 6 Then
			SetGUIStatus("Inventory not detected, maybe restart the bot?")
			Return False
		EndIf
	WEnd
EndFunc   ;==>OCInventory

Func VisibleCursor()
	Local $cursor = _WinAPI_GetCursorInfo()
	Return ($cursor[1])
EndFunc   ;==>VisibleCursor

Func ObfuscateTitle($Title, $length = 5)
	Local $newtitle = ""
	If $length > 0 Then
		For $i = 1 To $length
			Switch Random(1, 3, 1)
				Case 1
					$newtitle &= Chr(Random(65, 90, 1)) ; small letter
				Case 2
					$newtitle &= Chr(Random(97, 122, 1)) ; big letter
				Case 3
					$newtitle &= Random(0, 9, 1) ; number
			EndSwitch
		Next
	EndIf
	$newtitle &= @HOUR & @MIN & @SEC
	WinSetTitle($Title, "", $newtitle)
	Return True
EndFunc   ;==>ObfuscateTitle

Func AntiScreenSaverMouseWiggle($minutes = 2)
	Local Static $ScreenSaver = TimerInit()
	$minutes *= 60000

	If TimerDiff($ScreenSaver) >= $minutes Then
		Local $MPos = MouseGetPos()
		StealthMouseMove($MPos[0] + 10, $MPos[1])
		StealthMouseMove($MPos[0], $MPos[1])
		$ScreenSaver = TimerInit()
		Return True
	EndIf

	Return False
EndFunc
#EndRegion - CrayonCode Support

#Region - Main Functions
Func ProcessCustom()
	$Processing = Not $Processing
	If $Processing = False Then
		SetGUIStatus("Manually stopping ProcessCustom")
		Return False
	EndIf

	Local $CustomQueue = $CustomsValues
	Local $FRC, $PM
	Local $Q = 0
	$ResOffset = DetectFullscreenToWindowedOffset()

	While $Processing = True And $Q < UBound($CustomQueue)
		$CustomQueue[$Q][2] = Int($CustomQueue[$Q][2])
		$CustomQueue[$Q][3] = Int($CustomQueue[$Q][3])
		$CustomQueue[$Q][5] = Int($CustomQueue[$Q][5])
		$CustomQueue[$Q][6] = Int($CustomQueue[$Q][6])
		If $CustomQueue[$Q][0] = "" Then
			SetGUIStatus("Skipping Queue: " & $Q & " Reason: No Processing Method selected")
			$Q += 1
			ContinueLoop
		EndIf
		If $CustomQueue[$Q][1] = "" And $CustomQueue[$Q][4] = "" Then
			SetGUIStatus("Skipping Queue: " & $Q & " Reason: No Ingredients selected")
			$Q += 1
			ContinueLoop
		EndIf
		If $CustomQueue[$Q][3] < 0 Or $CustomQueue[$Q][6] < 0 Then ; If Max < 0 Then skip to next queue
			SetGUIStatus("Skipping Queue: " & $Q & " Reason: Maximum exceeded")
			$Q += 1
			ContinueLoop
		EndIf
		If $CustomQueue[$Q][2] = 0 Then $CustomQueue[$Q][2] = $DefaultBatchSize ; If Batch=0 then use defaultbatch
		If $CustomQueue[$Q][5] = 0 Then $CustomQueue[$Q][5] = $DefaultBatchSize ; If Batch=0 then use defaultbatch
		If $CustomQueue[$Q][3] > 0 And $CustomQueue[$Q][3] < $CustomQueue[$Q][2] Then $CustomQueue[$Q][2] = $CustomQueue[$Q][3]; If Max > 0 and Max < Batch then Batch = Max
		If $CustomQueue[$Q][6] > 0 And $CustomQueue[$Q][6] < $CustomQueue[$Q][5] Then $CustomQueue[$Q][6] = $CustomQueue[$Q][6]; If Max > 0 and Max < Batch then Batch = Max

		Local $String = "--> " & $CustomQueue[$Q][0] & " "
		If $CustomQueue[$Q][1] <> "" Then $String &= StringFormat("%s %i/%i", $CustomQueue[$Q][1], $CustomQueue[$Q][2], $CustomQueue[$Q][3] )
		If $CustomQueue[$Q][1] <> "" And $CustomQueue[$Q][1] <> "" Then $String &= " with "
		If $CustomQueue[$Q][4] <> "" Then $String &= StringFormat("%s %i/%i", $CustomQueue[$Q][4], $CustomQueue[$Q][5], $CustomQueue[$Q][6] )

		SetGUIStatus($String)
		OpenWarehouse()
		ReturnToStorage()
		$FRC = FindResourceCustom($CustomQueue[$Q][1], $CustomQueue[$Q][2], $CustomQueue[$Q][4], $CustomQueue[$Q][5])
		If $FRC = True Then
			Sleep(250)
			CoSe("{Esc}")
			CoSe("{Esc}")
			Sleep(250)
			$PM = ProductionMethod($CustomQueue[$Q][0])
			If $PM = False Then
				$String &= " Failed"
				SetGUIStatus($String)
				$Q += 1
			Else
				$String &= " Successful"
				SetGUIStatus($String)
				If $CustomQueue[$Q][3] <> 0 And $CustomQueue[$Q][1] <> "" Then
					$CustomQueue[$Q][3] -= $CustomQueue[$Q][2]
					If $CustomQueue[$Q][3] = 0 Then $CustomQueue[$Q][3] -= 1
				EndIf
				If $CustomQueue[$Q][6] <> 0 And $CustomQueue[$Q][4] <> "" Then
					$CustomQueue[$Q][6] -= $CustomQueue[$Q][5]
					If $CustomQueue[$Q][6] = 0 Then $CustomQueue[$Q][6] -= 1
				EndIf
			EndIf
		Else
			SetGUIStatus("Skipping Queue: " & $Q & " Reason: Atleast One Ingredient absent")
			$Q += 1
		EndIf
	WEnd
	SetGUIStatus("ProcessCustom finished")
	$Processing = False
	CoSe("{ESC}")
	CoSe("{ESC}")
	SetGUIStatus("Processing task finished, will continue to feed workers.")
	WorkerFeed()
	While $Processing = False
		AlchemyStone()
		Sleep(60000)
	WEnd
EndFunc   ;==>ProcessCustom

Func ProcessSimple()
	$Processing = Not $Processing
	If $Processing = False Then
		SetGUIStatus("Manually stopping ProcessSimple")
		Return False
	EndIf
	Global $PL[0][2]
	Local $ItemNumber
	$ResOffset = DetectFullscreenToWindowedOffset()

	If $lumber_list[1][1] = 1 Then
		For $i = 2 To $lumber_list[0][0]
			If $lumber_list[$i][1] = 1 Then _ArrayAdd($PL, $lumber_list[$i][0] & "|" & 2)
		Next
	EndIf
	If $plank_list[1][1] = 1 Then
		For $i = 2 To $plank_list[0][0]
			If $plank_list[$i][1] = 1 Then _ArrayAdd($PL, $plank_list[$i][0] & "|" & 2)
		Next
	EndIf
	If $ore_list[1][1] = 1 Then
		For $i = 2 To $ore_list[0][0]
			If $ore_list[$i][1] = 1 Then _ArrayAdd($PL, $ore_list[$i][0] & "|" & 5)
		Next
	EndIf
	If $meltedshard_list[1][1] = 1 Then
		For $i = 2 To $meltedshard_list[0][0]
			If $meltedshard_list[$i][1] = 1 Then _ArrayAdd($PL, $meltedshard_list[$i][0] & "|" & 5)
		Next
	EndIf
	While UBound($PL) > 0 And $Processing = True
		If $TestingMode = False Then
			OpenWarehouse()
			ReturnToStorage()
		EndIf
		$ItemNumber = FindResource($PL)
		If $ItemNumber > -1 Then
			Sleep(250)
			CoSe("{Esc}")
			CoSe("{Esc}")
			Sleep(250)
			If ProductionMethod($PL[$ItemNumber][1]) = False Then
				SetGUIStatus("Removing " & $PL[$ItemNumber][0] & " from ProcessingQueue")
				_ArrayDelete($PL, $ItemNumber)
			EndIf
			SetGUIStatus("Proceeding to next item")
		Else
			SetGUIStatus("No Item in ProcessingQueue found. Stopping.")
			$Processing = False
			CoSe("{ESC}")
			CoSe("{ESC}")
			;=================trash fix pause after craft for continous feed
			SetGUIStatus("Processing task finished, will continue to feed workers.")
			WorkerFeed()
			While $Processing = False
				AlchemyStone()
				Sleep(60000)
			WEnd
			;=================
			ExitLoop
		EndIf
	WEnd

EndFunc   ;==>ProcessBasic

Func OpenWarehouse($SkipTransport = False)
	Local $WarehouseButton = "res/npc_bank_button.png"
	Local $TransportButton = "res/npc_bank_transport.png"
	Local Const $ESC = "res/esc_worker.png"
	Local $x, $y, $IS

	Local $counter = 12
	SetGUIStatus("Opening warehouse interface")

	While $counter >= 0 And $Processing = True
		$IS = _ImageSearchArea($TransportButton, 1, $ResOffset[0], $ResOffset[1], $ResOffset[2], $ResOffset[3], $x, $y, 20, 0)
		If $IS = True Then
			If $SkipTransport = False Then
				; Transport Workaround necessary to fix render issues that appear if you open the warehouse more than once per game session
				SetGUIStatus("Clicking Transport Button to fix any render issues")
				StealthMouseClick("left", $x, $y, 1)
				Sleep(500)
				CoSe("{Esc}")
			EndIf
			$IS = _ImageSearchArea($WarehouseButton, 1, $ResOffset[0], $ResOffset[1], $ResOffset[2], $ResOffset[3], $x, $y, 20, 0)
			If $IS = True Then
				SetGUIStatus("Clicking Warehouse Button")
				StealthMouseClick("left", $x, $y, 2)
				Return True
			EndIf
		ElseIf $counter < 10 Then
			; Close dialog and slowly pan camera to the right in case multiple npcs are overlapping
			SetGUIStatus("Couldn't find Transport icon, wrong NPC? Attempting to correct...")
			CoSe("{ESC}")
			Sleep(500)
			$IS = _ImageSearchArea($ESC, 1, $ResOffset[0], $ResOffset[1], $ResOffset[2], $ResOffset[3], $x, $y, 20, 0)
			If $IS = True Then
				SetGUIStatus("Menu open, closing...")
				CoSe("{ESC}")
				Sleep(500)
			EndIf
			StealthMouseMove(MouseGetPos(0) + 500, MouseGetPos(1), 50)
		EndIf
		Local $C = StorageWindow()
		If IsArray($C) = True Then
			SetGUIStatus("Closing storage")
			CoSe("{ESC}")
		EndIf
		CoSe("r") ; Talk to NPC
		Sleep(1750)
		$counter -= 1
		If $counter <= 0 Then Return False
	WEnd
EndFunc   ;==>OpenWarehouse

Func FindResourceCustom($Ingredient1 = "", $Batch1 = 0, $Ingredient2 = "", $Batch2 = 0)
	Local $x, $y, $IS
	Local $Ing1Status = 0, $Ing2Status = 0
	If $Ingredient1 = "" Or $Batch1 = 0 Then $Ing1Status = 2
	If $Ingredient2 = "" Or $Batch2 = 0 Then $Ing2Status = 2

	Local $C = StorageWindow()
	If IsArray($C) = False Then Return False

	Local $String = "Scanning for current order:"
	If $Ingredient1 <> "" Then $String &= " [" & $Ingredient1 & ", " & $Batch1 & "] "
	If $Ingredient2 <> "" Then $String &= " [" & $Ingredient2 & ", " & $Batch2 & "] "
	SetGUIStatus($String)

	For $k = 0 To 2
		If $Processing = False Then Return False
		If MouseGetPos(0) >= $C[0] And MouseGetPos(0) <= $C[0] + 500 And MouseGetPos(1) >= $C[1] And MouseGetPos(1) <= $C[1] + 500 Then StealthMouseMove($C[0] - 50, $C[1]) ; Keep mouse out of detection range


		If $Ing1Status = 0 Then
			$IS = _ImageSearchArea("res/processing/" & StringStripWS($Ingredient1, 8) & ".png", 1, $C[0], $C[1], $C[0] + 371, $C[1] + 371, $x, $y, 20, 0)
			If $IS = True Then
				If $x = 0 Or $y = 0 Then SetGUIStatus("Ingredient Image probably missing")
				SetGUIStatus($Ingredient1 & " on page " & $k & " is PRESENT")
				ItemMoveAmount($x, $y, $Batch1)
				$Ing1Status = 1
				If MouseGetPos(0) >= $C[0] And MouseGetPos(0) <= $C[0] + 500 And MouseGetPos(1) >= $C[1] And MouseGetPos(1) <= $C[1] + 500 Then StealthMouseMove($C[0] - 50, $C[1], 0) ; Keep mouse out of detection range
				Sleep(100)
			Else
				SetGUIStatus($Ingredient1 & " on page " & $k & " is absent")
			EndIf
		EndIf

		If $Ing2Status = 0 Then
			$IS = _ImageSearchArea("res/processing/" & StringStripWS($Ingredient2, 8) & ".png", 1, $C[0], $C[1], $C[0] + 371, $C[1] + 371, $x, $y, 20, 0)
			If $IS = True Then
				If $x = 0 Or $y = 0 Then SetGUIStatus("Ingredient Image probably missing")
				SetGUIStatus($Ingredient2 & " on page " & $k & " is PRESENT")
				ItemMoveAmount($x, $y, $Batch2)
				$Ing2Status = 1
				If MouseGetPos(0) >= $C[0] And MouseGetPos(0) <= $C[0] + 500 And MouseGetPos(1) >= $C[1] And MouseGetPos(1) <= $C[1] + 500 Then StealthMouseMove($C[0] - 50, $C[1], 0) ; Keep mouse out of detection range
				Sleep(100)
			Else
				SetGUIStatus($Ingredient2 & " on page " & $k & " is ABSENT")
			EndIf
		EndIf

		If $Ing1Status > 0 And $Ing2Status > 0 Then
			SetGUIStatus("FindResourceCustom: " & $Ing1Status & ", " & $Ing2Status & " - All Required Ingredients PRESENT")
			Return True
		EndIf

		If $k < 2 Then
			StealthMouseMove($C[0], $C[1])
			Sleep(50)
			For $j = 1 To 8
				MouseWheel("down", 1)
				Sleep(25)
			Next
		EndIf
		Sleep(150)
	Next
	SetGUIStatus("FindResourceCustom: " & $Ing1Status & ", " & $Ing2Status & " - Atleast One Ingredient absent")
	Return False
EndFunc   ;==>FindResourceCustom

Func FindResource(ByRef $ProcessingList)
	Local $x, $y, $IS

	Local $C = StorageWindow()
	If IsArray($C) = False Then Return False

	SetGUIStatus("Scanning for items")
	For $k = 0 To 2
		If $Processing = False Then Return False
		If MouseGetPos(0) >= $C[0] And MouseGetPos(0) <= $C[0] + 500 And MouseGetPos(1) >= $C[1] And MouseGetPos(1) <= $C[1] + 500 Then StealthMouseMove($C[0] - 50, $C[1]) ; Keep mouse out of detection range
		For $i = 0 To UBound($ProcessingList) - 1
			$IS = _ImageSearchArea("res/processing/" & $ProcessingList[$i][0] & ".png", 1, $C[0], $C[1], $C[0] + 371, $C[1] + 371, $x, $y, 20, 0)
			If $IS = True Then
				If $x = 0 Or $y = 0 Then SetGUIStatus("Imagefile probably missing")
				SetGUIStatus($ProcessingList[$i][0] & " found, attempting to withdraw")
				If $TestingMode = False Then ItemMoveAmount($x, $y, $DefaultBatchSize)
				If MouseGetPos(0) >= $C[0] And MouseGetPos(0) <= $C[0] + 500 And MouseGetPos(1) >= $C[1] And MouseGetPos(1) <= $C[1] + 500 Then StealthMouseMove($C[0] - 50, $C[1], 0) ; Keep mouse out of detection range
				Sleep(100)
				If $TestingMode = False Then Return $i
			Else
				SetGUIStatus($ProcessingList[$i][0] & " not found on current page, moving to next")
			EndIf
		Next
		If $k < 2 Then
			StealthMouseMove($C[0], $C[1])
			Sleep(50)
			For $j = 1 To 8
				MouseWheel("down", 1)
				Sleep(25)
			Next
		EndIf
		Sleep(150)
	Next
	Return -1
EndFunc   ;==>FindResource

Func ItemMoveAmount($x, $y, $Quantity)
	StealthMouseClick("right", $x, $y, 2)
	StealthMouseClick("right", $x + 1, $y, 2)
	Sleep(100)
	If $Quantity == "ALL" Then
		CoSe("f")
	Else
		CoSe($Quantity)
	EndIf
	Sleep(100)
	CoSe("r")
	Sleep(250)
EndFunc   ;==>ItemMoveAmount

Func ReturnToStorage()
	Local $InvA = OCInventory(True)
	If IsArray($InvA) = False Then Return False
	SetGUIStatus("Returning items to storage")
	For $i = 0 To 3
		ItemMoveAmount($InvA[0] + 10 + 48 * $i, $InvA[1], "ALL")
	Next
EndFunc   ;==>ReturnToStorage

Func LoadHorse()
	$HorseLoading = Not $HorseLoading
	
	If $HorseLoading Then
		Local $Quantity = $DefaultBatchSize
		MsgBox(0, "INFO", "Hover mouse over first slot of horse, then press ENTER")
		Local $HorsePos = MouseGetPos()
		MsgBox(0, "INFO", "Hover mouse over item you want to stack and press ENTER.")
		Local $ItemPos = MouseGetPos()
		MsgBox(0, "INFO", "Hover mouse over first empty inventory slot and press ENTER.")
		Local $InvenPos = MouseGetPos()
		MsgBox(0, "INFO", "Press ENTER to begin process, Ctrl+F7 to end.")
		
		StealthMouseClick("right", $ItemPos[0], $ItemPos[1], 2)
		sleep(100)
		StealthMouseClick("left", $ItemPos[0]+20, $ItemPos[1]+60, 2)
		sleep(100)
		CoSe($Quantity)
		sleep(100)
		CoSe("r")
		sleep(100)
		
		StealthMouseClick("right", $InvenPos[0], $InvenPos[1], 2)
		sleep(100)
		StealthMouseClick("left", $InvenPos[0]+20, $InvenPos[1]+30, 2)
		sleep(100)
		CoSe("fr")
		sleep(100)
	EndIf
	
	While $HorseLoading
		StealthMouseClick("right", $ItemPos[0], $ItemPos[1], 2)
		sleep(100)
		StealthMouseClick("left", $ItemPos[0]+20, $ItemPos[1]+60, 2)
		sleep(100)
		CoSe($Quantity)
		sleep(100)
		CoSe("r")
		sleep(100)
		
		StealthMouseClick("right", $HorsePos[0], $HorsePos[1], 2)
		sleep(100)
		StealthMouseClick("left", $HorsePos[0]+20, $HorsePos[1]+30, 2)
		sleep(100)
		CoSe("fr")
		sleep(100)
		
		StealthMouseClick("right", $InvenPos[0], $InvenPos[1], 2)
		sleep(100)
		StealthMouseClick("left", $InvenPos[0]+20, $InvenPos[1]+30, 2)
		sleep(100)
		CoSe("fr")
		sleep(100)
		
	WEnd

EndFunc

Func ProductionMethod($Method) ; 0=Shaking, 1=Grinding, 2=Chopping, 3=Drying, 4=Filtering, 5=Heating

	$Processing = True

	Local $x, $y, $IS
	Local $ProductionHammer = "res/processing_hammer_uno.png"
	Local $ProcessingMethodOffset[2] = [62, -62]
	Local $ProcessingStart[2] = [256, -274]

	If IsNumber($Method) = False Then
		Switch $Method
			Case "Shaking"
				$Method = 0
			Case "Grinding"
				$Method = 1
			Case "Chopping"
				$Method = 2
			Case "Drying"
				$Method = 3
			Case "Filtering"
				$Method = 4
			Case "Heating"
				$Method = 5
		EndSwitch
	EndIf

	$IS = _ImageSearchArea($ProductionHammer, 1, $ResOffset[0], $ResOffset[1], $ResOffset[2], $ResOffset[3], $x, $y, 50, 0)
	SetGUIStatus("Processing open: " & $IS)
	If Not $IS Then
		CoSe("l")
		Sleep(500)
	Else
		CoSe("l")
		CoSe("l")
		Sleep(500)
	EndIf
	$IS = _ImageSearchArea($ProductionHammer, 1, $ResOffset[0], $ResOffset[1], $ResOffset[2], $ResOffset[3], $x, $y, 50, 0)
	SetGUIStatus("Processing open: " & $IS)

	StealthMouseClick("left", $x + $ProcessingMethodOffset[0] * $Method, $y + $ProcessingMethodOffset[1])
	Sleep(500)
	Local $InvA = OCInventory(True)
	If IsArray($InvA) = False Then
		SetGUIStatus("Inventory not found")
		Return False
	EndIf
	Sleep(500)
	StealthMouseClick("Left", $InvA[0] + 48 * 8, $InvA[1]) ; Click on Inventory to get focus
	StealthMouseClick("Right", $InvA[0] + 10, $InvA[1]) ; Click first slot
	StealthMouseClick("Right", $InvA[0] + 10 + 48, $InvA[1]) ; Click second slot

	StealthMouseClick("left", $x + $ProcessingStart[0], $y + $ProcessingStart[1])
	SetGUIStatus("Waiting for Processing to end.")
	Local $timer = TimerInit()
	If Not ProductionActivityCheck() Then
		SetGUIStatus("Processing failed")
		Return False
	EndIf
	SetGUIStatus("Processing stopped after " & Round(TimerDiff($timer) / 1000, 0) & "s.")
	If TimerDiff($timer) / 1000 > $MinProcessTime Then
		SetGUIStatus("Processing time longer than " & $MinProcessTime & " seconds. Repeat the same item.")
		Return True
	Else
		SetGUIStatus("Processing time too short. Switching to next item")
		Return False
	EndIf

EndFunc   ;==>ProductionMethod

Func StorageWindow()
	Local $x, $y, $IS
	Local Static $AutoArrangeCheck = "res/reference_autoarrange.png"
	Local $FirstSlotOffset[2] = [-2, 32]
	Local $C[2]

	Sleep(500)
	For $i = 0 To 2
		$IS = _ImageSearchArea($AutoArrangeCheck, 0, $ResOffset[0], $ResOffset[1], $ResOffset[2], $ResOffset[3], $x, $y, 40 + 20 * $i, 0)
		If $IS = True Then ExitLoop
		Sleep(250)
	Next
	If $IS = True Then
		$C[0] = $x + $FirstSlotOffset[0]
		$C[1] = $y + $FirstSlotOffset[1]
		SetGUIStatus("StorageWindow(): Storage is open with anchor " & $C[0] & ", " & $C[1])
		Return ($C)
	Else
		SetGUIStatus("StorageWindow(): Storage is closed")
		Return False
	EndIf
EndFunc   ;==>StorageWindow

Func CreateCustoms()
	$span = 24
	Global $MaterialFiles = _FileListToArray("res/processing/", "*", 0)
	Global $MaterialSring = ""
	For $i = 1 To UBound($MaterialFiles) - 1
		$MaterialSring &= StringTrimRight($MaterialFiles[$i], 4) & "|"
	Next
	For $i = 0 To UBound($Customs) - 1
		$Customs[$i][0] = GUICtrlCreateCombo("", 8, 56 + $span * $i, 65, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL, $CBS_SORT)) ; Method
		$Customs[$i][1] = GUICtrlCreateCombo("", 88, 56 + $span * $i, 145, 25, BitOR($CBS_DROPDOWNLIST, $WS_VSCROLL)) ; Ingredient 1
		$Customs[$i][2] = GUICtrlCreateInput("0", 240, 56 + $span * $i, 33, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER)) ; Batch 1
		$Customs[$i][3] = GUICtrlCreateInput("0", 280, 56 + $span * $i, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER)) ; Max 1
		$Customs[$i][4] = GUICtrlCreateCombo("", 336, 56 + $span * $i, 145, 25, BitOR($CBS_DROPDOWNLIST, $WS_VSCROLL, $CBS_SORT)) ; Ingredient 2
		$Customs[$i][5] = GUICtrlCreateInput("0", 488, 56 + $span * $i, 33, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER)) ; Batch 2
		$Customs[$i][6] = GUICtrlCreateInput("0", 528, 56 + $span * $i, 41, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER)) ; Max 2
		$Customs[$i][7] = GUICtrlCreateButton("CLR", 576, 55 + $span * $i, 30, 23) ; CLR

		GUICtrlSetData($Customs[$i][0], "|Shaking|Grinding|Chopping|Drying|Filtering|Heating|")
		GUICtrlSetData($Customs[$i][1], $MaterialSring)
		GUICtrlSetLimit($Customs[$i][2], 4)
		GUICtrlSetLimit($Customs[$i][3], 5)
		GUICtrlSetData($Customs[$i][4], $MaterialSring)
		GUICtrlSetLimit($Customs[$i][5], 4)
		GUICtrlSetLimit($Customs[$i][6], 5)
	Next
EndFunc   ;==>CreateCustoms

Func ClearRowCustom($i)
	GUICtrlSetData($Customs[$i][0], "|Shaking|Grinding|Chopping|Drying|Filtering|Heating|")
	GUICtrlSetData($Customs[$i][1], "|" & $MaterialSring)
	GUICtrlSetData($Customs[$i][2], 0)
	GUICtrlSetData($Customs[$i][3], 0)
	GUICtrlSetData($Customs[$i][4], "|" & $MaterialSring)
	GUICtrlSetData($Customs[$i][5], 0)
	GUICtrlSetData($Customs[$i][6], 0)
EndFunc   ;==>ClearRowCustom

Func CheckGUI()
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $BCustom
			ProcessCustom()
		Case $BSimple
			ProcessSimple()
		Case $BPause
			PauseToggle()
		Case $BSave
			Save()
		Case $lumber_category
			de_acvtivate_array($lumber_category, $lumber_array)
		Case $plank_category
			de_acvtivate_array($plank_category, $plank_array)
		Case $ore_category
			de_acvtivate_array($ore_category, $ore_array)
		Case $meltedshard_category
			de_acvtivate_array($meltedshard_category, $meltedshard_array)
		Case $Customs[0][7]
			ClearRowCustom(0)
		Case $Customs[1][7]
			ClearRowCustom(1)
		Case $Customs[2][7]
			ClearRowCustom(2)
		Case $Customs[3][7]
			ClearRowCustom(3)
		Case $Customs[4][7]
			ClearRowCustom(4)
		Case $Customs[5][7]
			ClearRowCustom(5)
		Case $Customs[6][7]
			ClearRowCustom(6)
		Case $Customs[7][7]
			ClearRowCustom(7)
		Case $Customs[8][7]
			ClearRowCustom(8)
		Case $Customs[9][7]
			ClearRowCustom(9)
		Case $Customs[10][7]
			ClearRowCustom(10)
		Case $Customs[11][7]
			ClearRowCustom(11)
		Case $Customs[12][7]
			ClearRowCustom(12)
		Case $Customs[13][7]
			ClearRowCustom(13)
	EndSwitch
EndFunc
#EndRegion ;==> Main Function Region End

Func Save()
	SetGUIStatus("Settings saved")
	StoreGUI()
EndFunc

Func GSleep($time)
	$time /= 10
	For $i = 0 To $time
		AlchemyStone()
		Buff($Buff1Enable, $Buff2Enable, $BuffCD1, $BuffCD2, $BuffKey1, $BuffKey2)
		AntiScreenSaverMouseWiggle()
		For $j = 0 To 10
			Sleep(10)
			CheckGUI()
		Next
	Next
EndFunc

Func AlchemyStone()
	Local Static $AlchemyStoneTimer = TimerInit()
	Local Static $AlchemyStoneTimerDiff
	Local Static $AlchemyStoneCooldown = 1800500
	If $AlchemyStoneEnable = False Then
		Return False
	Else
		$AlchemyStoneTimerDiff = TimerDiff($AlchemyStoneTimer)
		SetGUIStatus(StringFormat("Feeding Worker when timer hits 30 min.[%.1fm]", $AlchemyStoneTimerDiff / 60000))
		If $AlchemyStoneTimerDiff >= $AlchemyStoneCooldown Then
			WorkerFeed()
			SetGUIStatus("Feeding workers")
			;CoSe("u")
			$AlchemyStoneTimer = TimerInit()
		Else
			;GUICtrlSetData($I_AlchemyStoneTimer, Round($AlchemyStoneTimerDiff/1000,0) & "s")
		EndIf
	EndIf
EndFunc

Func WaitForMenu($show = False, $timeout = 5)
	Local Const $WorkerIcon = "res/esc_worker.png"
	Local $x, $y, $IS
	Local $timer = TimerInit()
	$timeout *= 1000

	While TimerDiff($timer) < $timeout
		$IS = _ImageSearchArea($WorkerIcon, 1, $Res[0], $Res[1], $Res[2], $Res[3], $x, $y, 50, 0)
		If $IS = False Then CoSe("{ESC}") ; Opening Menu
		If $IS = True Then
			If $show = False Then CoSe("{ESC}") ; Closing Menu
			Return True
		EndIf
		Sleep(2000)
	WEnd
	Return False
EndFunc   ;==>WaitForMenu

; # Side
Func WorkerFeed()
	Local Const $WorkerIcon = "res/esc_worker.png"
	Local Const $WorkerRecoverAnchor = "res/worker_recover_anchor.png"
	Local Const $WorkerOffsets[4][2] = [ _
			[-263, 444], _ ; Recover All
			[-522, -19], _ ; Select food
			[-479, 125], _ ; Confirm
			[-188, 443]] ; Repeat All
	Local $x, $y, $IS
	SetGUIStatus(StringFormat("Feeding Worker"))
	WaitForMenu(True)
	$IS = _ImageSearchArea($WorkerIcon, 1, $Res[0], $Res[1], $Res[2], $Res[3], $x, $y, 10, 0)
	If $IS = True Then
		VMouse($x, $y, 1, "left")
		Sleep(1500)
		$IS = _ImageSearchArea($WorkerRecoverAnchor, 0, $Res[0], $Res[1], $Res[2], $Res[3], $x, $y, 10, 0)
		If $IS = True Then
				VMouse($x + $WorkerOffsets[0][0], $y + $WorkerOffsets[0][1], 1, "left") ; Recover All
				VMouse($x + $WorkerOffsets[0][0], $y + $WorkerOffsets[0][1] + 10, 1, "left") ; Recover All DIFFERENT LANGUAGES FIX
				VMouse($x + $WorkerOffsets[1][0], $y + $WorkerOffsets[1][1], 1, "left") ; Select food
				Sleep(100)
				VMouse($x + $WorkerOffsets[2][0], $y + $WorkerOffsets[2][1], 1, "left") ; Confirm
				Sleep(1000)
				VMouse($x + $WorkerOffsets[3][0], $y + $WorkerOffsets[3][1], 1, "left") ; Repeat All
				VMouse($x + $WorkerOffsets[3][0], $y + $WorkerOffsets[3][1] + 10, 1, "left") ; Repeat All DIFFERENT LANGUAGES FIX
			CoSe("{ESC}") ; Close Worker List
			Sleep(1500)
			CoSe("l") ; Open Processing screen
			Return True
		Else
			SetGUIStatus("WorkerRecoverAnchor missing")
			Return False
		EndIf
	Else
		SetGUIStatus("WorkerIcon missing")
	EndIf
EndFunc   ;==>WorkerFeed

Func BuffTest($Buff1Enable, $Buff2Enable)
	if $Buff1Enable = True Then
		SetGUIStatus("Consuming buff1")
		Local $CoSeKey1 = String($BuffKey1)
		CoSe($CoSeKey1)
		Sleep(1500)
	EndIf

	if $Buff2Enable = True Then
		SetGUIStatus("Consuming buff2")
		Local $CoSeKey2 = String($BuffKey2)
		CoSe($CoSeKey2)
		Sleep(1500)
	EndIf
EndFunc

Func Buff($Buff1Enable, $Buff2Enable, $BuffCD1, $BuffCD2, $BuffKey1, $BuffKey2)
	;SetGUIStatus("Buff()")
	If $Buff1Enable = False And $Buff2Enable = False Then Return False

	If $Buff1Enable = True Then
		Local Static $BuffTimer1 = TimerInit()
		If $BuffCD1 = 0 Then $BuffTimer1 = 0
		$BuffCD1 *= 60000
		Local $TimerDiff1 = TimerDiff($BuffTimer1)
		Local $CoSeKey1 = String($BuffKey1)
		If $TimerDiff1 > $BuffCD1 Then
			SetGUIStatus(StringFormat("Using Buff 1 ", $BuffCD1 / 60000))
			CoSe($CoSeKey1)
			Sleep(1500)
			$BuffTimer1 = TimerInit()
		Else
		;SetGUIStatus("Buff1 Cooldown(" & $BuffCD1 / 60000 & "m): " & Round(($BuffCD1 - $TimerDiff1) / 60000, 1) & "m left.")
		EndIf
	EndIf

	If $Buff2Enable = True Then
		Local Static $BuffTimer2 = TimerInit()
		If $BuffCD2 = 0 Then $BuffTimer2 = 0
		$BuffCD2 *= 60000
		Local $TimerDiff2 = TimerDiff($BuffTimer2)

		Local $CoSeKey2 = String($BuffKey2)
		If $TimerDiff2 > $BuffCD2 Then
			SetGUIStatus(StringFormat("Using Buff 2 ", $BuffCD2 / 60000))
			CoSe($CoSeKey2)
			Sleep(1500)
			$BuffTimer2 = TimerInit()
			Return True
		Else
			;SetGUIStatus("Buff2 Cooldown(" & $BuffCD2 / 60000 & "m): " & Round(($BuffCD2 - $TimerDiff2) / 60000, 1) & "m left.")
			Return False
		EndIf

	EndIf

EndFunc   ;==>Buff

Func VMouse($x, $y, $clicks = 0, $button = "left", $speed = 10)
	If Not VisibleCursor() Then CoSe("{LCTRL}")
	If $clicks > 0 Then
		StealthMouseClick($button, $x, $y, $clicks, $speed)
	Else
		StealthMouseMove($x, $y, $speed)
	EndIf
EndFunc   ;==>VMouse

Func ProductionActivityCheck() ; Adpated
	Local Const $Processing_Hammer = "res/processing_hammer_uno.png"
	Local $IS, $x, $y
	GSleep(500)
	$IS = _ImageSearchArea($Processing_Hammer, 1, $ResOffset[0], $ResOffset[1], $ResOffset[2], $ResOffset[3], $x, $y, 50, 0)
	If $IS = True Then Return False
	While $Processing
		$IS = _ImageSearchArea($Processing_Hammer, 1, $ResOffset[0], $ResOffset[1], $ResOffset[2], $ResOffset[3], $x, $y, 50, 0)
		If $IS = True Then Return True
		GSleep(500)
	WEnd
	Return False
EndFunc   ;==>ProductionActivityCheck

InitGUI()
ObfuscateTitle($Form1)
While 1
	CheckGUI()
WEnd

Func RemLineLogWindow()
	$blahvsar1=ControlGetText($newtitle,"","Edit57");
	While(StringLen($blahvsar1) > $MaxLogCharsInLogwindow)
	  $blahvsar1=StringTrimLeft($blahvsar1,StringInStr($blahvsar1, @CRLF));
	WEnd
	$blahvsar2=ControlSetText($newtitle,"","Edit57",$blahvsar1);
EndFunc

Func CleadLogWindow()
	$blahvsar=ControlSetText($newtitle,"","Edit57","");
	_GUICtrlEdit_AppendText($ELog, @HOUR & ":" & @MIN & " > " &  "Log Cleared..." & @CRLF)
EndFunc

Func StealthMouseMove($mx, $my, $ms = 50)
	MouseMove($mx + random(0,5,1) - random(0,5,1), $my + random(0,5,1) - random(0,5,1), $ms + random(0,20,1) - random(0,20,1))
EndFunc

Func StealthMouseClick($mb, $mx, $my, $mc=1, $ms=4)
	MouseClick($mb, $mx + random(0,5,1) - random(0,5,1), $my + random(0,5,1) - random(0,5,1), $mc, $ms + random(0,3,1) - random(0,3,1))
EndFunc
