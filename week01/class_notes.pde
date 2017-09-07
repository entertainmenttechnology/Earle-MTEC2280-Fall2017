void setup() {
  size(500, 500);
  background(0);  // black background
}

void draw() {
  background(0);
  // draw the menu
  fill(255,0,0);
  noStroke();
    
  // create variable "x" which is of type
  // float, which means it has a decimal point
  // then use the equal sign to give it a value
  float x = .1 * width;
  float y = .2 * height;
  float w = .25 * width;
  float h = .5 * height;
  
  rect(x, y, w, h);
}