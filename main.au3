#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.10.2
 Author:         Knut Wehr

 Script Function:
	Sicherung von Ordnern an einem anderen Speicherort. Kopiert
	Ordnerinhalt an anderen Ort und hält Vorgängerstand ebenfalls
	bereit. Konfiguration mittels ini Datei.

#ce ----------------------------------------------------------------------------
#incluinclude <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <FileConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=c:\users\woxwek0\desktop\development\autoit3\sicherapp\uisichapp.kxf
$uiSichApp = GUICreate("SichApp V1.0", 299, 53, 192, 124)
$btnSichern = GUICtrlCreateButton("Sichern", 16, 8, 265, 33)
$paths = ""
$destPath = ""

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Func readIniValues()
	$paths = IniRead("settings.ini","Folders","savePaths","")
	$destPath = IniRead("settings.ini","Folders","destPath","")
EndFunc

Func getFolderName($cmplPath)
	$tmp = StringSplit($cmplPath, "\")
	Return $tmp[$tmp[0]]
EndFunc


While 1

	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btnSichern
			readIniValues()
			$arrPaths = StringSplit($paths,";")
			If FileExists($destPath & "\aktuell") Then
				If FileExists($destPath & "\archiv") Then
					DirRemove($destPath & "\archiv",1)
					DirCopy($destPath & "\aktuell", $destPath & "\archiv")
				Else
					DirCopy($destPath & "\aktuell", $destPath & "\archiv")
				EndIf
			DirRemove($destPath & "\aktuell",1)
			EndIf
			For $i = 1 To $arrPaths[0]
				$p = $arrPaths[$i]
				DirCopy($p, $destPath & "\aktuell\" & getFolderName($p))
			Next
			MsgBox(0, "Ergebnis", "Erfolgreich gesichert!")
	EndSwitch
WEnd


