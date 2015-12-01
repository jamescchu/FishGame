class MoverPlayer {

  // Use booleans to eliminate unreliable key triggers
  boolean right = false, left = false, up = false, down = false;
  float spd = 5;

  PVector location;

  MoverPlayer() {
    location = new PVector(width/2, height/2);
  }

  void pressed() {
    int k = key;
    switch(k) {
    case 'w': 
      up = true; 
    case 's': 
      down = true;
    case 'a': 
      left = true; 
    case 'd': 
      right = true;
    }
  }

  void released() {
    int k = key;
    switch(k) {
    case 'w': 
      up = false; 
    case 's': 
      down = false;
    case 'a': 
      left = false; 
    case 'd': 
      right = false;
    }
  }

  void update() {
    if (up) {
      location.y -= spd;
    } else if (down) {
      location.y += spd;
    } else if (left) {
      location.x -= spd;
    } else if (right) {
      location.x += spd;
    }
  }

  void run() {
    update();
  }

  PVector getMover() {
    return location.copy();
  }
}