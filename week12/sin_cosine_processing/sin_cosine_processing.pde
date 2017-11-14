// keep track of where we are on the wave
float theta = 0.0;
// how fast do we move thru the wave
float delta = TWO_PI * .002;
// radius of circle
float radius;

void setup() {
  size(500, 500);
  radius = width/2;
}
void draw() {
  // advance thru wave
  theta += delta;
  background(0);
  // x and y are equal to the theta
  // of cosine and sine, respectively
  float x = cos(theta) * radius;
  float y = sin(theta) * radius;
  
  // offset to middle screen
  x+= width/2;
  y+= height/2;
  
  // draw cos x in red
  fill(255,0,0);
  ellipse(x, height/2, 10, 10);
  // draw sin y in green
  fill(0,255,0);
  ellipse(width/2, y, 10, 10);
  // draw both together
  fill(255,255,0);
  ellipse(x, y, 10, 10);
}