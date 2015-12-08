class Gui {
  GuiButton[] buttons = new GuiButton[5];
  HashMap < String, Integer > colors = new HashMap < String, Integer > () {
    {
      put("orange", color(#FF8D04));
      put("gold", color(#FFC321));
      put("gray", color(#C6C6C6));
      put("darkgray", color(#2D2D2D));
      put("white", color(#FFFFFF));
      put("red", color(#E83503));
    }
  };

  Gui() {
  }

  void display() {
    if (!eh.gameStart && !eh.gameOver) {
      showInstructions();
    } else if (eh.gameOver) {
      showGameOver();
    } else if (eh.gameWin) {
      showGameWin();
    } else if (eh.gameStart) {
      drawGameUI();
    }
  }

  void drawGameUI() {
    drawBase();
    showFoodCount();
    setUpgrades("SIZE LVL " + sizeLevel, sizeCost[sizeLevel], 20, 0);
    setUpgrades("SPEED LVL " + speedLevel, speedCost[speedLevel], 140, 1);
    setUpgrades("AGILITY LVL " + agileLevel, agileCost[agileLevel], 270, 2);
    setUpgrades("DAMAGE LVL " + dmgLevel, dmgCost[dmgLevel], 410, 3);
    setUpgrades("SPAWN RATE LVL " + spawnLevel, spawnCost[spawnLevel], 560, 4);
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].affordable(i);
      buttons[i].update();
    }

    showTimer();
  }

  void drawBase() {
    noStroke();
    rectMode(CENTER);
    fill(colors.get("orange"));
    rect(width/2, guiZone/2, width, guiZone);
  }

  void showFoodCount() {
    textFont(fontS);
    drawRightString("FOOD POINTS: " + eh.foodEaten, width - 20, guiZone/2 - 1, colors.get("white"), 16);
  }

  void showTimer() {
    if (!eh.gameStart) return;
    drawRightString("Predator Timer: " + eh.incoming/60, width - 180, guiZone/2 - 8, colors.get("red"), 16);
    drawRightString("WAVE: " + eh.wave, width - 180, guiZone/2 + 12, colors.get("white"), 12);
    if (eh.incoming <= 300)
      drawCenteredString("INCOMING " + eh.incoming/60, width/2, height/2 + 30, colors.get("red"), 20); 
  }

  void setUpgrades(String _type, int _cost, int _xPos, int id) {
    String cost = "COST " + _cost;
    if (_cost >= 30)
      cost = "MAXED OUT";
    textFont(fontS);
    drawString(_type, _xPos, guiZone/2 - 8, colors.get("white"), 16); 
    drawString(cost, _xPos, guiZone/2 + 12, colors.get("white"), 12); 
    buttons[id] = new GuiButton(_xPos + textWidth(_type)*1.4, guiZone/2 - 5);
  }

  void showGameOver() { 
    eh.waitTimer++;
    noStroke();
    fill(0, 100);
    rectMode(CORNERS);
    rect(0, 0, width, height);
    textFont(fontL);
    drawCenteredString("GAME OVER", width/2, height/2, colors.get("red"), 100); 
    textFont(fontS);
    drawCenteredString("YOU MADE IT TO WAVE: " + eh.wave, width/2, height/2 + 30, colors.get("white"), 20); 
    if (eh.waitTimer >= eh.waitAmount)
      drawCenteredString("CLICK TO RESTART", width/2, height/2 + 250, colors.get("orange"), 16);
  }

  void showGameWin() { 
    eh.waitTimer++;
    noStroke();
    fill(0, 100);
    rectMode(CORNERS);
    rect(0, 0, width, height);
    textFont(fontL);
    drawCenteredString("CONGRATULATIONS", width/2, height/2, colors.get("red"), 100); 
    textFont(fontS);
    drawCenteredString("YOU MADE IT PAST WAVE 5", width/2, height/2 + 30, colors.get("white"), 20); 
    if (eh.waitTimer >= eh.waitAmount)
      drawCenteredString("CLICK TO PLAY AGAIN", width/2, height/2 + 250, colors.get("orange"), 16);
  }

  void showInstructions() { 
    fill(0, 100);
    noStroke();
    rectMode(CORNERS);
    rect(0, 0, width, height);
    textFont(fontL);
    drawCenteredString("FISH SURVIVAL", width/2, height/2, colors.get("gold"), 100); 
    textFont(fontS);
    drawCenteredString("CREATED BY JAMES CHU", width/2, height/2 + 30, colors.get("white"), 20); 
    drawCenteredString("INSTRUCTIONS:", width/2, height/2 + 80, colors.get("white"), 16); 
    drawCenteredString("CONTROL FISH WITH ARROW KEYS", width/2, height/2 + 100, colors.get("white"), 16); 
    drawCenteredString("EAT FOOD TO GAIN FOOD POINTS", width/2, height/2 + 120, colors.get("white"), 16); 
    drawCenteredString("USE FOOD POINTS TO LEVEL UP YOUR FISH", width/2, height/2 + 140, colors.get("white"), 16); 
    drawCenteredString("CLICK ON PREDATOR TO KILL IT", width/2, height/2 + 160, colors.get("white"), 16);
    drawCenteredString("CLICK TO START", width/2, height/2 + 250, colors.get("red"), 16);
  }

  // Utilities
  void drawString(String _string, float _xPos, float _yPos, color _color, int size) {
    fill(_color);
    textAlign(LEFT, CENTER);
    textSize(size);
    text(_string, _xPos, _yPos);
  }

  void drawRightString(String _string, float _xPos, float _yPos, color _color, int size) {
    fill(_color);
    textAlign(RIGHT, CENTER);
    textSize(size);
    text(_string, _xPos, _yPos);
  }

  void drawButtonString(String _string, float _xPos, float _yPos, color _color) {
    fill(_color);
    textAlign(LEFT, TOP);
    textSize(20);
    text(_string, _xPos, _yPos);
  }

  void drawCenteredString(String _string, float _xPos, float _yPos, color _color, int size) {
    fill(_color);
    textAlign(CENTER);
    textSize(size);
    text(_string, _xPos, _yPos);
  }
}