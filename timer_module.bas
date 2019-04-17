Attribute VB_Name = "timer_module"
Option Explicit


Public callbackClassRef  As cJoy
 
Sub TimerProc(ByVal hwnd As Long, ByVal nIDEvent As Long, ByVal uElapse As Long, ByVal lpTimerFunc As Long)
  On Error Resume Next
  Call callbackClassRef.friend_JoyStick_GetPos
End Sub
