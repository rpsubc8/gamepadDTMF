// Arduino USB Joystick HID demo
// Author: Darran Hunt
// Released into the public domain.
// Mod Jaime Jose Gavin Sierra
// DTMF MT8870 pin to gamepad buttons


#define pin_dtmf_stq 2
#define pin_dtmf_q4 3
#define pin_dtmf_q3 4
#define pin_dtmf_q2 5
#define pin_dtmf_q1 6

#define pad_stq 9
#define pad_q4 0
#define pad_q3 1
#define pad_q2 2
#define pad_q1 8

bool senddata=false;
byte stq_antes,q4_antes,q3_antes,q2_antes,q1_antes;
byte stq,q4,q3,q2,q1;

#undef DEBUG

#define NUM_BUTTONS	40
#define NUM_AXES	8	       // 8 axes, X, Y, Z, etc

typedef struct joyReport_t {
    int16_t axis[NUM_AXES];
    uint8_t button[(NUM_BUTTONS+7)/8]; // 8 buttons per byte
} joyReport_t;

joyReport_t joyReport;


void setup(void);
void loop(void);
void setButton(joyReport_t *joy, uint8_t button);
void clearButton(joyReport_t *joy, uint8_t button);
void sendJoyReport(joyReport_t *report);


void setup() 
{
    pinMode(pin_dtmf_stq, INPUT);
    pinMode(pin_dtmf_q4, INPUT);
    pinMode(pin_dtmf_q3, INPUT);
    pinMode(pin_dtmf_q2, INPUT);
    pinMode(pin_dtmf_q1, INPUT);                    

    stq_antes=digitalRead(pin_dtmf_stq);
    q4_antes=digitalRead(pin_dtmf_q4);
    q3_antes=digitalRead(pin_dtmf_q3);
    q2_antes=digitalRead(pin_dtmf_q2);
    q1_antes=digitalRead(pin_dtmf_q1);
    stq=stq_antes;
    q4=q4_antes;
    q3=q3_antes;
    q2=q2_antes;
    q1=q1_antes;    
  
    Serial.begin(115200);
    delay(200);

    for (uint8_t ind=0; ind<8; ind++) {
	joyReport.axis[ind] = ind*1000;
    }
    for (uint8_t ind=0; ind<sizeof(joyReport.button); ind++) {
        joyReport.button[ind] = 0;
    }
}

// Send an HID report to the USB interface
void sendJoyReport(struct joyReport_t *report)
{
#ifndef DEBUG
    Serial.write((uint8_t *)report, sizeof(joyReport_t));
#else
    // dump human readable output for debugging
    for (uint8_t ind=0; ind<NUM_AXES; ind++) {
	Serial.print("axis[");
	Serial.print(ind);
	Serial.print("]= ");
	Serial.print(report->axis[ind]);
	Serial.print(" ");
    }
    Serial.println();
    for (uint8_t ind=0; ind<NUM_BUTTONS/8; ind++) {
	Serial.print("button[");
	Serial.print(ind);
	Serial.print("]= ");
	Serial.print(report->button[ind], HEX);
	Serial.print(" ");
    }
    Serial.println();
#endif
}

// turn a button on
void setButton(joyReport_t *joy, uint8_t button)
{
    uint8_t index = button/8;
    uint8_t bit = button - 8*index;

    joy->button[index] |= 1 << bit;
}

// turn a button off
void clearButton(joyReport_t *joy, uint8_t button)
{
    uint8_t index = button/8;
    uint8_t bit = button - 8*index;

    joy->button[index] &= ~(1 << bit);
}

//uint8_t button=0;	// current button
//bool press = true;	// turn buttons on?

/* Turn each button on in sequence 1 - 40, then off 1 - 40
 * add values to each axis each loop
 */
//byte i=0;



void loop() 
{
    // Turn on a different button each time
/*    if (press) {
	setButton(&joyReport, button);
    } else {
	clearButton(&joyReport, button);
    }*/

    /* Move all of the axes */
//    for (uint8_t ind=0; ind<8; ind++) {
//	joyReport.axis[ind] += 10 * (ind+1);
//    }


    //STQ(10)
    //Q4 (01)
    //Q3 (X1) He usado la cruceta mover derecho analógico
    //Q2 (Y1) He usado la cruceta mover abajo analógico
    //Q1 (9)

    q4 = digitalRead(pin_dtmf_q4);
    if (q4 != q4_antes){  senddata=true; q4_antes=q4;}     
    if (q4==1)
     setButton(&joyReport, pad_q4);
    else 
     clearButton(&joyReport, pad_q4);

    q3 = digitalRead(pin_dtmf_q3);
    if (q3!=q3_antes) {  senddata=true; q3_antes=q3;}    
    if (q3==1)
     setButton(&joyReport, pad_q3);
    else 
     clearButton(&joyReport, pad_q3);

    q2 = digitalRead(pin_dtmf_q2);
    if (q2 != q2_antes) {  senddata=true; q2_antes=q2;}
    if (q2 == 1)
     setButton(&joyReport, pad_q2);
    else 
     clearButton(&joyReport, pad_q2);    

    q1 = digitalRead(pin_dtmf_q1);
    if (q1 != q1_antes) {  senddata=true; q1_antes=q1;}
    if (q1==1)
     setButton(&joyReport, pad_q1);
    else 
     clearButton(&joyReport, pad_q1);

    stq = digitalRead(pin_dtmf_stq);
    if (stq != stq_antes) {  senddata=true; stq_antes=stq;}
    if (stq == 1)
     setButton(&joyReport, pad_stq);
    else
     clearButton(&joyReport, pad_stq);
    
    if (senddata==true)
    {
      senddata=false;
      sendJoyReport(&joyReport);      
    }
      

/*    if (i%2==0)
    {
      button= 0;
    }
    else
    {
     button= 0xFF;
    }
    i++;*/
/*    button++;
    if (button >= 40) {
       button = 0;
       press = !press;
    }*/
//    delay(20);
}
