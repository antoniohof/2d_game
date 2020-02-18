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


// configuration of difficulty and timers
float intervalFloaters = 500.0;
long lastFloaterBorn = 0;

River river;

AntBlob antBlob;

boolean DEBUG_MODE = true;

void setup () {
  size (800, 800);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, -2);
  box2d.listenForCollisions();
  
  river = new River();

  floatingObjects = new ArrayList<Floater>();
  antBlob = new AntBlob();
  changeState(State.PLAYING);
}


void draw () {  
  background(0);

  drawBackground();
  river.draw();

  
  switch (currentState) {
    case BEGIN:
      // println("BEGIN");
      break;
    case PLAYING:
      // println("PLAYING");
        
      // We must always step through time!
      box2d.step();
      
      
      for (int i = 0; i < floatingObjects.size(); i ++) {
        floatingObjects.get(i).draw();
        if (floatingObjects.get(i).done()) {
          floatingObjects.remove(i);
        }
      }
      antBlob.draw();
      
      
      if (millis() > lastFloaterBorn + intervalFloaters) {
        lastFloaterBorn = millis();
        floatingObjects.add(new Floater(FloaterType.NEUTRAL));
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
      addFirstObjects();
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

void addFirstObjects () {
 floatingObjects.add(new Floater(FloaterType.NEUTRAL)); 
 floatingObjects.add(new Floater(FloaterType.NEUTRAL)); 
 floatingObjects.add(new Floater(FloaterType.NEUTRAL)); 
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
  
