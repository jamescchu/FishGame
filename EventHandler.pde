class EventHandler {

  EventHandler() {
  }

  void run() {
    if (random(50) < 0.5) {
      fd.spawnFood(random(width), random(height));
    }
  }
}