class Face {

  // A Rectangle
  Rectangle r;

  // lerp!
  PVector prevPos, currPos;
  PVector prevDim, currDim;

  // Am I available to be matched?
  boolean available;

  // Should I be deleted?
  boolean delete;

  // How long should I live if I have disappeared?
  int totalTime = 20;
  int timer = totalTime;

  // Assign a number to each face
  int id;

  // syphon server for each? maybe this is crazy
  SyphonServer syphon;

  // Make me
  Face(int x, int y, int w, int h) {
    r = new Rectangle(x, y, w, h);
    available = true;
    delete = false;
    //id = faceCount;
    //faceCount++;

    // find first available id (some disappear)
    id = firstAvailableId();

    timer = totalTime;

    prevPos = new PVector(x, y);
    currPos = new PVector(x, y);
    prevDim = new PVector(w, h);
    currDim = new PVector(w, h);

    // set up syphon
    syphon = new SyphonServer(face_tracking.this, "Face" + id);
  }

  // Show me
  void display() {
    //fill(0, 0, 255, map(timer, 0, 10, 0, 100));
    canvas.stroke(0, 0, 255);
    canvas.noFill();
    canvas.rect(currPos.x*scaler, currPos.y*scaler, currDim.x*scaler, currDim.y*scaler);
    canvas.fill(255, 0, 0);
    canvas.text(""+id, r.x*scaler+10, r.y*scaler+30);
  }

  // Give me a new location / size
  // Oooh, it would be nice to lerp here!
  void update(Rectangle newR) {
    r = (Rectangle) newR.clone();


    currPos.x = (r.x * .5) + (prevPos.x * .5);
    currPos.y = (r.y * .5) + (prevPos.y * .5);
    prevPos.x = currPos.x;
    prevPos.y = currPos.y;

    currDim.x = (r.width * .1) + (prevDim.x * .9);
    currDim.y = (r.height * .1) + (prevDim.y * .9);
    prevDim.x = currDim.x;
    prevDim.y = currDim.y;
  }

  // send each face individually over syphon (woah)
  void sendSyphon() {
    PImage faceImg = img.get(int(currPos.x*scaler), int(currPos.y*scaler), int(currDim.x*scaler), int(currDim.y*scaler));
    faceImg.resize(width, height);

    syphon.sendImage(FlipVH(faceImg));
  }

  // Count me down, I am gone
  void countDown() {
    timer--;
  }

  // I am deed, delete me
  boolean dead() {
    if (timer < 0) {
      // and send out blackout image to syphon to erase
      syphon.sendImage(blackout.get());
      return true;
    } else {
      return false;
    }
  }
}