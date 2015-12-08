class EventHandler extends Gui {
  int incoming;
  int wave;
  int waitTimer, waitAmount = 180;
  int waitWinTimer;
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
    if (incoming <= 0 && eh.wave != 6) {
      eh.wave++;

      spawnEnemy();

      int timer = 3600;
      if (eh.wave >= 4) timer = 2700;
      incoming = timer;
    }
    if (eh.wave >= 6) { 
      eh.wave = 6;
      incoming = 0;
      eh.waitWinTimer++;
    } else incoming--;
    if (eh.waitWinTimer >= eh.waitAmount * 2)
      eh.gameWin = true;
  }

  void spawnEnemy() {
    PVector spawn = new PVector(random(width), random(height));
    PVector victim = fh.fishes.get(0).getLoc(); // super unstable
    if (PVector.dist(spawn, victim) >= 300) {
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
    incoming = 3600;
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