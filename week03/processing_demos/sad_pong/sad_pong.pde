// global variables
float xPos;
float yPos;
float d = 100;
// how fast is the pong ball moving?
float xSpeed = 4;
float ySpeed = -4;

void setup() {
  size(600, 400);
  background(0);

  // position the ball
  xPos = width/2;
  yPos = height/2;

}

void draw() {
  background(0);

  // move the pong ball
  xPos = xPos + xSpeed;
  yPos = yPos + ySpeed;

  // if pong ball hits right side screen
  if (xPos >= width) {
    xSpeed = xSpeed * -1;
    // randomize the color
    fill(random(255),random(255),random(255));
  } 

  // if pong ball hits left side of screen
  if (xPos <= 0) {
    xSpeed = xSpeed * -1;
    fill(random(255),random(255),random(255));
  }

  // if pong ball hits bottom
  if (yPos >= height) {
    ySpeed = ySpeed * -1;
    fill(random(255),random(255),random(255));
  } 

  // if pong ball hits top
  if (yPos <= 0) {
    ySpeed = ySpeed * -1;
    fill(random(255),random(255),random(255));
  }

  // draw the pong ball
  ellipse(xPos, yPos, d, d);
}