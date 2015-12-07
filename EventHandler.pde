class EventHandler {
  int counter;
  
  int costLevel = 0;
  float[] costMult = {
    1.2, 2.5, 3.5, 4.5, 6.5, 8.5
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
    0.3, 0.4, 0.5, 0.8, 1.2, 2
  };

  int dmgLevel = 0;
  float[] dmgValue = {
    1, 2, 3, 4, 5, 6
  };

  int foodEaten = 0;

  EventHandler() {
    counter = 0;
  }

  void run() {
    counter++;
    if (random(30) < 0.5) {
      fd.spawnFood(random(width), random(height));
    }
  }
}