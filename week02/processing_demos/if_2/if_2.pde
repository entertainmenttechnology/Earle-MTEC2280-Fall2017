void setup() {
  size(500,500);
}

void draw() {
  
  // if the mouse is on the right side
  // of the screen...
  if(mouseX > width/2) {
    background(255,0,0);  // red bg
  } else {
    // else... the only other option
    // is that the mouse is on the left
    // side of the screen
    background(0,0,255);  // blue bg
  }
  
  line(width/2, 0, width/2, height);
}