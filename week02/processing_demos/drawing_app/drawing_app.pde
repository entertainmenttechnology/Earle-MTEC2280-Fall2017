// global variables go here.
int drawMode = 1;
// draw modes will be:
// 0: ellipse
// 1: text

void setup() {
  size(500, 500);
  background(255);
  noStroke();

  fill(255, 0, 0);
}

void draw() {

  // what drawMode are we in?
  if (drawMode == 1) {
    // ellipse mode
    ellipse(mouseX, mouseY, 10, 10);
  }

  if (drawMode == 2) {
    // text mode
    text("Hello", mouseX, mouseY);
  }
}

// handle keyboard input
void keyPressed() {
  println(key);
  if (key == '1') {
    // if we press 1, change the 
    // draw mode to 1
    drawMode = 1;
  }

  if (key == '2') {
    // if we press 2, change the 
    // draw mode to 2
    drawMode = 2;
  }

  // if we hit R key, turn fill red...
  if (key == 'r') {
    fill(255, 0, 0);
  }
  if (key == 'g') {
    fill(0, 255, 0);
  }
  if (key == 'b') {
    fill(0, 0, 255);
  }
}