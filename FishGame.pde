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

PImage rock;
int currentMode = 1;
boolean debug = false;

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
  db = new Debug();
  utl = new Utilities();
  mp = new MoverPlayer();

  fh.spawnFishPlayer();
}

void draw() {
  background(#282927);

  // Step forward in time
  box2d.step();

  fd.run();
  fh.run();
  
  mp.run();
  
  if (debug) db.display();

  fill(255);
  text("FPS: " + frameRate, 10, 40);
  text("Objects: " + (fh.fishes.size() + fd.foods.size()), 10, 60);
}

void keyPressed ()
{
  mp.pressed();
  if (key == 'l') {
    debug = !debug;
  }
}

void keyReleased ()
{
  mp.released();
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
    p1.grow();
    p2.eaten();
  }

  if (o1.getClass() == FishEnemy.class && o2.getClass() == FoodSmall.class) {
    Fish p1 = (FishEnemy) o1;
    Food p2 = (FoodSmall) o2;
    p1.grow();
    p2.eaten();
  }

  if (o1.getClass() == FishPlayer.class && o2.getClass() == FishEnemy.class) {
    Fish p1 = (FishPlayer) o1;
    Fish p2 = (FishEnemy) o2;
    if (p2.fishSize > p1.fishSize) {
      //p1.setDead();
    }
  }
}

void endContact(Contact cp) {
}