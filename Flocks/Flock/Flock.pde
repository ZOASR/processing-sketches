int Boids = 400;

Boid[] flock = new Boid[Boids];


int     nFramesInLoop = 120;
int     nElapsedFrames;
boolean bRecording; 

void setup() {
  //size (800, 600); 
  fullScreen();
  bRecording = false;
  nElapsedFrames = 0;
  for (int i = 0; i < Boids; i++) {
        flock[i] = (new Boid(random(width), random(height)));
    }
}

void keyPressed() {
  if ((key == 'f') || (key == 'F')) {
    bRecording = true;
    nElapsedFrames = 0;
  }
}

void draw() {
  renderMyDesign ();

  if (bRecording) {
    saveFrame("frames/frame_" + nf(nElapsedFrames, 4) + ".png");
    nElapsedFrames++; 
    if (nElapsedFrames >= nFramesInLoop) {
      bRecording = false;
    }
  }
}

void renderMyDesign () {
  background(0);
    for (Boid f : flock) {
        //f.follow(random(width), random(height));
        f.flock(flock, 5, 5, 6);
        f.update();
        f.show();
        f.edges();
    }
}
