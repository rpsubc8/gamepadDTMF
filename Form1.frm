VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Form1"
   ClientHeight    =   4680
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   11160
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4680
   ScaleWidth      =   11160
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton btnClear 
      Caption         =   "Clear"
      Height          =   375
      Left            =   9840
      TabIndex        =   20
      Top             =   120
      Width           =   975
   End
   Begin VB.ComboBox cmbQ1 
      Height          =   315
      ItemData        =   "Form1.frx":0000
      Left            =   6240
      List            =   "Form1.frx":006A
      TabIndex        =   19
      Text            =   "9"
      Top             =   1560
      Width           =   1215
   End
   Begin VB.ComboBox cmbQ2 
      Height          =   315
      ItemData        =   "Form1.frx":00F6
      Left            =   6240
      List            =   "Form1.frx":0160
      TabIndex        =   18
      Text            =   "Y1"
      Top             =   1200
      Width           =   1215
   End
   Begin VB.ComboBox cmbQ3 
      Height          =   315
      ItemData        =   "Form1.frx":01EC
      Left            =   6240
      List            =   "Form1.frx":0256
      TabIndex        =   17
      Text            =   "X1"
      Top             =   840
      Width           =   1215
   End
   Begin VB.ComboBox cmbQ4 
      Height          =   315
      ItemData        =   "Form1.frx":02E2
      Left            =   6240
      List            =   "Form1.frx":034C
      TabIndex        =   16
      Text            =   "01"
      Top             =   480
      Width           =   1215
   End
   Begin VB.ComboBox cmbSTQ 
      Height          =   315
      ItemData        =   "Form1.frx":03D8
      Left            =   6240
      List            =   "Form1.frx":0424
      TabIndex        =   15
      Text            =   "10"
      Top             =   120
      Width           =   1215
   End
   Begin VB.TextBox logDTMF 
      Height          =   1935
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   14
      Top             =   2640
      Width           =   11055
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Start joystick"
      Height          =   375
      Index           =   1
      Left            =   0
      TabIndex        =   1
      Top             =   495
      Width           =   1500
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Find valid joystick"
      Height          =   375
      Index           =   0
      Left            =   0
      TabIndex        =   0
      Top             =   120
      Width           =   1500
   End
   Begin VB.Label lblQ1 
      Caption         =   "Q1"
      Height          =   255
      Left            =   5520
      TabIndex        =   13
      Top             =   1560
      Width           =   615
   End
   Begin VB.Label lblQ2 
      Caption         =   "Q2"
      Height          =   375
      Left            =   5520
      TabIndex        =   12
      Top             =   1200
      Width           =   615
   End
   Begin VB.Label lblQ3 
      Caption         =   "Q3"
      Height          =   255
      Left            =   5520
      TabIndex        =   11
      Top             =   840
      Width           =   615
   End
   Begin VB.Label lblQ4 
      Caption         =   "Q4"
      Height          =   255
      Left            =   5520
      TabIndex        =   10
      Top             =   480
      Width           =   615
   End
   Begin VB.Label lblSTQ 
      Caption         =   "STQ"
      Height          =   255
      Left            =   5520
      TabIndex        =   9
      Top             =   120
      Width           =   615
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "X"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF00FF&
      Height          =   285
      Index           =   3
      Left            =   1560
      TabIndex        =   8
      Top             =   1080
      Width           =   3435
   End
   Begin VB.Label lblBotones 
      BeginProperty Font 
         Name            =   "Lucida Console"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   0
      TabIndex        =   7
      Top             =   2040
      Width           =   11175
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "X"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF00FF&
      Height          =   285
      Index           =   5
      Left            =   1575
      TabIndex        =   6
      Top             =   1665
      Width           =   3075
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "X"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF00FF&
      Height          =   285
      Index           =   4
      Left            =   1575
      TabIndex        =   5
      Top             =   1350
      Width           =   3075
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "X"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF00FF&
      Height          =   285
      Index           =   2
      Left            =   1575
      TabIndex        =   4
      Top             =   741
      Width           =   3075
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "X"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF00FF&
      Height          =   285
      Index           =   1
      Left            =   1575
      TabIndex        =   3
      Top             =   438
      Width           =   3075
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "X"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF00FF&
      Height          =   285
      Index           =   0
      Left            =   1575
      TabIndex        =   2
      Top             =   135
      Width           =   3435
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Conversor Gamepad HID a DTMF
'Autor: Jaime Jose Gavin Sierra (ackerman)
'EA1HLX
'Convierte los tonos DTMF con el modulo MT8870 a los botones del gamepad
'He partido de codigo de lectura de botones dejoystick en VB6 (no venia el nombre
'del autor) y he modificado para que se puede usar la conversion de DTMF a botones
'Es una prueba de concepto rapida en VB para que puede ser usada desde W95 en
'adelante. Siguiendo mismo concepto se puede hacer el port a HTML5 y sistemas
'retro como MSDOS.
'Se puede usar el generador de tonos
'http://mamclain.com/?page=RND_SOFTWARE_DTMF_WEB_APP
'Poner 500 milis de duracion de espera entre digitos.
'No esta optimizado. He puesto el timer de 1 milisegundo

Option Explicit

Dim cadLogDTMF As String
Dim stqAntes As Integer


Private WithEvents cJoy As cJoy
Attribute cJoy.VB_VarHelpID = -1

Private Sub btnClear_Click()
 cadLogDTMF = ""
 logDTMF.Text = ""
End Sub

Private Sub cJoy_JoyError(sErrMessage As String)
'
 Debug.Print sErrMessage
End Sub

Public Function binDTMFtoString(value As Integer) As String
 Dim aReturn As String
 aReturn = ""
 Select Case value
  Case 1: aReturn = "1"
  Case 2: aReturn = "2"
  Case 3: aReturn = "3"
  Case 4: aReturn = "4"
  Case 5: aReturn = "5"
  Case 6: aReturn = "6"
  Case 7: aReturn = "7"
  Case 8: aReturn = "8"
  Case 9: aReturn = "9"
  Case 10: aReturn = "0"
  Case 11: aReturn = "*"
  Case 12: aReturn = "#"
  Case 13: aReturn = "A"
  Case 14: aReturn = "B"
  Case 15: aReturn = "C"
  Case 0: aReturn = "D"
  Case Else
    aReturn = ""
 End Select
 binDTMFtoString = aReturn
End Function

'-- event raised from cJoy which is called every 25 milliseconds
'-- from timer_module and report all the joystick info we need
Private Sub cJoy_JoyInfo(BtnPressed As Long, leftStickX As Long, _
                         leftStickY As Long, rightStickX As Long, _
                         rightStickY As Long, DpadPos As Long)
 Dim valor As Integer
 Dim cad As String
 Dim i As Integer
 Dim mask As Long
 Dim pinSTQ, pinQ4, pinQ3, pinQ2, pinQ1 As Integer
 Dim stq, q4, q3, q2, q1 As Integer
 Dim auxBit As Integer
 cad = "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 Y1 X1" & Chr(10) & Chr(13)
 'If BtnPressed And &H80000000 <> 0 Then
   'Debug.Print "Button 32 pressed"
   'cad = "Button 32 pressed"
 'End If
 'mask = &H40000000
 pinSTQ = -1
 pinSTQ = Val(cmbSTQ.Text)
 pinQ4 = -1
 If (cmbQ4.Text = "X1") Then
  If (leftStickX > 33768) Then
   q4 = 1
  Else
   q4 = 0
  End If
 Else
  If (cmbQ4.Text = "Y1") Then
   If (leftStickY > 33768) Then
    q4 = 1
   Else
    q4 = 0
   End If
  Else
   pinQ4 = Val(cmbQ4.Text)
  End If
 End If

 pinQ3 = -1
 If (cmbQ3.Text = "X1") Then
  If (leftStickX > 33768) Then
   q3 = 1
  Else
   q3 = 0
  End If
 Else
  If (cmbQ3.Text = "Y1") Then
   If (leftStickY > 33768) Then
    q3 = 1
   Else
    q3 = 0
   End If
  Else
   pinQ3 = Val(cmbQ3.Text)
  End If
 End If
 
 pinQ2 = -1
 If (cmbQ2.Text = "X1") Then
  If (leftStickX > 33768) Then
   q2 = 1
  Else
   q2 = 0
  End If
 Else
  If (cmbQ2.Text = "Y1") Then
   If (leftStickY > 33768) Then
    q2 = 1
   Else
    q2 = 0
   End If
  Else
   pinQ2 = Val(cmbQ2.Text)
  End If
 End If

 pinQ1 = -1
 If (cmbQ1.Text = "X1") Then
  If (leftStickX > 33768) Then
   q1 = 1
  Else
   q1 = 0
  End If
 Else
  If (cmbQ1.Text = "Y1") Then
   If (leftStickY > 33768) Then
    q1 = 1
   Else
    q1 = 0
   End If
  Else
   pinQ1 = Val(cmbQ1.Text)
  End If
 End If


 mask = 1
 'For i = 32 To 1 Step -1
 For i = 1 To 24 Step 1
  If ((BtnPressed And mask) <> 0) Then
   'Debug.Print "Button "; i; "pressed"
   cad = cad & " 1 "
   auxBit = 1
  Else
   cad = cad & " 0 "
   auxBit = 0
  End If
  'mask = mask / 2
  mask = mask * 2
  If (i = pinSTQ) Then
   stq = auxBit
  End If
  If (i = pinQ4) Then
   q4 = auxBit
  End If
  If (i = pinQ3) Then
   q3 = auxBit
  End If
  If (i = pinQ2) Then
   q2 = auxBit
  End If
  If (i = pinQ1) Then
   q1 = auxBit
  End If
 Next
 If (leftStickX > 33768) Then
  cad = cad & " 1 "
 Else
  cad = cad & " 0 "
 End If
 If (leftStickY > 32768) Then
  cad = cad & " 1 "
 Else
  cad = cad & " 0 "
 End If
 If (stq <> stqAntes) Then
  stqAntes = stq
  If (stq = 1) Then
   valor = q1 + (q2 * 2) + (q3 * 4) + (q4 * 8)
   cadLogDTMF = cadLogDTMF & binDTMFtoString(valor)
   logDTMF.Text = cadLogDTMF
  End If
 End If

 lblBotones = cad
 Label1(0) = "BUTTON PRESSED: " & BtnPressed
 Label1(1) = "LEFT JOYSTICK X POS: " & leftStickX
 Label1(2) = "LEFT JOYSTICK y POS: " & leftStickY
 Label1(3) = "RIGHT JOYSTICK X POS: " & rightStickX
 Label1(4) = "RIGHT JOYSTICK y POS: " & rightStickY
 Label1(5) = "D-PAD POSITION: " & DpadPos
End Sub

Private Sub Command1_Click(Index As Integer)
  Dim sMod As String
  
  If Index = 0 Then '-- find a valid joystick
     '-- test joystick 1 and report
     sMod = IIf(cJoy.IsJoystick1_Valid = True, " ", "NOT ")
     MsgBox "Joystick #1 is " & sMod & "a valid joystick"
      '-- test joystick 2 and report
     sMod = IIf(cJoy.IsJoystick2_Valid = True, " ", "NOT ")
     MsgBox "Joystick #2 is " & sMod & "a valid joystick"
  ElseIf Index = 1 Then
     '-- on MY computer joystick #2 is the valid 1
     '-- on your system it might be different so make
     '-- sure you enter the right number
     cJoy.Start_JoyMonitor JOYSTICKID1
  End If
End Sub

Private Sub Form_Load()
  Set cJoy = New cJoy
  cadLogDTMF = ""
  stqAntes = 0
End Sub
Private Sub Form_Unload(Cancel As Integer)
  Set cJoy = Nothing
End Sub
 
Private Sub Label4_Click()

End Sub

