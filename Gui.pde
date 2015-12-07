class Gui {
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
    drawUpgrades("SPEED", 500);
  }

  void drawBase() {
    noStroke();
    rectMode(CENTER);
    fill(colors.get("orange"));
    rect(width/2, guiZone/2, width, guiZone);
  }

  void drawUpgrades(String _type, int _xPos) {
    drawString(_type, _xPos, guiZone/2, colors.get("white")); 
    gb.buttons.add(new GuiButton(_xPos + textWidth(_type) + 5, guiZone/2));
    gb.run();
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
    textAlign(LEFT, CENTER);
    textSize(16);
    text(_string, _xPos/2, _yPos);
  }
}