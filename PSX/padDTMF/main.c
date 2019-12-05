// ************************************
// * GAMEPAD DTMF PSX                 *
// * Autor ackerman JJ  GROUP SLIDERS *
//*************************************
#include <sys/types.h>		//these are the various include files that need to be included
#include <libetc.h>		//note that the order they are included in does matter in some cases!
#include <libgte.h>
#include <libgpu.h>
#include <libgs.h>
#include <stdio.h>
#include "pad.h"
/*
also note that while this example uses the Gs functions, these are high level functions
and should not be used if it can be helped as they are quite slow and consume lots of memory.
they will however do while you are learning as they simplify things and help you to understand
the process that you go through to print to the screen.
*/

#define OT_LENGTH (10)			//this is the 'length' of the OT (ordering tabble)
					//for more info on ordering tables, check out ot.txt on my 'info' page

#define PACKETMAX (2048)		//these are the graphics area contants
#define PACKETMAX2 (PACKETMAX*24)	//allows you to select how many gfx objects the psx should handle
					//in this particular example

#define SCREEN_WIDTH 320		//contants to determine the height and width of the screen resolution
#define SCREEN_HEIGHT 240

GsOT myOT[2];				//an array of 2 OT's this is how your double buffering is implemented
GsOT_TAG myOT_TAG[2][1<<OT_LENGTH];
PACKET GPUPacketArea[2][PACKETMAX2];	//also 2 gfx packet areas for double buffering

u_long pad;
u_char datoPAD;
char dtmf=' ';
u_char Q4,Q3,Q2,Q1,Q0,STD,aux; 

/***************** prototypes *******************/
void InitGraphics(void);			//this method sets up gfx for printing to screen
void DisplayAll(int);			//this displays the contents of the OT
void HandlePad(void);
int main(void);

/***************** functions ********************/
int main(void) {
	int activeBuffer=0;		//variable used to hold the buffer that is currently being displayed
	
	InitGraphics();			//this method sets up gfx for printing to screen
	
	FntLoad(960, 256);		//this loads the font gfx to the vram
	FntOpen(32, 32, 256, 200, 0, 512);	//this sets up the fonts printing attributes
						//eg printing boundries and number of letters to hold in printing buffer etc
						
	while (1) {				//infinite loop
		activeBuffer = GsGetActiveBuff();	//gets the buffer currently being displayed and stores in activeBuffer
		GsSetWorkBase((PACKET*)GPUPacketArea[activeBuffer]);	//sets up the gfx workspace
		GsClearOt(0, 0, &myOT[activeBuffer]);			//clears the OT contents
		
		//once the OT contents have been cleared you can add new objects to the OT
		//so that they will be displayed next time DisplayAll is called		
		FntPrint("PAD\n %d %d\nBIN %d%d%d%d%d\nDTMF %c",pad,datoPAD,STD,Q4,Q3,Q2,Q1,dtmf);
		//this just adds the string to the screen printing buffer
		//to actually print this to screen yu have to flush the contents of this buffer
		//this is done in displayall method
		
		DisplayAll(activeBuffer);		//this dispalys the OT contents to screen		
		HandlePad();					//this handles button presses on the controller pad 1
	}
	return 0;		//when program is finished return from it
}

void InitGraphics(void) {
	//this method sets up gfx for printing to screen
	GsInitGraph(SCREEN_WIDTH, SCREEN_HEIGHT, GsNONINTER|GsOFSGPU, 1, 0); //initialises the graphics system
	//no Gs* * * functions will work unless GsInitGraph() has been called
	GsDefDispBuff(0, 0 , 0, SCREEN_HEIGHT); //defines double buffer attributes
	//buffer 0's top left coordinate becomes (0,0) & buffer 1's coordinate becomes (0, y resolution)

	myOT[0].length = OT_LENGTH; //sets OT length for each OT
	myOT[1].length = OT_LENGTH;
	myOT[0].org = myOT_TAG[0]; //gets top address of GsOT_TAG table
	myOT[1].org = myOT_TAG[1];
	GsClearOt(0,0,&myOT[0]); //initialises ordering table
	GsClearOt(0,0,&myOT[1]);
	
	PadInit(0);	
}

void DisplayAll(int activeBuffer) {
	//this method contains all the functions needed to display the contents of the OT
	FntFlush(-1);				//flushes font buffers contents from buffer so that they can be printed to screen
	DrawSync(0);
	//this waits till the GPU has finished drawing, as GsSwapDispBuff will not work correctly if drawing is in progress
	VSync(0);					//gsswapdispbuff should be called after beginning a v-blank
	GsSwapDispBuff();				//swap display buffer
	GsSortClear(0,0,0,&myOT[activeBuffer]);		//clears screen to color (0,0,0) and sorts OT ready for drawing
	GsDrawOt(&myOT[activeBuffer]);			//draws the contents of OT to screen
}

/***********************************************/
void HandlePad(void) {
//L1 - W         Q7
//L2 - E         Q6
//R1 - R         Q5
//R2 - T         Q4
//Triangulo - D  Q3
//Cuadrado - S   Q2
//Circulo - X    Q1
//X   - Z        Q0
//Start - V      (sync)	
 
	//handles button presses
	pad=PadRead(0);
	if (pad&Pad1R2) Q4=1; else Q4=0;	
	if (pad&Pad1tri) Q3=1; else Q3=0;
	if (pad&Pad1sqr) Q2=1; else Q2=0;
	if (pad&Pad1crc) Q1=1; else Q1=0;
	if (pad&Pad1x) Q0=1; else Q0=0;
	if (pad&Pad1Select) STD=1; else STD=0;
	
	aux=Q1+(Q2<<1)+(Q3<<2)+(Q4<<3);
	datoPAD= aux;
	switch(aux)
	{
	 case 0:dtmf='D';break;	 
	 case 1:dtmf='1';break;
	 case 2:dtmf='2';break;
	 case 3:dtmf='3';break;
	 case 4:dtmf='4';break;
	 case 5:dtmf='5';break;
	 case 6:dtmf='6';break;
	 case 7:dtmf='7';break;
	 case 8:dtmf='8';break;
	 case 9:dtmf='9';break;
	 case 10:dtmf='0';break;
	 case 11:dtmf='*';break;
	 case 12:dtmf='#';break;
	 case 13:dtmf='A';break;
	 case 14:dtmf='B';break;
	 case 15:dtmf='C';break;
	}
}
