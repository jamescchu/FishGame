class Fish {
  ArrayList < Fish > fishes = new ArrayList < Fish > ();

  Body body;
  Vec2 direction;
  Vec2 VecLocation;

  PVector[] location;
  boolean isDead = false;
  float fishSize;
  float speed;
  float speedvar;
  float noiseScale;
  float noiseStrength;
  float accStrength;
  float wandertheta;
  int fishLength;
  color randColor;

  // Define colors
  HashMap < String, Integer > colors = new HashMap < String, Integer > () {
    {
      put("red", color(#E83503));
      put("gold", color(#FFC321));
      put("goldOrange", color(#F2A71B));
      put("redOrange", color(#F23005));
      put("orange", color(#FF8D04));
      put("white", color(#FFFAB0));
    }
  };

  int speedLevel = 0;
  float[] speedValue = {
    0.20, 0.28, 0.36, 0.44, 0.52, 0.6
  };

  int sizeLevel = 0;
  float[] sizeValue = {
    8, 12, 16, 18, 22, 26
  };

  int agileLevel = 0;
  float[] agileValue = {
    0.2, 0.3, 0.4, 0.8, 1.2, 2
  };

  Fish() {
  }

  void display() {
    if (debug) db.drawFishDebug(body, fishSize);
  }

  void seek(Vec2 loc) {
    seek(loc, 0.1);
  }

  void seek(Vec2 loc, float strength) {
    Vec2 location = getVecHead();
    float angle = atan2(loc.y - location.y, loc.x - location.x);

    Vec2 force = new Vec2(cos(angle), sin(angle));
    force.mulLocal(accStrength * strength);

    direction.addLocal(force);
    direction.normalize();
  }

  void steer(Vec2 loc) {
    steer(loc, 0.1);
  }

  void steer(Vec2 loc, float strength) {
    Vec2 location = getVecHead();

    float angle = atan2(loc.y - location.y, loc.x - location.x);

    Vec2 force = new Vec2(cos(angle), sin(angle));
    force.mulLocal(accStrength * strength);

    direction.addLocal(force);
    direction.normalize();
    ;

    float currentDistance = dist(loc.x, loc.y, location.x, location.y);

    // Slow down if it's close to target
    if (currentDistance < 5) {
      speed = map(currentDistance, 0, 5, 0, fh.speedValue[fh.speedLevel]);
    }
  }
  
  void createNoise() {
    Vec2 location = getVecHead();

    float noiseVal = noise(location.x / noiseScale, location.y / noiseScale); // Create noise value
    noiseVal *= PI * noiseStrength;
    Vec2 acceleration = new Vec2(cos(noiseVal), sin(-noiseVal));
    acceleration.mulLocal(accStrength);
    direction.addLocal(acceleration);
    direction.normalize();
  }

  // Based on Reynold's Wander behavior
  void wander() {
    Vec2 location = getVecHead();

    float wanderR = 20; // Radius for "wander circle"
    float wanderD = 10; // Distance for "wander circle"
    float change = 0.3;
    wandertheta += random(-change, change); // Randomly change wander theta

    Vec2 circleloc = direction.clone();
    circleloc.normalize(); // Normalize to get heading
    circleloc.mulLocal(wanderD); // Multiply by distance
    circleloc.addLocal(location); // Make it relative to boid's location

    float h = body.getAngle(); // We need to know the heading to offset wandertheta

    Vec2 circleOffSet = new Vec2(wanderR * cos(wandertheta + h), wanderR * sin(wandertheta + h));
    Vec2 target = circleloc.add(circleOffSet);
    seek(target, 0.2);

    if (debug) db.drawWanderDebug(location, circleloc, target, wanderR);
  }

  void update() {
  }

  void move() {
    Vec2 location = getVecHead();

    Vec2 velocity = direction.clone();
    velocity.mulLocal(speed);
    location.addLocal(velocity);

    applyForce(velocity); // Apply force to box2d body
    setHead(location); // Update fish head location
  }

  void spawnFishPlayer() {
    fishes.add(new FishPlayer());
  }

  void run() {
    // Itterate through ArrayList
    Iterator < Fish > it = fishes.iterator();
    while (it.hasNext()) {
      Fish f = it.next();
      f.run();
      if (f.isDead) {
        it.remove();
      }
    }
  }

  void mode(int type) {
    Vec2 mouseWorld = box2d.coordPixelsToWorld(mouseX, mouseY);
    switch (type) {
    case 0:
      // Food
      for (Food f : fd.foods) {
        Vec2 foodLoc = f.getFood();

        float dis = getFoodDistance();
        if (dis < 300 && !isMaxSize) { // If within range
          speed = speedvar * 1.2;
          float strength = map(dis, 0, 300, 5, 1); // Map strength to distance
          seek(foodLoc, strength);
        } else { // Revert to normal
          mode(currentMode);
        }
      }
      break;
    case 1:
      // Noise
      speed = speedvar;
      createNoise();
      break;
    case 2:
      // Wander
      speed = speedvar * 0.7;
      wander();
      break;
    case 3:
      // Seek
      speed = speedvar * 1.05;
      seek(mouseWorld);
      break;
    case 4:
      // Steer
      speed = speedvar * 1.05;
      steer(mouseWorld);
      break;
    }
  }

  void checkEdges() {
    // Get location of fish in pixels
    Vec2 location = box2d.coordWorldToPixels(getVecHead());
    float size = getSize(); // Get size of fish head

    if (location.x - size / 2 > width) {
      location.x = width - size / 2;
      setVecHead(location); // Teleport to opposite side
    }
    if (location.x + size / 2 < 0) {
      location.x = size / 2;
      setVecHead(location);
    }
    if (location.y - size / 2 > height) {
      location.y = height - size / 2;
      setVecHead(location);
    }
    if (location.y + size / 2 < guiZone) {
      location.y = guiZone + size / 2;
      setVecHead(location);
    }
  }

  void makeBody(float x, float y) {
    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position = box2d.coordPixelsToWorld(x, y);

    // Define a Circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(fishSize / 2);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    body = box2d.world.createBody(bd);
    body.createFixture(fd);
  }

  // Utilities

  Vec2 getVecHead() {
    return body.getWorldCenter();
  }

  void setHead(Vec2 pos) {
    location[location.length - 1] = box2d.coordWorldToPixelsPVector(pos);

    updateBody();
  }

  void setVecHead(Vec2 pos) {
    pos = box2d.coordPixelsToWorld(pos);
    body.setTransform(pos, body.getAngle());
  }

  void applyForce(Vec2 v) {
    body.applyForce(v, body.getWorldCenter());
  }

  void updateBody() {
    for (int i = 0; i < location.length - 1; i++) {
      location[i] = location[i + 1];
    }
  }

  void setDead() {
    isDead = true;
  }

  void grow() {
  }

  PVector getLoc() {
    return location[0].copy();
  }

  float getSize() {
    return fishSize;
  }

  float getFoodDistance() {
    float dis = 0;
    for (Food f : fd.foods) {
      Vec2 kL = box2d.coordWorldToPixels(getVecHead());
      Vec2 fL = box2d.coordWorldToPixels(f.getFood());

      dis = dist(kL.x, kL.y, fL.x, fL.y);
    }
    return dis;
  }
}