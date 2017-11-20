import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class background_subraction extends PApplet {



Capture cam;
PImage movementImg;
PImage backgroundImg; // store room background to image

int numPixels;
int movementThreshold = 80; // how much color difference (out of 765) must there be to connote movement?

ArrayList blocks;
int[] topBlock;     // which is the top "activated" block?
int blockW, blockH; // size of movement detection rects
float blockThreshold = .6f;  // what proportion of block needs movement for it to become active?

ArrayList fallers; // falling things that sit on top of you

boolean diagnostics = false; // for me! graphical output...

public void setup() {

  String[] cameras = Capture.list();
  // hack to get camera dimensions before it's ready to capture
  String temp = cameras[0]; //name=FaceTime HD Camera,size=1280x720,fps=30
  String[] dim = temp.split(","); // middle string is 'size=1280x720' after split
  dim[0] = dim[1].substring(5); //1280x720
  dim = dim[0].split("x");  //1280, 720 yay!

  // derive usable dimensions (ints)
  int camW = parseInt(dim[0]);
  int camH = parseInt(dim[1]);

  // set application window
  size(camW, camH);

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    cam = new Capture(this, temp);
    cam.start();
  }

  // needed for for loop later
  numPixels = camW * camH;

  movementImg = new PImage ( camW, camH);
  backgroundImg = new PImage (camW, camH);

  // how big should movement detection blocks be?
  blockW = camW / 128;
  blockH = camH / 72;
  topBlock = new int[camW / blockW];  // (this should just be the same as blockW divisor aka number of columns)

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

public void draw() {
  //background(0);
  if (cam.available()) {
    cam.read();
    cam.loadPixels();
    movementImg.loadPixels();

    // cycle through every pixel and check for color differences
    for (int i = 0; i < numPixels; i++) {
      int movementSum = 0;
      int currColor = cam.pixels[i];
      int prevColor = backgroundImg.pixels[i];
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

public void checkKeys() {
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

public void setBackground() {
  if (cam.available()) {
    backgroundImg = cam.get();
  }
}

// see which block is highest in each column (to rest stuff atop it)
public void checkTops() {
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
// blocks will analyze rectangles within the camera image, so we do analysis on larger areas
// than pixels (less noise)
class Block {
	int x, y;
	PImage chunk;
	boolean active = false;

	Block(int x, int y) {
		this.x = x;
		this.y = y;
		// set up PImage chunk
		chunk = new PImage(blockW, blockH);

	}

	public void test() {
		// reset to inactive
		active = false;

		// copy piece of image for analysis
		chunk = movementImg.get(x, y, blockW, blockH);

		chunk.loadPixels();
		int totalBrightness = 0;
		// go thru each pixel in block
		for (int i = 0; i < blockW * blockH; i++) {
			totalBrightness += brightness(chunk.pixels[i]);
		}

		// if we crossed the threshold...
		int outOf = blockW * blockH * 255;
		if (totalBrightness > (outOf * blockThreshold)) {
			if (diagnostics) {
				fill(255, 255, 0, 255);
				noStroke();
				rect(x, y, blockW, blockH);
			}

			active = true;	// it's "on"
		}
	}
}

class Faller {
	float x, y;

	PImage balls;

	Faller() {
		x = random(width);
		y = random(height);

		//balls = loadImage("balls.png");
	}

	public void update() {
		// fall, faller!
		y += 20;

		// what column is this faller in?
		int c = round(map(x, 0, width, 0, topBlock.length));

		// should this be resting?
		if (y > topBlock[c]) {
			y = topBlock[c];	// set y to the top block of whatever column we are in
		}

		fill(255);
		// subtract Y so that we arent drawing topleft corner of rect where the base of movement is
		//image(balls, x, y-blockH);
		rect(x, y-blockH, blockW, blockH);
	}
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "background_subraction" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
