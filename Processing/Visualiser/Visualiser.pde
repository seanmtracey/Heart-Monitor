import processing.serial.*;

String buff = "";
int val = 0;
int NEWLINE = 10;
int x_Pos,yPos,zPos = 0;
int displaySize = 2;
int an1, an2, an3;

float xPos = 0;
//an1 pot; an2 ir;

Serial port;

void setup(){
background(80);
size(800,800);
smooth();

port = new Serial(this, Serial.list()[3], 9600);
}

void draw(){
// new background over old
fill(80,5);
noStroke();
//rect(0,0,width,height);

// wipe out a small area in front of the new data
//fill(80);
//rect(xPos+displaySize,0,50,height);

// check for serial, and process
while (port.available() > 0) {
serialEvent(port.read());
}

}


int count = 0;
float prev = 0;

void serialEvent(int serial) {

if(serial != '\n') {
buff += char(serial);
} else {
  print(buff + "\n");
  
  float val = map(parseFloat(buff), 0.0, 1024.0, 0.0, 400.0);
  
  //print(val);
    
//  print(xPos + " " + buff + "\n");
  
  stroke(255);
  fill(255);
  rect(xPos, val, 1.0, 1.0);
  //rect(100, val, 2.0, 2.0);
  
  xPos++;
  
  float diff = val - prev;
  stroke(255,0,0);
  fill(255,0,0);
  
  //print(diff);
  
  /*if(diff < -0.9 || diff > 0.9){
    rect(xPos, val, 1.0, diff * 20);  
  }*/
  
  
  float mDiff = map(diff, -1.0, 1.0, 0.0, 100.0);
  
  rect(xPos, val - mDiff, 1.0, 1.0);
  
  prev = val;
  
  if(xPos > 800){
   background(0);
    xPos = 0; 
  }
  
  
  
  // Clear the value of "buff"
  buff = ""; 
}

}

void sensorTic1(int x, int y){
stroke(0,0,255);
fill(0,0,255);
ellipse(x,y,displaySize,displaySize);
}

void sensorTic2(int x, int y){
stroke(255,0,0);
fill(255,0,0);
ellipse(x,y,displaySize,displaySize);
}


