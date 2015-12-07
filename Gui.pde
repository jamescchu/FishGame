class Gui {
  GuiButton[] buttons = new GuiButton[5];
  HashMap < String, Integer > colors = new HashMap < String, Integer > () {
    {
      put("orange", color(#FF8D04));
      put("gray", color(#C6C6C6));
      put("darkgray", color(#2D2D2D));
      put("white", color(#FFFFFF));
      put("red", color(#E83503));
    }
  };

  Gui() {
  }

  void display() {
    drawBase();
    showFoodCount(1100);
    setUpgrades("SIZE LVL " + eh.sizeLevel, eh.sizeCost[eh.sizeLevel], 20, 0);
    setUpgrades("SPEED LVL " + eh.speedLevel, eh.speedCost[eh.speedLevel], 140, 1);
    setUpgrades("AGILITY LVL " + eh.agileLevel, eh.agileCost[eh.agileLevel], 270, 2);
    setUpgrades("DAMAGE LVL " + eh.dmgLevel, eh.dmgCost[eh.dmgLevel], 410, 3);
    setUpgrades("SPAWN RATE LVL " + eh.spawnLevel, eh.spawnCost[eh.spawnLevel],560, 4);
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].affordable(i);
      buttons[i].update();
    }
    
    eh.showTimer();
  }

  void drawBase() {
    noStroke();
    rectMode(CENTER);
    fill(colors.get("orange"));
    rect(width/2, guiZone/2, width, guiZone);
  }

  void showFoodCount(int _xPos) {
    drawString("FOOD EATEN " + eh.foodEaten, _xPos, guiZone/2 - 1, colors.get("white"), 16);
  }

  void setUpgrades(String _type, int _cost, int _xPos, int id) {
    String cost = "COST " + _cost;
    if (_cost >= 30)
      cost = "MAXED OUT";
    drawString(_type, _xPos, guiZone/2 - 5, colors.get("white"), 16); 
    drawString(cost, _xPos, guiZone/2 + 12, colors.get("white"), 12); 
    buttons[id] = new GuiButton(_xPos + textWidth(_type)*1.4, guiZone/2 - 2);
  }

  // Utilities
  void drawString(String _string, float _xPos, float _yPos, color _color, int size) {
    fill(_color);
    textAlign(LEFT, CENTER);
    textSize(size);
    text(_string, _xPos, _yPos);
  }

  void drawButtonString(String _string, float _xPos, float _yPos, color _color) {
    fill(_color);
    textAlign(LEFT, TOP);
    textSize(20);
    text(_string, _xPos, _yPos);
  }

  void drawCenteredString(String _string, float _xPos, float _yPos, color _color) {
    fill(_color);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(_string, _xPos/2, _yPos);
  }
}