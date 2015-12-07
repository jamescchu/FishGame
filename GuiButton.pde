class GuiButton extends Gui {
  GuiButton[] buttons = new GuiButton[5];
  boolean enabled, activated, bClicked;
  float xPos, yPos;
  int size;
  String tag;

  final int mDefault = 0, mPressed = 1, mHover = 2, mDisabled = 3;

  GuiButton(float _xPos, float _yPos, String _tag) {
    xPos = _xPos;
    yPos = _yPos-12;
    tag = _tag;
    size = 25;
    enabled = false;
    activated = false;
    bClicked = false;
  }

  GuiButton() {
    this(0, 0, "");
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

  boolean isPressed() {
    if (mouseX > xPos && mouseX < xPos+size && mouseY >  yPos && mouseY < yPos+size && enabled) {
      return true;
    }
    return false;
  }

  void click(int id) {
    if (mouseX > xPos && mouseX < xPos+size && mouseY >  yPos && mouseY < yPos+size) {
      switch(id) {
      case 0:
        eh.sizeLevel++;
        if (eh.sizeLevel > 5) eh.sizeLevel = 5;
        break;
      case 1:
        eh.speedLevel++;
        if (eh.speedLevel > 5) eh.speedLevel = 5;
        break;
      case 2:
        eh.agileLevel++;
        if (eh.agileLevel > 5) eh.agileLevel = 5;
        break;
        case 3:
        eh.dmgLevel++;
        if (eh.dmgLevel > 5) eh.dmgLevel = 5;
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