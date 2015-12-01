class Debug {
  Debug() {}

  void drawWanderDebug(Vec2 _location, Vec2 _circle, Vec2 _target, float rad) {
    Vec2 location = box2d.coordWorldToPixels(_location);
    Vec2 circle = box2d.coordWorldToPixels(_circle);
    Vec2 target = box2d.coordWorldToPixels(_target);
    stroke(255);
    noFill();
    ellipseMode(CENTER);
    ellipse(circle.x, circle.y, rad * 2, rad * 2);
    ellipse(target.x, target.y, 4, 4);
    line(location.x, location.y, circle.x, circle.y);
    line(circle.x, circle.y, target.x, target.y);
  }

  void drawFishDebug(Body body, float size) {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(255);
    ellipse(0, 0, size, size);
    stroke(255);
    strokeWeight(1);
    // Let's add a line so we can see the rotation
    line(0, 0, size, 0);
    popMatrix();
  }
}