// opencv stuff
import gab.opencv.*;
OpenCV opencv;

// webcam stuff
import processing.video.*;
Capture cam;

// temporarily store webcam image here
PImage img;

// what size is the camera
int camW = 1280;
int camH = 720;

// dive cam image size by 4 bc OpenCV is processor intensive
int scaler = 4; 

// new section: serial stuff
import processing.serial.*;  // import serial library
Serial myPort;  // Create object from Serial class


void setup() {

  // remember to set your serial port...
  printArray(Serial.list());
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);

  size(320, 180);

  // only advance the frame when we're good and ready
  noLoop();

  // init cam
  printArray(Capture.list());
  //cam = new Capture(this, camW, camH);
  cam = new Capture(this, Capture.list()[1]);
  cam.start();

  // start up opencv
  opencv = new OpenCV(this, camW/scaler, camH/scaler);

  // make sure the temp img matches the size of opencv
  img = new PImage(camW, camH);
}

void draw() {

  // downsize to keep things running smoothly
  PImage smaller = img.copy();
  smaller.resize(opencv.width, opencv.height);

  // this is the magic line of code that tells opencv take
  // a peek at the image
  opencv.loadImage(smaller);

  // draw the image, just for kicks
  image(opencv.getOutput(), 0, 0); 

  // opencv.max() returns the coordinates of the brightest pixel
  // in the image
  PVector loc = opencv.max();

  // draw an ellipse at the location, just for kicks
  stroke(255, 0, 0);
  strokeWeight(4);
  noFill();
  ellipse(loc.x, loc.y, 10, 10);

  //println(loc.x, loc.y);

  // map the mouse position from 0 -> window width to a range of degrees for the servo
  // the servo can handle 180 degrees, but I think the pointer is better with a limited range
  int posX = int(map(loc.x, 0, width, 60, 120));
  int posY = int(map(loc.y, 0, height, 60, 120));

  println(posX, posY);

  if (posX > 0 && posY > 0) {
    
    myPort.write(posX);  // for the arduino to read
    myPort.write(posY);  // write x and y vars to serial
  }
  
  
}

// webcam capture event
void captureEvent(Capture c) {
  c.read();
  img = c.get();

  redraw = true;  // force draw() since we arent auto looping
}