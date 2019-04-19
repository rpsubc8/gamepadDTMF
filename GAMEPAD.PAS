USES Crt;
(*Mapeo
  MT8870   Joystick
   STQ       3
   Q4        2
   Q3        1
   Q2        abajo
   Q1        derecha
*)
{---------------------------------------------------------------------------}
FUNCTION JOYPRESENT:Boolean;
VAR b:byte;
BEGIN
 b:=0;
 asm
  mov ah,$84
  mov dx,0
  int 15h
  jnc @prs
  mov b,$ff
  @prs:
 end;
 joypresent:=b=0;
END;
(*  Buttons AND 16 = 0 dann ist 1. Knopf vom 1.Joy gedrueckt *)
(*  Buttons AND 32 = 0 dann ist 2. Knopf vom 1.Joy gedrueckt *)
(*  Buttons AND 64 = 0 dann ist 1. Knopf vom 2.Joy gedrueckt *)
(*  Buttons AND 128= 0 dann ist 2. Knopf vom 2.Joy gedrueckt *)
PROCEDURE JOYINFO(var X1,Y1,X2,Y2:integer; var buttons:byte);
VAR x1b,y1b,x2b,y2b:integer;
    bs:byte;
BEGIN
 asm
  mov dx,0
  mov ah,$84
  int 15h
  mov bs,al

  mov dx,1
  mov ah,$84
  int 15h
  mov x1b,ax
  mov y1b,bx
  mov x2b,cx
  mov y2b,dx
 end;
 x1:=x1b;
 y1:=y1b;
 x2:=x2b;
 y2:=y2b;
 buttons:=bs;
END;
{---------------------------------------------------------------------------}
FUNCTION binToDTMF(value:byte):char;
VAR
 aReturn: char;
BEGIN
 aReturn:=' ';
 case value of
  0: aReturn:='D';
  1: aReturn:='1';
  2: aReturn:='2';
  3: aReturn:='3';
  4: aReturn:='4';
  5: aReturn:='5';
  6: aReturn:='6';
  7: aReturn:='7';
  8: aReturn:='8';
  9: aReturn:='9';
  10: aReturn:='0';
  11: aReturn:='*';
  12: aReturn:='#';
  13: aReturn:='A';
  14: aReturn:='B';
  15: aReturn:='C';
  else
   aReturn:=' ';
 end;
 binToDTMF:=aReturn;
END;
{---------------------------------------------------------------------------}
VAR
 x1,y1,x2,y2:integer;
 buttons:byte;
 aux:integer;
 STQ,Q4,Q3,Q2,Q1:byte;
 STQantes:byte;
BEGIN
 STQantes:=0;
 clrscr;
 IF (JOYPRESENT=TRUE) THEN
  BEGIN
   WRITELN('GAMEPAD');
   REPEAT
    JOYINFO(x1,y1,x2,y2,buttons);
    (*gotoxy(1,4); WRITE('                                       ');
    gotoxy(1,4);WRITE(buttons);WRITE(' ');
    WRITE(x1);WRITE(' ');WRITE(x2);WRITE(' ');
    WRITE(y1);WRITE(' ');WRITE(y2);
    gotoxy(1,6); WRITE('                                       ');
    gotoxy(1,6);*)

    IF (x1>130) THEN Q2:=1 ELSE Q2:=0;
    IF (y1>130) THEN Q3:=1 ELSE Q3:=0;
    Q1:=(buttons and 16)SHR 4;
    Q4:=(buttons and 32)SHR 5;
    STQ:=(buttons and 64)SHR 6;
    if (q1=0) then q1:=1 else q1:=0;
    if (q4=0) then q4:=1 else q4:=0;
    if (stq=0) then stq:=1 else stq:=0;
    (*WRITE(STQ);
    WRITE(Q4);
    WRITE(Q3);
    WRITE(Q2);
    WRITE(Q1);*)
    IF (STQ<>STQantes) then
     BEGIN
      STQantes:=stq;
      IF (STQ=1) THEN
       BEGIN
        aux:= q1+(q2 SHL 1)+(q3 SHL 2)+(q4 SHL 3);
        WRITE(binToDTMF(aux));
       END;
     END;
    {delay(50);}
   UNTIL (keypressed);
  END
 ELSE
  WRITE('NO GAMEPAD');
 readln;
END.
