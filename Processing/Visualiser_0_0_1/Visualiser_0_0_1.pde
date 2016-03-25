import processing.serial.*;

String buff = "";
int val = 0;
int NEWLINE = 10;
int x_Pos, yPos, zPos = 0;
int displaySize = 2;
int an1, an2, an3;

float xPos = 0;
//an1 pot; an2 ir;

int monitorWidth = 800;
int monitorHeight = 800;

Serial port;

void setup() {
  background(0);
  size(monitorWidth, monitorHeight);
  smooth();

  port = new Serial(this, Serial.list()[3], 9600);
}

void draw() {
  // new background over old
  fill(80, 5);
  noStroke();

  // check for serial, and process
  while (port.available () > 0) {
    serialEvent(port.read());
  }
}

int count = 0;
float prev = 0;
int amt = 10;

float min = monitorHeight;
float max = 0;
float mVal = 0;

float[] reads = new float[amt];

boolean ascending = false;
boolean descending = false;

int beatCount = 0;
int readStart = millis();
int bpm = 0;

void serialEvent(int serial) {

  if (serial != '\n') {
    buff += char(serial);
  } else {

    float val = parseFloat(buff);  

    buff = "";

    if (val < min) {
      min = val;
    }

    if (val > max) {
      max = val;
    }

    /*if (max - min < 10) {
      fill(0);
      rect(monitorWidth - 150, 0, 150, 30);
      fill(255);
      text("No Finger Detected", monitorWidth - 150, 20);
    } else {
      fill(0);
      rect(monitorWidth - 150, 00, 150, 30); 
    }*/

    if (xPos < monitorWidth) {

      mVal = map(val, min, max, 200.0, 600.0);

      //Raw Photoresistor data (Green)

      fill(0, 255, 0);
      rect(xPos, val, 1, 1);

      //Mapped Heartbeat (Red)

      fill(255, 0, 0);
      rect(xPos, mVal, 1, 1);

      //Refined Heartbeat (Light Blue)

      if (count == amt) {

        float avg = 0.0;

        for (int o = 0; o < amt; o += 1) {
          avg += reads[o];
        }

        avg = avg / amt;

        fill(0, 255, 255);
        stroke(0, 255, 255);
        //rect(xPos, avg, 1, 1);

        line(xPos - amt, prev, xPos, avg);

        if (avg < prev) {
          ascending = true;
        }

        // The > and < are back to front because the data is inverted
        if (ascending == true && prev < avg && avg - prev > 50) {
          ascending = false;
          descending = true;

          //Draw beat guess line
          stroke(255, 255, 0);
          fill(255, 255, 0);
          line(xPos, 200, xPos, 600);
          beginShape();
          vertex(xPos, 620);
          vertex(xPos + 10, 630);
          vertex(xPos - 10, 630);
          endShape(CLOSE);
          
          beatCount += 1;
          
        }

        prev = avg;

        count = 0;
      } else {
        reads[count] = mVal;
        count += 1;
      }

      //Text
      noStroke();
      fill(0);
      rect(0, 0, 150, 150);
      fill(255, 255, 255);
      text("min: " + min, 10, 30);
      text("max: " + max, 10, 50);

      fill(255, 0, 0);
      rect(10, 70, 10, 10);
      text("Mapped Data", 30, 80);

      fill(0, 255, 0);
      rect(10, 90, 10, 10);
      text("Raw Sensor Data", 30, 100);

      fill(0, 255, 255);
      rect(10, 110, 10, 10);
      text("Processed Data", 30, 120);

      xPos += 1;
    } else {
      background(0);
      xPos = 0; 
      min = monitorHeight;
      max = 0;
      
      bpm = beatCount * (60000 / (millis() - readStart));
      
      //print(bpm + "\n");
      
      readStart = millis();
      beatCount = 0;
    }
  }
}

