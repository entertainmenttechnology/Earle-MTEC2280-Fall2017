void setup() {
  
  size(500,500);
  
}

void draw() {
  if(mouseY < height/2) {
    // happens
    stroke(random(255), random(255), random(255));
    
    float x1 = random(width);
    float y1 = random(height);
    float x2 = random(width);
    float y2 = random(height);
    
    line(x1,y1,x2,y2);
  }
}