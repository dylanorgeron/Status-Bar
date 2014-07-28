Gui +LastFound 
hWnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,Hwnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage" )
Return

ShellMessage( wParam,lParam )
{
 WinGetTitle, title, ahk_id %lParam%
 If (wParam=4) { 

	FileRead, Contents, active.inc
	if not ErrorLevel
	{
		
		FileDelete, active.inc
		FileAppend, [Variables]`nactive = "%title%", active.inc
	}
	SendMessage, 0x111, 4001,,, ahk_class RainmeterMeterWindow

 }
}