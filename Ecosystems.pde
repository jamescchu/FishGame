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
Rock rk;
Debug db;
Utilities utl;

PImage rock;
int koiCount = 95;
int goldKoiCount = 5;
int currentMode = 1;
boolean debug = false;
String[] moveType = {
  "Food", "Noise", "Wander", "Seek", "Steer"
};

void setup() {
  size(1024, 768, P2D); 
  //fullScreen();
  rock = loadImage("rock.png");
  noStroke();

  // Initialize Box2D
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, 0);

  box2d.listenForCollisions();

  fh = new Fish();
  fd = new Food();
  rk = new Rock();
  db = new Debug();
  utl = new Utilities();

  fh.spawnFish();
}

void draw() {
  background(#282927);

  // Step forward in time
  box2d.step();

  fd.run();
  fh.run();
  rk.run();
  
  if (mousePressed) {
    fd.spawnFood(); 
  }

  fill(255);
  text(moveType[currentMode], 10, 20);
  text("FPS: " + frameRate, 10, 40);
  text("Objects: " + (fh.fishes.size() + fd.foods.size()), 10, 60);
}

void keyPressed ()
{
  if (key == ' ') {
    // Advance forward in modes and reset
    currentMode++;
    if (currentMode > moveType.length - 1) currentMode = 1;
  }
  if (key == 'd') {
    debug = !debug;
  }
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

  if (o1.getClass() == FishKoi.class && o2.getClass() == FoodSmall.class) {
    Fish p1 = (FishKoi) o1;
    Food p2 = (FoodSmall) o2;
    p1.grow();
    p2.eaten();
  }

  if (o1.getClass() == FishGoldKoi.class && o2.getClass() == FoodSmall.class) {
    Fish p1 = (FishGoldKoi) o1;
    Food p2 = (FoodSmall) o2;
    p1.grow();
    p2.eaten();
  }

  if (o1.getClass() == FishKoi.class && o2.getClass() == FishGoldKoi.class) {
    Fish p1 = (FishKoi) o1;
    Fish p2 = (FishGoldKoi) o2;
    if (p2.fishSize > p1.fishSize) {
      //p1.setDead();
    }
  }
}

void endContact(Contact cp) {
}