class GuiButton extends Gui {
  ArrayList < GuiButton > buttons = new ArrayList < GuiButton > ();
  boolean enabled, activated, buttonClicked = false;
  float xPos, yPos;
  int size;
  String text;

  final int mDefault = 0, mPressed = 1, mHover = 2, mDisabled = 3;

  GuiButton(float _xPos, float _yPos) {
    xPos = _xPos;
    yPos = _yPos-12;
    size = 25;
    enabled = true;
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

  void update() {
    if (mouseX > xPos && mouseX < xPos+size && mouseY >  yPos && mouseY < yPos+size) {
      if (pressed) {
        if (enabled) { 
          drawButton(mPressed); 
          activated = true;
        } else {
          drawButton(mDisabled);
          activated = false;
        }
      } else {
        drawButton(mHover); 
        activated = false;
      }
    } else {
      drawButton(mDefault);
      activated = false;
    }
    activated = false;
  }

  void run() {
    Iterator < GuiButton > it = buttons.iterator();
    while (it.hasNext()) {
      GuiButton g = it.next();
      g.update();
      if (g.activated) {
        println(g.activated);
      }
    }
  }
}