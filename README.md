# Heart-Monitor
The code for an Infra-red heart monitor that you can make with an Arduino + Processing

![My heartbeat](http://sean.mtracey.org/downloads/heartbeat.png)

### Setup

The setup is pretty simple, you need:

1. an Arduino
2. Processing
3. an IR emitter + receiver

Upload the sketch to the Arduino and then run the Processing sketch. The Arduino will send the data to Processing over a serial connection.

Follow the diagram (that I'll upload later) to wire your IR emitter and receiver to your Arduino. Lie them flat next the each other, but not point at each other. Instead point them upwards from the surface you've mounted them on, and then place your finger across them (this sensor works best in the dark). If enough of the sensors are covered by your finger, and the light levels are low enough (although this wouldn't be an issues in, say, a smartwatch) you'll start to see a pulse reading on the screen. 

The red dots are the raw data points from the sensors. The blue line is the average of these measures, and as a consequence, a measure of the amount of oxygen in your blood. The yellow lines are where the code things your heart has had a beat.
