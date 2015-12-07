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
      if (eh.foodEaten >= eh.sizeCost[eh.sizeLevel] && eh.sizeLevel < 5) enabled = true;
      else if (eh.sizeLevel >= 5)
        enabled = false;
      else enabled = false;
      break;
    case 1:
      if (eh.foodEaten >= eh.speedCost[eh.speedLevel] && eh.speedLevel < 5) enabled = true;
      else if (eh.speedLevel >= 5)
        enabled = false;
      else enabled = false;
      break;
    case 2:
      if (eh.foodEaten >= eh.agileCost[eh.agileLevel] && eh.agileLevel < 5) enabled = true;
      else if (eh.agileLevel >= 5)
        enabled = false;
      else enabled = false;
      break;
    case 3:
      if (eh.foodEaten >= eh.dmgCost[eh.dmgLevel] && eh.dmgLevel < 5) enabled = true;
      else enabled = false;
      break;
    case 4:
      if (eh.foodEaten >= eh.spawnCost[eh.spawnLevel] && eh.spawnLevel < 5) enabled = true;
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
        eh.foodEaten -= eh.sizeCost[eh.sizeLevel];
        eh.sizeLevel++;
        if (eh.sizeLevel > 5) eh.sizeLevel = 5;
        break;
      case 1:
        eh.foodEaten -= eh.speedCost[eh.speedLevel];
        eh.speedLevel++;
        if (eh.speedLevel > 5) eh.speedLevel = 5;
        break;
      case 2:
        eh.foodEaten -= eh.agileCost[eh.agileLevel];
        eh.agileLevel++;
        if (eh.agileLevel > 5) eh.agileLevel = 5;
        break;
      case 3:
        eh.foodEaten -= eh.dmgCost[eh.dmgLevel];
        eh.dmgLevel++;
        if (eh.dmgLevel > 5) eh.dmgLevel = 5;
        break;
      case 4:
        eh.foodEaten -= eh.spawnCost[eh.spawnLevel];
        eh.spawnLevel++;
        if (eh.spawnLevel > 5) eh.spawnLevel = 5;
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