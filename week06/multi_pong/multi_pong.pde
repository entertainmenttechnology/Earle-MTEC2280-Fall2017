// name the arrays
float pongX[];
float pongY[];

// and speed arrays
float pongXSpeed[];
float pongYSpeed[];

// how many pong balls?
int pongCount = 300;

void setup() {
  size(600,600);

  // tell the computer there will be 100 members in the arrays
  pongX = new float[pongCount];
  pongY = new float[pongCount];
  
  pongXSpeed = new float[pongCount];
  pongYSpeed = new float[pongCount];
  
  // initialize all the array members to random values
  for(int i = 0; i < pongCount; i++) {
    pongX[i] = random(width);
    pongY[i] = random(height);
    
    pongXSpeed[i] = random(5);
    pongYSpeed[i] = random(5);
  }
  
  // drawing properties for the entire sketch
  noStroke();
  fill(255);
}

void draw() {
  background(0);
  
  // cycle thru all the members of the arrays
  for(int i = 0; i < pongCount; i++) {
    
    // move pong balls
    pongX[i] += pongXSpeed[i];
    pongY[i] += pongYSpeed[i];
    
    // if they hit the sides...
    if(pongX[i] > width || pongX[i] < 0) {
      pongXSpeed[i] *= -1;
    }
    
    if(pongY[i] > height || pongY[i] < 0) {
      pongYSpeed[i] *= -1;
    }
    
    // draw it
    ellipse(pongX[i], pongY[i], 10, 10);
  }
}