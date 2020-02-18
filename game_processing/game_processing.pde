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

// floating objects in the river
ArrayList<Floater> floatingObjects;

// my ants
ArrayList<Ant> ants;
PVector antMassCenter;

// overall speed of objects appearing;
float waterSpeed;

River river;
float riverWidth;;

boolean DEBUG_MODE = true;

void changeState(State to) {
  switch (to) {
    case BEGIN:
      println("changed state to BEGIN");
      resetVariables();
      addFirstObjects();
      break;
    case PLAYING:
      // to do reset all variables
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
  // start with just one ant
  ants.clear();
  floatingObjects.clear();  
  antMassCenter = new PVector(width/2, height -100);
}

void addFirstObjects () {
 floatingObjects.add(new Floater(FloaterType.NEUTRAL)); 
 floatingObjects.add(new Floater(FloaterType.NEUTRAL)); 
 floatingObjects.add(new Floater(FloaterType.NEUTRAL)); 

 for (int i = 0; i < 20; i++) {
   ants.add(new Ant(antMassCenter)); 
 }
}

void setup () {
  size (800, 800);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, 0);
  
  riverWidth = width/2;

  river = new River(width/2 - (riverWidth/3), height/3, width/2 + riverWidth/3, height/3, width/2 + riverWidth, height, width/2 - (riverWidth), height);

  ants = new ArrayList<Ant>();
  floatingObjects = new ArrayList<Floater>();
    
  changeState(State.BEGIN);
}


void draw () {  
  background(0);
  
  // We must always step through time!
  box2d.step();
  
  drawBackground();
  // river.draw();
  
  for (int i = 0; i < floatingObjects.size(); i ++) {
    floatingObjects.get(i).draw();
    if (floatingObjects.get(i).done()) {
      floatingObjects.remove(i);
    }
  }
  
  for (int i = 0; i < ants.size(); i++) {
     ants.get(i).draw(); 
  }
  
  if (DEBUG_MODE) {
    river.debug();
  }
  
  
  switch (currentState) {
    case BEGIN:
      // println("BEGIN");
      break;
    case PLAYING:
      // println("PLAYING");
      break;
    case END:
      // println("END"); 
      break;
    default:
      break;
  }  
}


 void drawBackground () {
    rectMode(0);

    // sky
    fill(0,128,255);
    rect(0, 0, width, height/3); 
    
    // grass
    fill(0,255,0);
    rect(0, height/3, width, height - height/3); 
  }
  
