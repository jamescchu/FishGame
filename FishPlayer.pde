class FishPlayer extends Fish {

  FishPlayer() {
    // Need to define size first
    fishSize = 20;

    speed = 0.35;

    // Create Box2d body
    makeBody(width/2, height/2);
    body.setUserData(this);

    float angle = random(TWO_PI);
    direction = new Vec2(cos(angle), sin(angle));
    speedvar = speed;
    noiseScale = 10;
    noiseStrength = random(-1, -0.6);
    accStrength = random(0.4, 0.5);

    fishLength = 25;

    location = new PVector[fishLength];

    // Duplicate body position to pvector
    Vec2 pos = box2d.getBodyPixelCoord(body);
    location[0] = new PVector(pos.x, pos.y);

    for (int i = 1; i < location.length; i++) {
      location[i] = location[0].copy();
    }
  }

  void mode() {
    Vec2 location = box2d.coordPixelsToWorld(mp.getMover());

    speed = speedValue[speedLevel];
    fishSize = sizeValue[sizeLevel];
    body.getFixtureList().getShape().setRadius(box2d.scalarPixelsToWorld(fishSize / 2));
    float agile = agileValue[agileLevel];
    steer(location, agile);
  }

  void display() {
    for (int i = 0; i < location.length; i++) {
      float size = map(i, 0, location.length, 1, fishSize);
      color c = lerpColor(colors.get("goldOrange"), colors.get("white"), 
        map(i, 0, location.length, 1, 0));

      noStroke();
      fill(c);
      ellipse(location[i].x, location[i].y, size, size);
    }
    super.display();
  }

  void ate() {
    eh.foodEaten++;
  }

  void lost() {
    setDead();
    eh.gameOver = true;
  }

  void run() {
    mode();
    move();
    display();
    checkEdges();
  }

  Vec2 getLocation() {
    return fh.getVecHead();
  }
}