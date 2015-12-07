class FishEnemy extends Fish {

  FishEnemy() {
    // Need to define size first
    fishSize = 30;

    // Create Box2d body
    makeBody(random(width), random(height));
    body.setUserData(this);

    randColor = colors.get("gold");

    float angle = random(TWO_PI);
    direction = new Vec2(cos(angle), sin(angle));
    speedvar = speed;
    noiseScale = 10;
    noiseStrength = random(-0.5, -0.8);
    accStrength = random(0.8, 0.9);

    fishLength = int(random(10, 25));

    location = new PVector[fishLength];

    // Duplicate body position to pvector
    Vec2 pos = box2d.getBodyPixelCoord(body);
    location[0] = new PVector(pos.x, pos.y);

    for (int i = 1; i < location.length; i++) {
      location[i] = location[0].copy();
    }
  }

  void mode() {
    Vec2 location = fh.fishes.get(0).getVecHead();

    speed = eh.speedEnemyValue[eh.wave];
    fishSize = eh.sizeEnemyValue[eh.wave];
    body.getFixtureList().getShape().setRadius(box2d.scalarPixelsToWorld(fishSize / 2));
    seek(location, 2);
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
    float dis = dist(location[0].x, location[0].y, mouseX, mouseY);
    if (dis < fishSize + 12){
      eh.hurt();
    }
  }

  void ate() {
  }

  void grow() {
  }

  void run() {
    if (eh.hpEnemyValue[eh.wave] <= 0) {
      setDead(); 
    }
    mode();
    update();
    move();
    display();
  }
}