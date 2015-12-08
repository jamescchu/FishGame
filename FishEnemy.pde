class FishEnemy extends Fish {

  FishEnemy(PVector spawn) {
    // Need to define size first
    fishSize = 30;

    // Create Box2d body
    makeBody(spawn.x, spawn.y);
    body.setUserData(this);

    randColor = colors.get("gold");

    float angle = random(TWO_PI);
    direction = new Vec2(cos(angle), sin(angle));
    speedvar = speed;
    noiseScale = 10;
    noiseStrength = random(-0.5, -0.8);
    accStrength = random(0.8, 0.9);

    fishLength = 22;

    location = new PVector[fishLength];

    // Duplicate body position to pvector
    Vec2 pos = box2d.getBodyPixelCoord(body);
    location[0] = new PVector(pos.x, pos.y);

    for (int i = 1; i < location.length; i++) {
      location[i] = location[0].copy();
    }
  }

  void mode() {
    if (!eh.gameOver) {
      Vec2 location = fh.fishes.get(0).getVecHead();

      speed = speedEnemyValue[eh.wave];
      fishSize = sizeEnemyValue[eh.wave];
      body.getFixtureList().getShape().setRadius(box2d.scalarPixelsToWorld(fishSize / 2));
      seek(location, 0.3);
    } else
      createNoise();
  }

  void display() {
    for (int i = 0; i < location.length; i++) {
      float size = map(i, 0, location.length, 1, fishSize);
      color c = lerpColor(colors.get("red"), colors.get("orange"), 
        map(i, 0, location.length, 1, 0));

      noStroke();
      fill(c);
      ellipse(location[i].x, location[i].y, size, size);
    }
    super.display();
  }

  void clicked() {
    float dis = dist(location[location.length-1].x, location[location.length-1].y, mouseX, mouseY);
    if (dis <= fishSize + 2) {
      eh.hurt();
      noStroke();
      fill(colors.get("white"));
      ellipse(mouseX, mouseY, 10, 10);
    }
  }

  void ate() {
  }

  void grow() {
  }

  void run() {
    if (hpEnemyValue[eh.wave] <= 0) {
      setDead();
    }
    mode();
    update();
    move();
    display();
  }
}