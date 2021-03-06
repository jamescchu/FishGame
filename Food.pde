class Food { //<>//
  ArrayList < Food > foods = new ArrayList < Food > ();

  Vec2 location;
  Body body;
  float foodSize;
  int spawnTimer;
  boolean isEaten;
  HashMap < String, Integer > colors = new HashMap < String, Integer > () {
    {
      put("orange", color(#E57345));
    }
  };

  Food(Vec2 loc) {
    location = loc.clone();
    isEaten = false;
  }

  Food() {
    this(new Vec2(0, 0));
    isEaten = false;
  }

  void display() {
  }

  void update() {
    spawnTimer++;
    if (spawnTimer > 550) {
      float r = random(5);
      if (r < 0.3)
        dissolve();
    }
  }

  void run() {
    // Iterate through ArrayList
    update();
    Iterator < Food > it = foods.iterator();
    while (it.hasNext()) {
      Food f = it.next();
      f.run();
      if (f.isEaten) {
        it.remove();
      }
    }
  }

  void makeBody(float x, float y) {
    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position = box2d.coordPixelsToWorld(x, y);

    // Define a Circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(foodSize / 2);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    body = box2d.world.createBody(bd);
    body.createFixture(fd);

    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-3, 3));
  }

  void spawnFood(float x, float y) {
    foods.add(new FoodSmall(new Vec2(x, y)));
  }

  Vec2 getFood() {
    return body.getWorldCenter();
  }

  void setVecFood(Vec2 pos) {
    pos = box2d.coordPixelsToWorld(pos);
    body.setTransform(pos, body.getAngle());
  }

  void dissolve() {
    eaten();
  }

  void eaten() {
    isEaten = true;
  }
}