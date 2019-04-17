VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cJoy"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Const MAXPNAMELEN = 32  ' Max Product Name Length (Including NULL)
Private Const MAXOEMVXD = 160

'-- JoyStick ID Constants.
Public Enum enJoyNum
    JOYSTICKID1 = 0
    JOYSTICKID2 = 1
End Enum

'-- JoyStick Flag Constants.
Private Const JOY_CAL_READ3 = &H40000
Private Const JOY_CAL_READ4 = &H80000
Private Const JOY_CAL_READ5 = &H400000
Private Const JOY_CAL_READ6 = &H800000
Private Const JOY_CAL_READALWAYS = &H10000
Private Const JOY_CAL_READRONLY = &H2000000
Private Const JOY_CAL_READUONLY = &H4000000
Private Const JOY_CAL_READVONLY = &H8000000
Private Const JOY_CAL_READXONLY = &H100000
Private Const JOY_CAL_READXYONLY = &H20000
Private Const JOY_CAL_READYONLY = &H200000
Private Const JOY_CAL_READZONLY = &H1000000
Private Const JOY_POVBACKWARD = 18000
Private Const JOY_POVCENTERED = -1
Private Const JOY_POVFORWARD = 0
Private Const JOY_POVLEFT = 27000
Private Const JOY_POVRIGHT = 9000
Private Const JOY_RETURNBUTTONS = &H80&
Private Const JOY_RETURNCENTERED = &H400&
Private Const JOY_RETURNPOV = &H40&
Private Const JOY_RETURNPOVCTS = &H200&
Private Const JOY_RETURNR = &H8&
Private Const JOY_RETURNRAWDATA = &H100&
Private Const JOY_RETURNU = &H10         '  Axis 5
Private Const JOY_RETURNV = &H20         '  Axis 6
Private Const JOY_RETURNX = &H1&
Private Const JOY_RETURNY = &H2&
Private Const JOY_RETURNZ = &H4&
Private Const JOY_USEDEADZONE = &H800&
Private Const JOY_RETURNALL = (JOY_RETURNX Or JOY_RETURNY Or JOY_RETURNZ Or JOY_RETURNR Or JOY_RETURNU Or JOY_RETURNV Or JOY_RETURNPOV Or JOY_RETURNBUTTONS)

'-- JoyStick Error Constants.
Private Const JOYERR_BASE = 160                    ' Error Base
Private Const JOYERR_NOCANDO = (JOYERR_BASE + 6)   ' Request Not Completed
Private Const JOYERR_NOERROR = (0)                 ' No Error
Private Const JOYERR_PARMS = (JOYERR_BASE + 5)     ' Bad Parameters
Private Const JOYERR_UNPLUGGED = (JOYERR_BASE + 7) ' JoyStick Is Unplugged

'-- JOYCAPS User Defined Type.
Private Type JOYCAPS
    wMid            As Integer  ' Manufacturer Identifier.
    wPid            As Integer  ' Product Identifier.
    szPname         As String * MAXPNAMELEN ' Null Terminated String     JoyStick Product Name.
    wXmin           As Long     ' Minimum X-coordinate.
    wXmax           As Long     ' Maximum X-coordinate.
    wYmin           As Long     ' Minimum Y-coordinate.
    wYmax           As Long     ' Maximum Y-coordinate.
    wZmin           As Long     ' Minimum Z-coordinate.
    wZmax           As Long     ' Maximum Z-coordinate.
    wNumButtons     As Long     ' Number Of JoyStick Buttons.
    wPeriodMin      As Long     ' Smallest Polling Frequency Supported By  JoySetCapture.
    wPeriodMax      As Long     ' Largest Polling Frequency Supported ByJoySetCapture.
    wRmin           As Long     ' Minimum Rudder Value. The Rudder Is A Fourth    Axis Movement.
    wRmax           As Long     ' Maximum Rudder Value. The Rudder Is A Fourth Axis Movement.
    wUmin           As Long     ' Minimum U-coordinate (Fifth Axis) Values.
    wUmax           As Long     ' Maximum U-coordinate (Fifth Axis) Values.
    wVmin           As Long     ' Minimum V-coordinate (Sixth Axis) Values.
    wVmax           As Long     ' Maximum V-coordinate (Sixth Axis) Values.
    wCaps           As Long     ' JoyStick Capabilities.  Note: See JoyCaps   Flags Below...
    wMaxAxes        As Long     ' Maximum Number Of Axes Supported By JoyStick.
    wNumAxes        As Long     ' Number Of Axes Currently In Use By JoyStick.
    wMaxButtons     As Long     ' Maximum Number Of Buttons Supported By The    JoyStick.
    szRegKey        As String * MAXPNAMELEN ' Null-Terminated String Containing   The Registry Key.
    szOEMVxD        As String * MAXOEMVXD ' Null-Terminated String Identifying   The JoyStick Driver OEM.
End Type
Private typeJoyCaps As JOYCAPS

 
Private Type JOYINFOEX
    dwSize          As Long     ' Size, In Bytes, Of This User Defined Type.
    dwFlags         As Long     ' Flags See Below: JOYINFOEX Flags.
    dwXpos          As Long     ' Current X-coordinate.
    dwYpos          As Long     ' Current Y-coordinate.
    dwZpos          As Long     ' Current Z-coordinate.
    dwRpos          As Long     ' Current Position Of The Rudder Or Fourth JoyStick Axis.
    dwUpos          As Long     ' Current Fifth Axis Position.
    dwVpos          As Long     ' Current Sixth Axis Position.
    dwButtons       As Long     ' Current State Of The 32 JoyStick Buttons.
    dwButtonNumber  As Long     ' Current Button Number That Is Pressed.
    dwPOV           As Long     ' Current Position Of The Point-Of-View Control.
    dwReserved1     As Long     ' Reserved; Do Not Use.
    dwReserved2     As Long     ' Reserved; Do Not Use.
End Type
Private typeJoyInfo As JOYINFOEX

'-- for error return info
Private Const MOD_NAME = "cJoy."

'-- for turning of the timer
Private lTimerID         As Long

'-- store the joystick number used
Private m_ActiveJoyNum   As Long

'-- JoyStick API Declarations.
Private Declare Function joyGetDevCaps Lib "winmm.dll" Alias "joyGetDevCapsA" (ByVal id As Long, lpCaps As JOYCAPS, ByVal uSize As Long) As Long
Private Declare Function joyGetNumDevs Lib "winmm.dll" () As Long
Private Declare Function joyGetPosEx Lib "winmm.dll" (ByVal uJoyID As Long, pji As JOYINFOEX) As Long
Private Declare Function joyGetThreshold Lib "winmm.dll" (ByVal id As Long, lpuThreshold As Long) As Long
Private Declare Function joyReleaseCapture Lib "winmm.dll" (ByVal id As Long) As Long
Private Declare Function joySetCapture Lib "winmm.dll" (ByVal hwnd As Long, ByVal uID As Long, ByVal uPeriod As Long, ByVal bChanged As Long) As Long
Private Declare Function joySetThreshold Lib "winmm.dll" (ByVal id As Long, ByVal uThreshold As Long) As Long
Private Declare Function SetTimer Lib "user32" (ByVal hwnd As Long, ByVal nIDEvent As Long, ByVal uElapse As Long, ByVal lpTimerFunc As Long) As Long
Private Declare Function KillTimer Lib "user32" (ByVal hwnd As Long, ByVal nIDEvent As Long) As Long


Event JoyInfo(BtnPressed&, leftStickX&, leftStickY&, rightStickX&, rightStickY&, DpadPos&)
Event JoyError(sErrMessage$)

'-- this function must be called first to make sure we
'-- have a valid joystick installed properly on the system
Function IsJoystick1_Valid() As Boolean
  '-- temp assign val 0 to [m_activeJoyNum] just to test if valid
  m_ActiveJoyNum = JOYSTICKID1
  IsJoystick1_Valid = friend_JoyStick_GetPos()
  m_ActiveJoyNum = -1
End Function
Function IsJoystick2_Valid() As Boolean
  '-- temp assign val 1 to [m_activeJoyNum] just to test if valid
  m_ActiveJoyNum = JOYSTICKID2
  IsJoystick2_Valid = friend_JoyStick_GetPos()
  m_ActiveJoyNum = -1
End Function

Sub Start_JoyMonitor(validJoystickNum As enJoyNum)
On Error GoTo local_error:
  
  m_ActiveJoyNum = validJoystickNum
  
  '-- double check to make the user is supplying a valid JS number
  If friend_JoyStick_GetPos() = True Then
     If lTimerID = 0 Then
       '-- this timer calls friend_JoyStick_GetPos which raises the
       '-- [JoyInfo] event providing you with everything you need to know
       'lTimerID = SetTimer(0&, 0&, 25, AddressOf TimerProc)
       lTimerID = SetTimer(0&, 0&, 1, AddressOf TimerProc) 'Cada 1 milisegundo
       Set timer_module.callbackClassRef = Me
     End If
  End If
  
Exit Sub
local_error:
    RaiseEvent JoyError(MOD_NAME & "Initialize_JoyInfo: " & Err.Description)
End Sub
Sub End_JoyMonitor()
On Error Resume Next
   
   Call KillTimer(0&, lTimerID)
   m_ActiveJoyNum = 0
   Set timer_module.callbackClassRef = Nothing
End Sub

Friend Function friend_JoyStick_GetPos() As Boolean
Dim lRtn  As Long
Dim lSize As Long
On Error GoTo local_error:


With typeJoyInfo
    
    '-- no point continuing if invalid joystick num supplied
    If m_ActiveJoyNum <> 0 And m_ActiveJoyNum <> 1 Then
       RaiseEvent JoyError("invalid joystick number provided. must be 0 or 1")
       Exit Function
    End If
    
    '-- Size Of User Defined Type
    lSize = Len(typeJoyInfo)
    .dwSize = lSize
    '-- Set Flag To Return All current joystick info
    .dwFlags = JOY_RETURNALL

    '-- Get JotStick Position
    lRtn = joyGetPosEx(m_ActiveJoyNum, typeJoyInfo)
    
    '-- Check For An Error
    If lRtn <> JOYERR_NOERROR Then
        Dim sVal  As String
        '-- convert lng error val to string and return with event
        sVal = Switch(lRtn = JOYERR_PARMS, "Bad Joystick Parameters", _
                      lRtn = JOYERR_NOCANDO, "General Joystick Error", _
                      lRtn = JOYERR_UNPLUGGED, "Joystick Unplugged")
        friend_JoyStick_GetPos = False
        RaiseEvent JoyError(sVal)
    Else
       friend_JoyStick_GetPos = True
       '-- return all the joystick current state info
       RaiseEvent JoyInfo(.dwButtons, .dwXpos, .dwYpos, .dwRpos, .dwZpos, .dwPOV)
    End If
    
End With

Exit Function
local_error:
    RaiseEvent JoyError(MOD_NAME & "Initialize_JoyInfo: " & Err.Description)
End Function
 
Private Sub Class_Terminate()
   On Error Resume Next
   Call End_JoyMonitor
End Sub
