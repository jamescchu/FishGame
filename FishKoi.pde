class FishKoi extends Fish {

  FishKoi() {
    // Need to define size first
    fishSize = fishLength < 15 ? random(13, 14) : random(16, 18);
    maxSize = 26;

    // Create Box2d body
    makeBody(random(width), random(height));
    body.setUserData(this);

    // Set random cololor variable
    randColor = random(1) > 0.5 ? colors.get("red") : colors.get("goldOrange");

    float angle = random(TWO_PI);
    direction = new Vec2(cos(angle), sin(angle));
    speed = fishSize < 13 ? random(0.25, 0.35) : random(0.35, 0.5);
    speedvar = speed;
    noiseScale = 10;
    noiseStrength = random(-1, -0.6);
    accStrength = random(0.4, 0.5);

    fishLength = int(random(10, 25));

    location = new PVector[fishLength];

    // Duplicate body position to pvector
    Vec2 pos = box2d.getBodyPixelCoord(body);
    location[0] = new PVector(pos.x, pos.y);

    for (int i = 1; i < location.length; i++) {
      location[i] = location[0].copy();
    }
  }

  void display() {
    for (int i = 0; i < location.length; i++) {
      float size = map(i, 0, location.length, 1, fishSize);
      randColor = isStarved ? colors.get("white") : randColor;
      color c = lerpColor(randColor, colors.get("white"), 
        map(i, 0, location.length, 1, 0));

      noStroke();
      fill(c);
      ellipse(location[i].x, location[i].y, size, size);
    }
    super.display();
  }

  void grow() {
    if (fishSize > maxSize) isMaxSize = true;
    if (isMaxSize) return;
    eatTimer = 0;
    fishSize = fishSize + 1; 
    fishLength = fishLength + 1;
  }

  void run() {
    int s = fd.foods.isEmpty() ? currentMode : 0;
    mode(s);
    update();
    move();
    display();
    checkEdges();
  }
}