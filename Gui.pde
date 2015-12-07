class Gui {
  GuiButton[] buttons = new GuiButton[3];
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
    showFoodCount(600);
    setUpgrades("SIZE LVL " + eh.sizeLevel, 50, 0);
    setUpgrades("SPEED LVL " + eh.speedLevel, 200, 1);
    setUpgrades("AGILITY LVL " + eh.agileLevel, 350, 2);
    setUpgrades("DAMAGE LVL " + eh.dmgLevel, 350, 2);
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].update();
    }
  }

  void drawBase() {
    noStroke();
    rectMode(CENTER);
    fill(colors.get("orange"));
    rect(width/2, guiZone/2, width, guiZone);
  }
  
  void showFoodCount(int _xPos) {
    drawString("Food Eaten " + eh.foodEaten, _xPos, guiZone/2 - 1, colors.get("white")); 
  }

  void setUpgrades(String _type, int _xPos, int id) {
    drawString(_type, _xPos, guiZone/2 - 1, colors.get("white")); 
    //buttons.add( new GuiButton(_xPos + textWidth(_type) + 5, guiZone/2, _type));
    buttons[id] = new GuiButton(_xPos + textWidth(_type) + 5, guiZone/2 + 1, _type);
  }

  // Utilities
  void drawString(String _string, float _xPos, float _yPos, color _color) {
    fill(_color);
    textAlign(LEFT, CENTER);
    textSize(16);
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