1 REM ******************************
2 REM * DMTF GAMEPAD CPC           *
3 REM * ackerman JJ  GROUP SLIDERS *
4 REM ******************************
5 CLS:bU=1:bD=2:bL=4:bR=8:bF1=16
10 d=JOY(0)
15 IF (d AND bU)=bU THEN q4=1 ELSE q4=0
20 IF (d AND bD)=bD THEN q1=1 ELSE q1=0
25 IF (d AND bL)=bL THEN q2=1 ELSE q2=0
30 IF (d AND bR)=bR THEN stq=1 ELSE stq=0
35 IF (d AND bF1)=bF1 THEN q3=1 ELSE q3=0
50 dato=q1+(q2*2)+(q3*4)+(q4*8)
70 IF dato>0 AND dato<10 THEN dtmf=48+dato
75 IF dato=10 THEN dtmf=48
80 IF dato=11 THEN dtmf=42
85 IF dato=12 THEN dtmf=35
87 IF dato>12 AND dato<16 THEN dtmf=52+dato
88 IF dato=0 THEN dtmf=68
90 LOCATE 1,1:PRINT d;" ";dato;"   "
92 LOCATE 1,3:PRINT stq;q4;q3;q2;q1
95 LOCATE 1,4:PRINT "DTMF ";CHR$(dtmf):GOTO 10