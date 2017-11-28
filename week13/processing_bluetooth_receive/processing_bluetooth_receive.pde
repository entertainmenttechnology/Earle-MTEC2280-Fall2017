import processing.serial.*;  // import serial library

Serial myPort;  // Create object from Serial class
int myVal = 0;

void setup()
{
  size(500, 500);
  // remember to set your serial port...
  printArray(Serial.list());
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);

  // basic drawing properties
  fill(255);
  noStroke();
}

void draw() {
  // check for info on serial
  if (myPort.available() > 0) {
    //println(myPort.readStringUntil('\n'));
    myVal = myPort.read();
  }

  if (myVal == 0)
    background(255, 0, 0);
  else
    background(0);
    
  println(myVal);
}