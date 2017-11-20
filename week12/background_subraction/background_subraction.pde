// hit b key to reset background (make sure you are out of frame when you do)

import processing.video.*;

Capture cam;
PImage movementImg;
PImage backgroundImg; // store room background to image

int numPixels;
int movementThreshold = 120; // how much color difference (out of 765) must there be to connote movement?

ArrayList blocks;
int[] topBlock;     // which is the top "activated" block?
int blockW, blockH; // size of movement detection rects
float blockThreshold = .6;  // what proportion of block needs movement for it to become active?

ArrayList fallers; // falling things that sit on top of you

boolean diagnostics = false; // for me! graphical output...

void setup() {
  // set application window
  size(640, 480);

  cam = new Capture(this, 640, 480, 30);
  cam.start();

  // needed for for loop later
  numPixels = cam.width * cam.height;

  movementImg = new PImage ( cam.width, cam.height);
  backgroundImg = new PImage (cam.width, cam.height);

  // how big should movement detection blocks be?
  blockW = cam.width / 128;
  blockH = cam.height / 72;
  topBlock = new int[cam.width / blockW];  // (this should just be the same as blockW divisor aka number of columns)

  // init blocks
  blocks = new ArrayList();
  for (int y = 0; y < height; y += blockH) {
    for (int x = 0; x < width; x += blockW) {
      blocks.add(new Block(x, y));
    }
  }

  // init fallers
  fallers = new ArrayList();
  for (int i = 0; i < 100; i++) {
    fallers.add(new Faller());
  }
}

void draw() {
  //background(0);
  if (cam.available()) {
    cam.read();
    cam.loadPixels();
    movementImg.loadPixels();

    // cycle through every pixel and check for color differences
    for (int i = 0; i < numPixels; i++) {
      int movementSum = 0;
      color currColor = cam.pixels[i];
      color prevColor = backgroundImg.pixels[i];
      int currR = (currColor >> 16) & 0xFF;
      int currG = (currColor >> 8) & 0xFF;
      int currB = currColor & 0xFF;
      int prevR = (prevColor >> 16) & 0xFF;
      int prevG = (prevColor >> 8) & 0xFF;
      int prevB = prevColor & 0xFF;
      int diffR = abs(currR - prevR);
      int diffG = abs(currG - prevG);
      int diffB = abs(currB - prevB);
      movementSum += diffR + diffG + diffB;

      // given the movement sum, make a call on whether this pixel
      // should be white or black
      if (movementSum > movementThreshold && frameCount > 20) {
        movementImg.pixels[i] = color(255);
      } else {
        movementImg.pixels[i] = color(0);
      }
      movementImg.updatePixels();
    }
  }

  // only show graphical analysis if diagnostics are enabled
  if (diagnostics) {
    set(0, 0, movementImg);
  } else {
    set(0, 0, cam);
  }

  // check blocks for movement
  for (int i = 0; i < blocks.size(); i++) {
    Block b = (Block) blocks.get(i);
    b.test();
  }

  // update fallers
  for (int i = 0; i < fallers.size(); i++) {
    Faller f = (Faller) fallers.get(i);
    f.update();
  }

  checkTops();  // see where the highest activated block in each column is

  checkKeys();

  PImage tempImg = new PImage(width, height);
  tempImg = get();
  scale(-1, 1);
  image(tempImg, -width, 0);

  // once program properly starts up, set the background
  if (frameCount == 10)
    setBackground();
}

void checkKeys() {
  if (keyPressed) {
    if (key == 'b' || key == 'B') {
      // set new background image from which to subtract
      setBackground();
    }
    if (key == 'a') {
      PImage chunk = new PImage(40, 40);
      chunk = movementImg.get(10, 20, 40, 40);
    }
    if (key == 'd')
      diagnostics = !diagnostics;
  }
}

void setBackground() {
  if (cam.available()) {
    backgroundImg = cam.get();
  }
}

// see which block is highest in each column (to rest stuff atop it)
void checkTops() {
  for (int x = 0; x < width; x += blockW) {
    topBlock[x / blockW] = height - blockH; // set it to height as default, so text falls to bottom.
    for (int y = 0; y < height; y += blockH) {
      Block b = (Block) blocks.get(y / blockH * width / blockW + x / blockW);
      if (b.active) {
        topBlock[x / blockW] = y;
        // diagnostics...
        if (diagnostics) {
          stroke(255, 0, 0);
          strokeWeight(4);
          line(x, y, x + blockW, y);
        }
        break;  // exit the loop
      }
    }
  }
}