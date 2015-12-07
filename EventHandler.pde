class EventHandler extends Gui {
  int incoming;
  int wave;
  boolean gameStart = false, gameOver = false;
  
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
    0.3, 0.5, 0.6, 0.8, 1.2, 2
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
  
  int spawnLevel = 0;
  float[] spawnValue = {
    30, 27, 25, 21, 16, 10
  };
  int[] spawnCost = {
    5, 10, 15, 20, 25, 30
  };
  
  float[] speedEnemyValue = {
    0.25, 0.32, 0.37, 0.44, 0.55, 0.65
  };

  float[] sizeEnemyValue = {
    26, 22, 20, 16, 12, 10
  };
  
  float[] hpEnemyValue = {
    12, 16, 20, 35, 40, 60
  };

  int foodEaten = 0;

  EventHandler() {
    incoming = 5400;
    wave = 0;
  }

  void run() {
    incoming--;
    if (incoming == 0) {
      eh.wave++;
      if (eh.wave > 5) eh.wave = 5;
      fh.spawnFishEnemy();
      
      int timer = 3600;
      if (eh.wave >= 4) timer = 1800;
      incoming += timer;
    }
    if (random(eh.spawnValue[eh.spawnLevel]) < 0.5) {
      fd.spawnFood(random(width), random(height));
    }
  }
  
  void hurt() {
    eh.hpEnemyValue[eh.wave] -= eh.dmgValue[eh.dmgLevel];
  }
  
  void showTimer() {
    drawString("ENEMY INCOMING: " + incoming/60, 900, guiZone/2, colors.get("red"), 16);
  }
}