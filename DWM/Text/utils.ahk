;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Active Window Switcher
;;;;;;;;;;;;;;;;;;;;;;;;;;;

Gui +LastFound 
hWnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,Hwnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage" )
Return

ShellMessage( wParam,lParam )
{
	WinGetTitle, title, ahk_id %lParam% 

		FileRead, Contents, active.inc
		if not ErrorLevel
		{
			FileDelete, active.inc
			FileAppend, [Variables]`nactive = "%title%", active.inc
		}
	SendMessage, 0x111, 4001,,, ahk_class RainmeterMeterWindow
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Waits for input, then changes the workspace accordingly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

currentWorkspace := 1

!Right::

	Send !{Right}

	currentWorkspace := currentWorkspace + 1
	workspaceToFind := currentWorkspace - 1
	
	if currentWorkspace >= 4
	{
		currentWorkspace :=1
		workspaceToFind := 3
	}

	FileRead, Contents, workspace.inc
	if not ErrorLevel
	{
		StringReplace, NewContents, Contents, %workspaceToFind%, %currentWorkspace%, All
		FileDelete, workspace.inc
		FileAppend, %NewContents%, workspace.inc
	}
	SendMessage, 0x111, 4001,,, ahk_class RainmeterMeterWindow

return

!Left::

	Send !{Left}

	currentWorkspace := currentWorkspace - 1
	workspaceToFind := currentWorkspace + 1
	
	if currentWorkspace <= 0
	{
		currentWorkspace :=3
		workspaceToFind := 1
	}

	FileRead, Contents, workspace.inc
	if not ErrorLevel
	{
		StringReplace, NewContents, Contents, %workspaceToFind%, %currentWorkspace%, All
		FileDelete, workspace.inc
		FileAppend, %NewContents%, workspace.inc
	}
	SendMessage, 0x111, 4001,,, ahk_class RainmeterMeterWindow


return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Shift through active windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

NumpadAdd::
	send {LAlt down}
	send {Esc}
	send {LAlt up}
return

; Hide completely task bar
; Paste this line to your autohotkey then press <Windows> + H to toggle your taskbar
; Credit to the original author in autohotkey forum :)
LWin & h::
if toggle := !toggle
{
  WinHide ahk_class Shell_TrayWnd
  WinHide Start ahk_class Button
}
else
{
  WinShow ahk_class Shell_TrayWnd
  WinShow Start ahk_class Button
}
returng