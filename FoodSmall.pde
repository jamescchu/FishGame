class FoodSmall extends Food {

  FoodSmall(Vec2 loc) {
    super(loc);
    foodSize = random(6,9);

    makeBody(loc.x, loc.y);
    body.setUserData(this);
  }

  void display() {

    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    // Get its angle of rotation
    pushMatrix();
    translate(pos.x, pos.y);
    fill(colors.get("orange"));
    ellipse(0, 0, foodSize, foodSize);
    popMatrix();
  }

  void run() {
    update();
    display();
  }
}