// allows for serial comms from/to Processing
import processing.serial.*;

Serial myPort;  // The serial port

// a variable to store the incoming serial data to
int inByte = 0;

void setup() {
  // 3d in case we want some spinning 3d shapes
  size(600, 600, P3D);
  // List all the available serial ports
  printArray(Serial.list());
  
  // FIGURE OUT WHAT PORT YOU NEED TO USE
  
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[4], 9600);
}

void draw() {
  // is there any serial data?
  while (myPort.available() > 0) {
    // set inByte to the incoming value from serial
    inByte  = myPort.read();
    // print out the value just to see
    println(inByte);
  }

  // draw an ellipse with the size relative to
  // the analog reading from the arduino
  background(0);
  ellipse(width/2, height/2, inByte, inByte);
}