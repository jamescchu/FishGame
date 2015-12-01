class FishGoldKoi extends Fish {

  FishGoldKoi() {
    // Need to define size first
    fishSize = random(13, 22);
    maxSize = 26;

    // Create Box2d body
    makeBody(random(width), random(height));
    body.setUserData(this);
    
    randColor = colors.get("gold");

    float angle = random(TWO_PI);
    direction = new Vec2(cos(angle), sin(angle));
    speed = random(0.3, 0.4);
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

  void display() {
    for (int i = 0; i < location.length; i++) {
      float size = map(i, 0, location.length, 1, fishSize);
      randColor = isStarved ? colors.get("white") : randColor;
      color c = lerpColor(randColor, colors.get("orange"), 
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
    fishSize = fishSize + 0.5; 
    fishLength = fishLength + 1;
  }

  void run() {
    // If there is food spawned, then run food mode
    int s = fd.foods.isEmpty() ? currentMode : 0;

    mode(s);
    update();
    move();
    display();
    checkEdges();
  }
}