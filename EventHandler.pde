class EventHandler extends Gui {
  int incoming;
  int wave;
  int waitTimer, waitAmount = 180;
  boolean gameStart = false, gameOver = false, gameWin = false;

  int foodEaten = 0;

  EventHandler() {
    spawnLevel = 5;
  }

  void run() {
    if (random(spawnValue[spawnLevel]) < 0.5) {
      fd.spawnFood(random(width), random(height));
    }
    if (!eh.gameStart) return;
    if (incoming <= 0 && eh.wave != 5) {
      eh.wave++;

      spawnEnemy();

      int timer = 3600;
      if (eh.wave >= 4) timer = 1800;
      incoming += timer;
    }
    if (eh.wave >= 5) { 
      eh.wave = 5;
      incoming = 0;
      eh.waitTimer++;
    } else incoming--;
    if (eh.waitTimer >= eh.waitAmount * 2)
      eh.gameWin = true;
  }

  void spawnEnemy() {
    PVector spawn = new PVector(random(width), random(height));
    PVector victim = fh.fishes.get(0).getLoc(); // super unstable
    if (spawn.dist(spawn, victim) >= 300) {
      fh.spawnFishEnemy(spawn);
    } else
      spawnEnemy();
  }

  void resetGame() {
    eh.gameOver = false;
    eh.gameWin = false;
    fd.foods.clear();
    fh.fishes.clear();
    fh.spawnFishPlayer();
    mp.reset();
    speedLevel = 0;
    sizeLevel = 0;
    agileLevel = 0;
    dmgLevel = 0;
    spawnLevel = 0;
    foodEaten = 0;
    waitTimer = 0;
    incoming = 5400;
    wave = 0;
  }

  void startGame() {
    eh.gameStart = true; 
    resetGame();
  }

  void hurt() {
    hpEnemyValue[wave] -= dmgValue[dmgLevel];
  }
}