class GuiButton extends Gui {
  GuiButton[] buttons = new GuiButton[5];
  boolean enabled = true;
  float xPos, yPos;
  int size;

  final int mDefault = 0, mPressed = 1, mHover = 2, mDisabled = 3;

  GuiButton(float _xPos, float _yPos) {
    xPos = _xPos;
    yPos = _yPos-12;
    size = 25;
  }

  GuiButton() {
    this(0, 0);
  }

  void drawButton(int action) {
    int textColor = colors.get("white");
    switch(action) {
    case mDefault:
      textColor = colors.get("white");
      break;
    case mPressed:
      textColor = colors.get("gray");
      break;
    case mHover:
      textColor = colors.get("red");
      break;
    case mDisabled:
      textColor = colors.get("darkgray");
      break;
    }

    drawButtonString("+", xPos, yPos, textColor);
  }

  void affordable(int id) {
    switch(id) {
    case 0:
      if ( eh.foodEaten >= sizeCost[sizeLevel] && sizeLevel < 5) enabled = true;
      else if (sizeLevel >= 5)
        enabled = false;
      else enabled = false;
      break;
    case 1:
      if ( eh.foodEaten >=  speedCost[ speedLevel] &&  speedLevel < 5) enabled = true;
      else if ( speedLevel >= 5)
        enabled = false;
      else enabled = false;
      break;
    case 2:
      if ( eh.foodEaten >=  agileCost[ agileLevel] &&  agileLevel < 5) enabled = true;
      else if ( agileLevel >= 5)
        enabled = false;
      else enabled = false;
      break;
    case 3:
      if ( eh.foodEaten >=  dmgCost[ dmgLevel] &&  dmgLevel < 5) enabled = true;
      else enabled = false;
      break;
    case 4:
      if ( eh.foodEaten >=  spawnCost[ spawnLevel] &&  spawnLevel < 5) enabled = true;
      else enabled = false;
      break;
    }
  }

  boolean isPressed() {
    if (mouseX > xPos && mouseX < xPos+size && mouseY >  yPos && mouseY < yPos+size && enabled) {
      return true;
    }
    return false;
  }

  void click(int id) {
    if (mouseX > xPos && mouseX < xPos+size && mouseY >  yPos && mouseY < yPos+size && enabled) {
      switch(id) {
      case 0:
         eh.foodEaten -=  sizeCost[ sizeLevel];
         sizeLevel++;
        if ( sizeLevel > 5)  sizeLevel = 5;
        break;
      case 1:
         eh.foodEaten -=  speedCost[ speedLevel];
         speedLevel++;
        if ( speedLevel > 5)  speedLevel = 5;
        break;
      case 2:
         eh.foodEaten -=  agileCost[ agileLevel];
         agileLevel++;
        if ( agileLevel > 5)  agileLevel = 5;
        break;
      case 3:
         eh.foodEaten -=  dmgCost[ dmgLevel];
         dmgLevel++;
        if ( dmgLevel > 5)  dmgLevel = 5;
        break;
      case 4:
         eh.foodEaten -=  spawnCost[ spawnLevel];
         spawnLevel++;
        if ( spawnLevel > 5) spawnLevel = 5;
        break;
      }
    }
  }

  void update() {
    if (mouseX > xPos && mouseX < xPos+size && mouseY >  yPos && mouseY < yPos+size && enabled) {
      if (pressed) {
        drawButton(mPressed);
      } else 
      drawButton(mHover);
    } else if (!enabled)
      drawButton(mDisabled);
    else {
      drawButton(mDefault);
    }
  }
}