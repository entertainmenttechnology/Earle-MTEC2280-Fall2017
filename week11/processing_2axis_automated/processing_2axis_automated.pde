import processing.serial.*;  // import serial library
 
Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port

// where to position the robot arm
int roboX;
int roboY;
int roboXspeed = 5;
int roboYspeed = 5;

void setup(){
  size(500, 500);
  // remember to set your serial port...
  printArray(Serial.list());
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
 
  // basic drawing properties
  fill(255);
  noStroke();
  
  // starting parameters
  roboX = width/2;
  roboY = height/2;
  roboXspeed = int(random(3,6));
  roboYspeed = int(random(3,6));
}
 
void draw() {
  background(255,0,0);
  
  // pong code
  roboX += roboXspeed;
  roboY += roboYspeed;
  
  ellipse(roboX, roboY, 40, 40);
  if(roboX > width || roboX < 0) {
    // hit right side OR left side of screen
    roboXspeed *= -1;
  }
  if(roboY > height || roboY < 0) {
    // hit right side OR left side of screen
    roboYspeed *= -1;
  }
  
  // map the values, since the servos want numbers
  // between 0 and 180
  int mappedX = int(map(roboX, 0, width, 0, 160));
  int mappedY = int(map(roboY, 0, height, 30, 110));
  
  println(mappedX, mappedY);
 
  // write the info out the serial
  myPort.write(mappedX);  // write x and y vars to serial
  myPort.write(mappedY);  // for the arduino to read
}