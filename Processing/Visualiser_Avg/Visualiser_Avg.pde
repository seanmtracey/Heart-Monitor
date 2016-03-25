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
background(0);
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
int amt = 10;

float[] reads = new float[amt];

void serialEvent(int serial) {

if(serial != '\n') {
buff += char(serial);
} else {
  //print(buff + "\n");
  
  float val = map(parseFloat(buff), 0.0, 500.0, 0.0, 800.0);
  
  if(count == 5){
    stroke(0,255,0);
    fill(0,255,0);
    //rect(xPos, val, 1.0, 1.0);
    
    float avg = 0;
    
    for(int h = 0; h < amt; h += 1){
      avg += reads[h];
    }
    
    avg = avg / amt;
    
    line(xPos - 1, prev, xPos, avg);
    
    prev = avg;
    
    //rect(xPos, avg + 200, 1.0, 1.0);
    
    xPos++;
    
    count = 0;  

  } else {
     
     reads[count] = val;
     count += 1;
    
  }
  
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


