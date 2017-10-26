import processing.serial.*;  // import serial library
 
Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port
 
void setup()
{
  frameRate(100);
  size(500, 300);
  // remember to set your serial port...
  printArray(Serial.list());

  myPort = new Serial(this, Serial.list()[1], 9600);
 
  // basic drawing properties
  fill(255);
  noStroke();
}
 
void draw() {
  background(255,0,0);
  ellipse(mouseX,mouseY,40,40);
  // map the mouse position from 0 -> window width to a range of degrees for the servo
  // the servo can handle 180 degrees, but I think the pointer is better with a limited range
  int posX = int(map(mouseX,0,width,60,120));
 
  myPort.write(posX);  // write x and y vars to serial
}