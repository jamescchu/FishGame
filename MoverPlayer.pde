class MoverPlayer {

  // Use booleans to eliminate unreliable key triggers
  boolean right = false, left = false, up = false, down = false;
  float spd;
  float offset;

  PVector location;

  MoverPlayer() {
    location = new PVector(width/2, height/2);
  }

  void pressed() {
    if (key == CODED) {
      if (keyCode == UP) {
        up = true;
      } else if (keyCode == DOWN) {
        down = true;
      } else if (keyCode == LEFT) {
        left = true;
      } else if (keyCode == RIGHT) {
        right = true;
      }
    }
  }

  void released() {
    if (key == CODED) {
      if (keyCode == UP) {
        up = false;
      } else if (keyCode == DOWN) {
        down = false;
      } else if (keyCode == LEFT) {
        left = false;
      } else if (keyCode == RIGHT) {
        right = false;
      }
    }
  }

  void update() {
    spd = speedValue[speedLevel] * 10;
    if (left) location.x -= spd;
    else if (right) location.x += spd;

    if (up) location.y -=spd;
    else if (down) location.y += spd;
  }

  void run() {
    update();
    checkEdges();
  }
  
  void reset() {
    location.set(width/2, height/2);
  }

  void checkEdges() {
    PVector location = getMover();

    if (location.x > width) {
      location.x = width;
      setMover(location);
    }
    if (location.x < 0) {
      location.x = 0;
      setMover(location);
    }
    if (location.y > height) {
      location.y = height;
      setMover(location);
    }
    if (location.y < guiZone) {
      location.y = guiZone;
      setMover(location);
    }
  }

  PVector getMover() {
    return location.copy();
  }

  void setMover(PVector loc) {
    location = loc.copy();
  }
}