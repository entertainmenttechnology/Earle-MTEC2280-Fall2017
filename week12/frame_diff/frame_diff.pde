/*
FRAME DIFFERENCING demonstration
 for Grayson Earle's Physical Computing class
 
 This code compares each successive frame, analyzing each pixel to check
 for different RGB values. If there is a difference (above an abitrary
 threshold) that pixel is represented as WHITE on another PImage.
 */

// doing video manipulation so we need to include this library
import processing.video.*;

Capture cam;  // webcam object
PImage movementImg;  // this hold the black and white movement image

int[] previousFrame; // keeps track of the previous pixel array
int numPixels;       // how many pixels (width * height of camera dimensions)
int movementThreshold = 127;  // how different does the pixel have to be 
float movementThreshRatio = .10;  // alternatively... in percent *see below


// region of interest (roi) stuff:
// make a little rectangular area on the screen that
// detects motion
// where?
int roiX = 30;
int roiY = 30;
int roiW = 80;
int roiH = 80;
boolean roiOn = false;

void setup() {
  size(640, 480);

  cam = new Capture(this, 640, 480, 30);  // width, height, fps
  cam.start();  // vroom

  numPixels = cam.width * cam.height;  // total number of pixels in webcam image
  previousFrame = new int[numPixels];  // create array to store previous frame pixel data

  movementImg = new PImage (cam.width, cam.height);  // an image to show which pixels are different between frames
  
  // turn automatic draw() loop off--see below at end of capture event
  noLoop();
}

void draw() {

  //background(0);

  // show the images (or dont)
  image(cam, 0, 0);
  //tint(255, 126);  // semi transparent
  //image(movementImg, 0, 0, width, height);

  // check the roi
  // get can take a piece of an image x, y, w, h
  PImage ROI = movementImg.get(roiX, roiY, roiW, roiH);

  // loop thru the pixels inside of roi
  // first create a counter variable which stores how many
  // pixels inside the roi are active
  int theCount = 0;

  for (int x = roiX; x < roiW + roiX; x++) {
    for (int y = roiY; y < roiH + roiY; y++) {
      // extract color of each particular pixel
      color currColor = movementImg.get(x, y);

      // if it's not a black pixel
      if (brightness(currColor) > 1) {
        theCount++;
      }
    }
  }

  // done looping, what's theCount?
  //if(theCount > movementThreshold) {
  // or
  if (theCount > (roiW * roiH) * movementThreshRatio) {
    roiOn = true;  // the area is active enough
  } else {
    roiOn = false;  // nope
  }

  // draw the roi (or dont)
  stroke(255, 0, 0);
  if (roiOn) {
    fill(255, 0, 0);
  } else {
    noFill();
  }
  rect(roiX, roiY, roiW, roiH);
}

// if we use capture event instead of updating the webcam image every time
// inside of the draw loop, it will only happen anytime there is a new frame
// so its more efficient
// also it has the benefit of being organized away from the draw loop 
void captureEvent(Capture c) {

  c.read();

  // going to be analyzing these pixels so we need to load them
  c.loadPixels();

  // must load pixels before manipulation
  movementImg.loadPixels();

  // This part is advanced in the way that it derives RGB data from the color hex,
  // just know that it is calculating the color difference between frames
  for (int i = 0; i < numPixels; i++) {
    int movementSum = 0;
    color currColor = c.pixels[i];
    color prevColor = previousFrame[i];
    int currR = (currColor >> 16) & 0xFF;
    int currG = (currColor >> 8) & 0xFF;
    int currB = currColor & 0xFF;
    int prevR = (prevColor >> 16) & 0xFF;
    int prevG = (prevColor >> 8) & 0xFF;
    int prevB = prevColor & 0xFF;
    int diffR = abs(currR - prevR);
    int diffG = abs(currG - prevG);
    int diffB = abs(currB - prevB);

    // add any difference to the movementSum var
    movementSum += diffR + diffG + diffB;

    // given the movement sum, make a call on whether this pixel
    // should be white or black (based on the threshold below)
    if (movementSum > movementThreshold) {
      // if we crossed threshold, this pixel becomes white
      movementImg.pixels[i] = color(255);
    } else {
      // if not, let's paint in black
      movementImg.pixels[i] = color(0);
    }

    // reset previousFrame array for next comparison
    previousFrame[i] = currColor;

    // have to call an update pixels once you are done drawing to a PImage
    movementImg.updatePixels();
  }

  // since we have noLoop(), we need to manually tell processing when
  // to execute the draw loop
  redraw();
}