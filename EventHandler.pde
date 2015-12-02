class EventHandler {

  EventHandler() {
  }

  void run() {
    if (random(20) < 0.5) {
      fd.spawnFood(random(width), random(height));
    }
  }
}