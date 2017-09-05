// semi transparent background-erase

void setup() {
  size(600,600);
  fill(255,0,0);
  noStroke();
  
  // start 
  background(0);
}

void draw() {
  // draw a rectangle instead of using background
  fill(0,0,0,5);
  rect(0,0,width,height);
  
  fill(255,0,0);
  ellipse(mouseX, mouseY, 50, 50);
}