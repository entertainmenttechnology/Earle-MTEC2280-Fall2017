void setup() {
  size(600, 600);
  noStroke();
}

void draw() {
  background(255);
  // avoid zeros
  if (mouseX > 0 && mouseY > 0) {
    
    // loop thru both X and Y
    for (int x = 0; x < width; x += mouseX) {
      for (int y = 0; y < height; y += mouseY) {
        // create a scaled red color and blue
        float mappedRed = map(x, 0, width, 0, 255);
        float mappedBlue = map(y, 0, height, 0, 255);

        fill(mappedRed, 0, mappedBlue);
        rect(x, y, mouseX, mouseY);
      }
    }
  }
}