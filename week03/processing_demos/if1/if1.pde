void setup() {
  size(500, 500);

  noStroke();
}

void draw() {

  // if the mouse is on left side of screen
  if (mouseX < width/2) {

    float r = random(255);
    float g = random(255);
    float b = random(255);
    fill(r, g, b);

    float x = random(width);
    float y = random(height);
    ellipse(x, y, 20, 20);
  } 

  if (mouseX > width/2) {
    background(255, 0, 0);
  }
}