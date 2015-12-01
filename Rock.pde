class Rock {

  Vec2 location;
  Body body;
  float foodSize;
  boolean isEaten;

  Rock() {
    makeBody(250, 500);
    body.setUserData(this);
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    // Get its angle of rotation
    float a = body.getAngle();

    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    image(rock, 0, 0);
    popMatrix();
  }

  void run() {
    display();
  }

  void makeBody(float x, float y) {
    // Define the body and make it from the shape
    PolygonShape rk = new PolygonShape();

    // Bottom half
    Vec2[] vertices1 = new Vec2[6];
    vertices1[0] = box2d.vectorPixelsToWorld(new Vec2(29, 128));
    vertices1[1] = box2d.vectorPixelsToWorld(new Vec2(37, 129));
    vertices1[2] = box2d.vectorPixelsToWorld(new Vec2(179, 44));
    vertices1[3] = box2d.vectorPixelsToWorld(new Vec2(179, 55));
    vertices1[4] = box2d.vectorPixelsToWorld(new Vec2(18, 89));
    vertices1[5] = box2d.vectorPixelsToWorld(new Vec2(12, 121));

    PolygonShape rk2 = new PolygonShape();

    // Top half
    Vec2[] vertices2 = new Vec2[6];
    vertices2[0] = box2d.vectorPixelsToWorld(new Vec2(12, 121));
    vertices2[1] = box2d.vectorPixelsToWorld(new Vec2(152, 6));
    vertices2[2] = box2d.vectorPixelsToWorld(new Vec2(84, 8));
    vertices2[3] = box2d.vectorPixelsToWorld(new Vec2(22, 79));
    vertices2[4] = box2d.vectorPixelsToWorld(new Vec2(179, 44));
    vertices2[5] = box2d.vectorPixelsToWorld(new Vec2(171, 12));

    rk.set(vertices1, vertices1.length);
    rk2.set(vertices2, vertices2.length);

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);

    body.createFixture(rk, 1.0);
    body.createFixture(rk2, 1.0);
  }
}