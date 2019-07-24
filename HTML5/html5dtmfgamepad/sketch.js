//Autor: Jaime Jose Gavin Sierra
//EA1HLX
//Ackerman
var id_stq,id_q4,id_q3,id_q2,id_q1;
var value_stq,value_q4,value_q3,value_q2,value_q1;
var value_stq_antes,value_q4_antes,value_q3_antes,value_q2_antes,value_q1_antes;

var cad_bit_dtmf='';
var stq_antes=0;
var dato=0;
var cadDTMF='';

var areaRX;
var forceDraw = false;
var cad_areaRX = '';

var input_stq;
var input_q4;
var input_q3;
var input_q2;
var input_q1;
var btnBotones;
var btnClear;

function setup() {
  createCanvas(windowWidth, windowHeight);
  textFont('Courier');
  textSize(20);

  areaRX = createElement('textarea');
  areaRX.position(110,110);
  areaRX.style('width','200px');
  areaRX.style('height','70px');
  areaRX.elt.placeholder='';   
  
   
  value_stq= value_q4= value_q3= value_q2 = value_q1 = 0;
  //value_stq_antes = value_q4_antes = value_q3_antes = value_q2_antes = value_q1_antes = 0;  
  
  id_stq = 3;
  id_q4 = 5;
  id_q3 = 6;
  id_q2 = 9;
  id_q1 = 10;
 

  btnBotones = createButton('Botones');
  btnBotones.position(220,190);
  btnBotones.mousePressed(LoadBotones);
  
  btnClear = createButton('Clear');
  btnClear.position(220, 220);
  btnClear.mousePressed(ClearDtmf);

  input_stq = createInput();
  input_stq.position(60, 190);
  input_stq.elt.value = id_stq.toString();

  input_q4 = createInput();
  input_q4.position(60, 220);
  input_q4.elt.value = id_q4.toString();

  input_q3 = createInput();
  input_q3.position(60, 250);
  input_q3.elt.value = id_q3.toString();
  
  input_q2 = createInput();
  input_q2.position(60, 280);
  input_q2.elt.value = id_q2.toString();
  
  input_q1 = createInput();
  input_q1.position(60, 310);
  input_q1.elt.value = id_q1.toString();
      
  forceDraw = true;
}

function ClearDtmf(){
 cad_areaRX='';
 forceDraw = true;
}

function LoadBotones(){ 
 id_stq = Number(input_stq.elt.value);
 id_q4 = Number(input_q4.elt.value);
 id_q3 = Number(input_q3.elt.value);
 id_q2 = Number(input_q2.elt.value);
 id_q1 = Number(input_q1.elt.value);
}

function NumberToDTMFString(valor){
 var aReturn='';
 switch (valor){
  case 0: aReturn ='D'; break; //16
  case 1: aReturn ='1'; break;
  case 2: aReturn ='2'; break;
  case 3: aReturn ='3'; break;
  case 4: aReturn ='4'; break;
  case 5: aReturn ='5'; break;
  case 6: aReturn ='6'; break;
  case 7: aReturn ='7'; break;
  case 8: aReturn ='8'; break;
  case 9: aReturn ='9'; break;
  case 10: aReturn ='0'; break; //0
  case 11: aReturn ='*'; break;
  case 12: aReturn ='#'; break;
  case 13: aReturn ='A'; break;
  case 14: aReturn ='B'; break;
  case 15: aReturn ='C'; break;
  default: aReturn=''; break;
 }
 return aReturn;
}

function draw(){ 
 let pads = navigator.getGamepads();
 let pad0 = pads[0];
 var cad='';
 if (pad0){    
  for (var i=0;i<pad0.buttons.length;i++){
   if (pad0.buttons[i].value === 1){
    cad+='1';
   }
   else{
    cad+='0';
   }
   switch ((i+1)){
	case id_stq: value_stq = pad0.buttons[i].value; break;
	case id_q4: value_q4 = pad0.buttons[i].value; break;
	case id_q3: value_q3 = pad0.buttons[i].value; break;
	case id_q2: value_q2 = pad0.buttons[i].value; break;
	case id_q1: value_q1 = pad0.buttons[i].value; break;
	default: break;
   }
  }
 }
 cad_bit_dtmf = '';
 cad_bit_dtmf += value_stq;
 cad_bit_dtmf += value_q4;
 cad_bit_dtmf += value_q3;
 cad_bit_dtmf += value_q2;
 cad_bit_dtmf += value_q1;
 
 if (value_stq === 1){
  if (stq_antes === 0){
   dato = (value_q4*8)+(value_q3*4)+(value_q2*2)+value_q1;
   cadDTMF = NumberToDTMFString(dato);
   forceDraw = true;
  }
 }
 else
 {
   dato=0;
   cadDTMF = NumberToDTMFString(dato);      
 }
 
 if ((value_q4 != value_q4_antes)
     ||
     (value_q3 != value_q3_antes)
     ||
     (value_q2 != value_q2_antes)
     ||
     (value_q1 != value_q1_antes)
     ||
     (value_stq != value_stq_antes)
    ){
  forceDraw = true;
 }
 
 if (value_stq != stq_antes){
  if ((stq_antes === 0) && (value_stq === 1)){   
   cad_areaRX += cadDTMF;
   forceDraw = true;
  }	 
  stq_antes = value_stq;
 }
 
 if (forceDraw === true)
 {
  forceDraw = false;
  background(255);
  fill(0, 0, 0); 
  text(cad, 10, 30); 
  text(cad_bit_dtmf, 10, 60);
  text('stq: '+value_stq, 10, 80);
  text('q4: '+value_q4, 10, 100);
  text('q3: '+value_q3, 10, 120);
  text('q2: '+value_q2, 10, 140);
  text('q1: '+value_q1, 10, 160);
  text('dato: '+dato, 160, 80);
  text('DTMF: '+cadDTMF,160,100);
  areaRX.elt.value = cad_areaRX;
  
  text('stq', 10, 200);
  text('q4', 10, 230);
  text('q3', 10, 270);
  text('q2', 10, 300);
  text('q1', 10, 330);
 }
}










/*







// Gamepad demo from https://infosmith.biz/blog/it/p5js-gamepad-api
let starObj;
let bgAlpha = 10;
let bgRot = 100;
 
function setup() {
    createCanvas(600, 600);
    colorMode(HSB, 360, 100, 100, 100);
    noStroke();
    starObj = new starPoints();
}
 
function draw() {
    blendMode(BLEND);
    background(0, bgAlpha);
    translate(width / 2, height / 2);
    rotate(frameCount / bgRot);
    for (let d = 0; d < 12; d++) {
        rotate(radians(30));
        fill(d * 30, 100, 100, 40);
        blendMode(SCREEN);
        drawStar(d, starObj);
    }
    let pads = navigator.getGamepads();
    let pad0 = pads[0];
    if (pad0) {
        updateStatus(pad0, starObj);
    } else {
        starObj.x = mouseX - width / 2;
        starObj.y = mouseY - height / 2;
    }
}
 
function drawStar(d, obj) {
    push();
    translate(obj.x, obj.y);
    let rotVec;
    if (d % 2 !== 0) {
        rotVec = 1;
    } else {
        rotVec = -1;
    }
    rotate(frameCount / obj.speed * rotVec);
    scale(obj.scale);
    beginShape();
    for (let i = 0; i < obj.ptArr.length; i++) {
        vertex(obj.ptArr[i].px, obj.ptArr[i].py);
    }
    endShape();
    pop();
}
 
function updateStatus(pad, obj) {
    obj.x = map(pad.axes[0], -0.9, 0.9, -width / 2, width / 2);
    obj.y = map(pad.axes[1], -0.9, 0.9, -height / 2, height / 2);
    obj.speed = map(pad.buttons[4].value, 0, 1, 80, 8);
    obj.scale = map(pad.buttons[7].value, 0, 1, 1, 20);
    bgAlpha = map(pad.buttons[0].value, 0, 1, 10, 0.1);
    bgRot = map(pad.buttons[5].value, 0, 1, 100, 20);
    return;
}
 
class starPoints {
    constructor() {
        this.x = 0;
        this.y = 0;
        this.rad = 15;
        this.scale = 1;
        this.speed = 1000;
        this.ptArr = [];
        let ptflg;
        for (let i = 0; i < 360; i += 36) {
            if (i % 72 !== 0) {
                ptflg = .38;
            } else {
                ptflg = 1;
            }
            this.ptArr.push({
                px: cos(radians(i)) * this.rad * ptflg,
                py: sin(radians(i)) * this.rad * ptflg
            })
        }
    }
}*/