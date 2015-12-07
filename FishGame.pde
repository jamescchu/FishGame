import java.util.Iterator; //<>//
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;
Fish fh;
Food fd;
Debug db;
Utilities utl;
MoverPlayer mp;
EventHandler eh;
Gui gui;

PFont fontL;
PFont fontS;
int currentMode = 1;
boolean debug = false, click = false, pressed = false;
int guiZone = 48;

void setup() {
  size(1280, 768, P2D); 
  //fullScreen();
  noStroke();
  fontL = createFont("Helvetica", 100);
  fontS = createFont("Helvetica", 20);
  textFont(fontL);

  // Initialize Box2D
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0);

  box2d.listenForCollisions();

  fh = new Fish();
  fd = new Food();
  db = new Debug();
  utl = new Utilities();
  mp = new MoverPlayer();
  eh = new EventHandler();
  gui = new Gui();
}

void draw() {
  background(#282927);

  // Step forward in time
  box2d.step();

  mp.run();
  eh.run();

  fd.run();
  fh.run();

  gui.display();

  if (debug) db.display();
}

void keyPressed ()
{
  if (key == 'l') {
    debug = !debug;
  }
  if (key == 'k' && debug) {
    eh.foodEaten++;
  }
  mp.pressed();
}

void keyReleased ()
{
  mp.released();
}

void mouseClicked() {
  if (!eh.gameStart) { 
    eh.startGame();
    return;
  }
  if (eh.gameOver) { 
    eh.resetGame();
    return;
  }
  for ( Fish f : fh.fishes) {
    f.clicked();
  }
  for (int i = 0; i < gui.buttons.length; i++) {
    if (gui.buttons[i].isPressed()) {
      gui.buttons[i].click(i);
    }
  }
}

void mousePressed() {
  pressed = true;
}

void mouseReleased() {
  pressed = false;
}

void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == FishPlayer.class && o2.getClass() == FoodSmall.class) {
    Fish p1 = (FishPlayer) o1;
    Food p2 = (FoodSmall) o2;
    p1.ate();
    p2.eaten();
  }

  if (o1.getClass() == FishPlayer.class && o2.getClass() == FishEnemy.class) {
    Fish p1 = (FishPlayer) o1;
    Fish p2 = (FishEnemy) o2;
    p1.eaten();
  }
}

void endContact(Contact cp) {
}