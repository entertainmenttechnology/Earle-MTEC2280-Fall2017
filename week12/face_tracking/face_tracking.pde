import processing.serial.*;  // import serial library
Serial myPort;  // Create object from Serial class

import codeanticode.syphon.*;
PGraphics canvas;
PImage img;
SyphonServer server;

import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

OpenCV opencv;
Capture ct;     // webcam
Rectangle[] faces;
// A list of my Face objects
ArrayList<Face> faceList;
// how many have I found over all time
int faceCount = 0;

int camW = 1280;
int camH = 720;

int scaler = 4;  // openCV tends to lag so...
// clamp serial values
int outMin = 0;
int outMax = 255;

PGraphics blackout;  // send when server dies

void settings() {
  size(1280, 720, P3D);
  PJOGL.profile=1;
}

void setup() {
  printArray(Serial.list());
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);

  noLoop();
  canvas = createGraphics(width, height, P3D);
  img = new PImage(camW, camH);
  server = new SyphonServer(this, "Face Syphon");

  // init cam
  printArray(Capture.list());

  //ct = new Capture(this, camW, camH);
  ct = new Capture(this, Capture.list()[0]);
  ct.start();

  opencv = new OpenCV(this, camW/scaler, camH/scaler);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  faceList = new ArrayList<Face>();

  // create blackout image to send on server instance death
  blackout = createGraphics(width, height);
  blackout.beginDraw();
  blackout.background(0);
  blackout.endDraw();
}

void draw() {
  // downsize to keep things running smoothly
  PImage smaller = img.copy();
  smaller.resize(opencv.width, opencv.height);
  opencv.loadImage(smaller);
  faces = opencv.detect();

  Rectangle[] faces = opencv.detect();

  // SCENARIO 1: faceList is empty
  if (faceList.isEmpty()) {
    // Just make a Face object for every face Rectangle
    for (int i = 0; i < faces.length; i++) {
      faceList.add(new Face(faces[i].x, faces[i].y, faces[i].width, faces[i].height));
    }
    // SCENARIO 2: We have fewer Face objects than face Rectangles found from OPENCV
  } else if (faceList.size() <= faces.length) {
    boolean[] used = new boolean[faces.length];
    // Match existing Face objects with a Rectangle
    for (Face f : faceList) {
      // Find faces[index] that is closest to face f
      // set used[index] to true so that it can't be used twice
      float record = 50000;
      int index = -1;
      for (int i = 0; i < faces.length; i++) {
        float d = dist(faces[i].x, faces[i].y, f.r.x, f.r.y);
        if (d < record && !used[i]) {
          record = d;
          index = i;
        }
      }
      // Update Face object location
      used[index] = true;
      f.update(faces[index]);
    }
    // Add any unused faces
    for (int i = 0; i < faces.length; i++) {
      if (!used[i]) {
        faceList.add(new Face(faces[i].x, faces[i].y, faces[i].width, faces[i].height));
      }
    }
    // SCENARIO 3: We have more Face objects than face Rectangles found
  } else {
    // All Face objects start out as available
    for (Face f : faceList) {
      f.available = true;
    } 
    // Match Rectangle with a Face object
    for (int i = 0; i < faces.length; i++) {
      // Find face object closest to faces[i] Rectangle
      // set available to false
      float record = 50000;
      int index = -1;
      for (int j = 0; j < faceList.size(); j++) {
        Face f = faceList.get(j);
        float d = dist(faces[i].x, faces[i].y, f.r.x, f.r.y);
        if (d < record && f.available) {
          record = d;
          index = j;
        }
      }
      // Update Face object location
      Face f = faceList.get(index);
      f.available = false;
      f.update(faces[i]);
    } 
    // Start to kill any left over Face objects
    for (Face f : faceList) {
      if (f.available) {
        f.countDown();
        if (f.dead()) {
          f.delete = true;
        }
      }
    }
  }

  // Delete any that should be deleted
  for (int i = faceList.size()-1; i >= 0; i--) {
    Face f = faceList.get(i);
    if (f.delete) {
      faceList.remove(i);
      faceCount--;
    }
  }

  canvas.beginDraw();
  canvas.image(img, 0, 0);
  canvas.noFill();

  for (Face f : faceList) {
    f.display();
    f.sendSyphon();
  }

  canvas.endDraw();

  // send out via syphon (just the largest face for now)
  if (faceList.size() > 0) {
    Face f = faceList.get(0);

    PImage faceImg = img.get(int(f.currPos.x*scaler), int(f.currPos.y*scaler), int(f.currDim.x*scaler), int(f.currDim.y*scaler));
    faceImg.resize(width, height);

    server.sendImage(faceImg);

    // send face pos out via serial
    int faceMiddle = int(f.currPos.x*scaler + (f.currDim.x*scaler / 2));
    int facePos = int(map(faceMiddle, 0, width, outMin, outMax));
    myPort.write(facePos);  // write x and y vars to serial
    // println(facePos);
  }

  image(canvas, 0, 0);
}


// webcam capture event
void captureEvent(Capture c) {
  c.read();
  img = c.get();

  redraw = true;  // force draw() since we arent auto looping
}

public PImage FlipVH( PImage image ) {
  PImage reverse = new PImage( image.width, image.height );
  for ( int i=0; i < image.width; i++ ) {
    for (int j=0; j < image.height; j++) {
      //reverse.set( image.width - 1 - i, j, image.get(i, j) );
      //reverse.set( i, image.height - 1 - j, image.get(i, j) );
      reverse.set( image.width - 1 - i, image.height - 1 - j, image.get(i, j) );
    }
  }
  return reverse;
}

int firstAvailableId() {

  // return this eventually
  int lowestId = 0;

  // if we dont have any faces yet just do zero, bra
  if (faceList.size() > 0) {

    // create list that will store all the faceList ids
    int[] idSorted = new int[faceList.size()];

    // do it up
    for (int i = 0; i < faceList.size(); i++) {
      Face f = faceList.get(i);
      idSorted[i] = f.id;
    }
    // sort list ascending
    idSorted = sort(idSorted);

    // if the first number in the list aint zero, just return 0
    if (idSorted[0] != 0) {
      return 0;
    }

    // find any gaps
    for (int i = 0; i < idSorted.length; i++) {
      if (idSorted[i] != i) {
        // if there's a mismatch between regular ascending numbers
        // 0 -> 99 and the list of ids, then set lowestId to previous
        // array member plus one
        lowestId = idSorted[i-1]+1;
        break;
      }
    }

    // didnt find any gaps, just tag it on the end
    if (lowestId == 0) lowestId = faceList.size() + 1;
  }

  return lowestId;
}