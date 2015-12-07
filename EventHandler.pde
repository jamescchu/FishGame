class EventHandler {
  int counter;
  
  int speedLevel = 0;
  float[] speedValue = {
    0.20, 0.28, 0.36, 0.44, 0.52, 0.6
  };
  int[] speedCost = {
    5, 10, 15, 20, 25, 30
  };

  int sizeLevel = 0;
  float[] sizeValue = {
    8, 12, 16, 18, 22, 26
  };
  int[] sizeCost = {
    5, 10, 15, 20, 25, 30
  };

  int agileLevel = 0;
  float[] agileValue = {
    0.3, 0.4, 0.5, 0.8, 1.2, 2
  };
  int[] agileCost = {
    5, 10, 15, 20, 25, 30
  };

  int dmgLevel = 0;
  float[] dmgValue = {
    1, 2, 3, 4, 5, 6
  };
  int[] dmgCost = {
    5, 10, 15, 20, 25, 30
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