// cool drawing app that draws a different color
// depending on mouse position

void setup() {
  size(600,600);
  background(0);
  noStroke();
}

void draw() {
  // the map function takes in 5 arguments:
  // input value
  // input range (min, max)
  // output range (min, max)
  float myRed = map(mouseX, 0, width, 0, 255);
  float myGreen = map(mouseY, 0, height, 0, 255);
  
  // use those values to fill a circle at the mouse position
  fill(myRed, myGreen, 0);
  ellipse(mouseX, mouseY, 50, 50);
}