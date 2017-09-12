void setup() {
  size(600,600);
  background(255);
  noStroke();
  
  // make sure everything is drawn from
  // its center
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
  textSize(40);

  // only draw once per second
  //frameRate(1);
}

void draw() {
  
  // semi transparent bg
  fill(255,255,255,10);
  rect(width/2, height/2,width,height);
  
  // generate a random position
  // near the mouse
  float x = mouseX + random(-50, 50);
  float y = mouseY + random(-50, 50);
  
  // create random values for r,g,b vars
  float r = random(255);
  float g = random(255);
  float b = random(255);
  
  // use those variables to set the fill color
  fill(r,g,b);
  
  // determine which shape to draw
  int shapeChoice = int(random(3));
  println(shapeChoice);
  
  // logic!
  if(shapeChoice == 0) {
    // draw a rectangle
    rect(x,y,10,10);
  }
  
  if(shapeChoice == 1) {
    // draw an ellipse
    ellipse(x,y,10,10);
  }
  
  if(shapeChoice == 2) {
    // draw some text
    text("HEY!",x,y);
  }
 
}