// game state machine
static enum State {
    BEGIN, 
    PLAYING, 
    END
}

State currentState;

//box2d
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;


// TODO
// create different kinds of floaters (sofas, fish, wood, trash, etc)
// create ant floater
// listen for collisiion and grow blob when touch ants or remove ants when touch trash
// count number of ants and when its 100 declare win and show the time.

// floating objects in the river
ArrayList<Collidable> floatingObjects;


// configuration of difficulty and timers
float intervalFloaters = 500.0;
long lastFloaterBorn = 0;

River river;

AntBlob antBlob;

boolean DEBUG_MODE = false;

void setup () {
  size (800, 800);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();

  // We are setting a custom gravity
  box2d.setGravity(0, -2);

  river = new River();

  floatingObjects = new ArrayList<Collidable>();
  antBlob = new AntBlob();
  changeState(State.PLAYING);
}


void draw () {  
  background(0);
  // We must always step through time!
  box2d.step();

  drawBackground();
  river.draw();


  switch (currentState) {
  case BEGIN:
    // println("BEGIN");
    break;
  case PLAYING:
    // println("PLAYING");

    for (int i = 0; i < floatingObjects.size(); i ++) {
      floatingObjects.get(i).draw();
      if (floatingObjects.get(i).done()) {
        floatingObjects.remove(i);
      }
    }
    antBlob.draw();


    if (millis() > lastFloaterBorn + intervalFloaters) {
      lastFloaterBorn = millis();
      addRandomNewObject();
    }

    break;
  case END:
    // println("END"); 
    break;
  default:
    break;
  }  



  if (DEBUG_MODE) {
    river.debug();
  }
}

void changeState(State to) {
  switch (to) {
  case BEGIN:
    println("changed state to BEGIN");
    resetVariables();
    break;
  case PLAYING:
    println("changed state to PLAYING");
    break;
  case END:
    println("changed state to END"); 
    break;
  default:
    break;
  }
  currentState = to;
}

void resetVariables () {
  antBlob.reset();
  floatingObjects.clear();
}

void addRandomNewObject () {
  int rand = (int)random(0, 100);
  if (rand > 30) {
    floatingObjects.add(new Floater());
  } else {
    floatingObjects.add(new Ant());
  }
}

// Collision event functions!
void beginContact(Contact cp) {

  // Get both shapes
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if (o1 == null || o2 == null) return;
  
   if (o1.getClass() == AntBlob.class && o2.getClass() == Ant.class) {
     Ant ant = (Ant) o2;
     if (!ant.attached) {
        ant.attach(); 
     }
   }
   
  if (o1.getClass() == Ant.class && o2.getClass() == AntBlob.class) {
     Ant ant = (Ant) o1;
     if (!ant.attached) {
        ant.attach(); 
     }
   }
  
   if (o1.getClass() == Floater.class && o2.getClass() == Ant.class) {
     Ant ant = (Ant) o2;
     if (ant.attached) {
        ant.dettach(); 
     }
   }
    if (o1.getClass() == Ant.class && o2.getClass() == Floater.class) {
     Ant ant = (Ant) o1;
     if (ant.attached) {
        ant.dettach(); 
     }
   }
   
    if (o1.getClass() == Ant.class && o2.getClass() == Ant.class) {
     Ant ant1 = (Ant) o1;
     Ant ant2 = (Ant) o2;

     if (!ant2.attached && ant1.attached) {
       ant2.attach(); 
     }
     
    if (!ant1.attached && ant2.attached) {
       ant1.attach(); 
     }

   }
  
}

// Objects stop touching each other
void endContact(Contact cp) {
}


void drawBackground () {
  rectMode(0);

  // sky
  fill(0, 128, 255);
  rect(0, 0, width, height/3); 

  // grass
  fill(0, 255, 0);
  rect(0, height/3, width, height - height/3);
}
