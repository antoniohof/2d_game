import javafx.util.Pair; 

// game state machine
static enum State {
    BEGIN, 
    PLAYING, 
    END
}

// game current state
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

// configuration of difficulty
float intervalFloaters = 500.0;
float minIntervalFloaters = 200.0f;
float riverSpeed = 2;
float riverMaxSpeed = 10;
// change of an ant to appear in the river
float chanceAntBorn = 0.3;

// playing round time variables
long lastFloaterBorn = 0;
long roundStartTime = 0;
long roundTotalDuration = 100000;
long roundElapsedTime = 0;

// start playing button vars
int startButtonX;
int startButtonY; 
int startButtonWidth = 200;
int startButtonHeight = 70;

// end round time variables
long endStateStartTime = 0;
long endStateDuration = 5000;
long endStateElapsedTime = 0;

River river;
AntBlob antBlob;

// array to store floating objects in the river
ArrayList<Collidable> floatingObjects;
// array with images and its dimensions for spawning floating objects
ArrayList<Pair> floaterTypesArray;

// activate/deactivate debug mode
boolean DEBUG_MODE = false;

PImage antImage;

void setup () {
  size (800, 800);
  frameRate(60);

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();

  // load global cached ant image
  antImage = loadImage("images/formiga.png");

  // initialize vars
  river = new River();
  floatingObjects = new ArrayList<Collidable>();
  antBlob = new AntBlob();
  floaterTypesArray = new ArrayList<Pair>();

  // populate types of floating  debris objects
  floaterTypesArray.add(new Pair<PImage, PVector>(loadImage("images/lixo.png"), new PVector(20, 20)));
  floaterTypesArray.add(new Pair<PImage, PVector>(loadImage("images/boia.png"), new PVector(20, 20)));
  floaterTypesArray.add(new Pair<PImage, PVector>(loadImage("images/wood.png"), new PVector(35, 10)));
  floaterTypesArray.add(new Pair<PImage, PVector>(loadImage("images/plasticbag.png"), new PVector(30, 30)));
  floaterTypesArray.add(new Pair<PImage, PVector>(loadImage("images/menina.png"), new PVector(20, 20)));

  // set start button position
  startButtonX = width/2 - startButtonWidth/2;
  startButtonY = height/2- startButtonHeight/2;

  changeState(State.BEGIN);
}


void draw () {  
  background(0);

  drawBackground();
  river.draw();

  switch (currentState) {
  case BEGIN:
    // println("BEGIN");
    textSize(32);
    textAlign(CENTER);
    fill(255, 255, 0);
    text("ANT APOCALIPSE", width/2, 100); 
    fill(50, 255, 0);
    text("SAVE AS MANY ANTS AS YOU CAN", width/2, 140); 

    textSize(18);
    fill(0, 0, 0);
    text("MOVE YOUR MOUSE TO GUIDE THE QUEEN-ANT", width/2, 220); 
    text("TO OTHER ANTS AND AVOID DEBRIS", width/2, 240); 
    fill(0, 255, 0);
    rect(startButtonX, startButtonY, startButtonWidth, startButtonHeight);
    fill(0, 0, 0);
    textSize(32);
    text("START", startButtonX + startButtonWidth/2, startButtonY + startButtonHeight/1.5); 

    break;
  case PLAYING:
    box2d.step();
    // println("PLAYING");
    roundElapsedTime = millis() - roundStartTime;
    // score
    textSize(32);
    fill(0, 255, 0);
    textAlign(LEFT);
    text("ants saved: ", 10, 30); 
    text(antBlob.ants.size(), 185, 30); 
    text("time left: ", 250, 30); 
    float remainingTime = floor((roundTotalDuration/10 - roundElapsedTime/10.0)/100.0);
    text((int)remainingTime, 400, 30); 
    text(" seconds", 438, 30); 

    if (remainingTime < 0) {
      changeState(State.END);
    }

    fill(0, 102, 153);

    // difficulty over time adjust
    if (riverSpeed < riverMaxSpeed) {
      riverSpeed+=0.002;
      box2d.setGravity(0, -riverSpeed);
    }

    if (intervalFloaters > minIntervalFloaters) {
      intervalFloaters-=0.07;
    }

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
    textSize(38);
    fill(0, 255, 0);
    textAlign(CENTER);
    text("YOU SAVED " + antBlob.ants.size() + " ANTS FROM APOCALIPSE", width/2, 120); 

    endStateElapsedTime = millis() - endStateStartTime;
    if (endStateElapsedTime > endStateDuration) {
      changeState(State.BEGIN);
    }
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
    break;
  case PLAYING:
    resetVariables();
    roundStartTime = millis();
    println("changed state to PLAYING");
    break;
  case END:
    endStateStartTime = millis();
    println("changed state to END"); 
    break;
  default:
    break;
  }
  currentState = to;
}

void resetVariables () {
  antBlob.reset();
  for (int i = 0; i < floatingObjects.size(); i++) {
    floatingObjects.get(i).killBody();
    floatingObjects.remove(floatingObjects.get(i));
  }
  floatingObjects = new ArrayList<Collidable>();
  riverSpeed = 2;
  intervalFloaters = 500.0;
  endStateElapsedTime = 0;
  lastFloaterBorn = 0;
  roundElapsedTime = 0;
}

void addRandomNewObject () {
  float rand = (float)random(0, 1);
  if (rand < chanceAntBorn) {
    Ant n = new Ant();
    n.attached = false;
    floatingObjects.add(n);
  } else {
    // get random from array of floater types
    int randFloaterIndex = (int)random(0, floaterTypesArray.size());
    PImage image = (PImage)floaterTypesArray.get(randFloaterIndex).getKey();
    PVector dimension = (PVector)floaterTypesArray.get(randFloaterIndex).getValue();
    floatingObjects.add(new Floater(image, (int)dimension.x, (int)dimension.y));
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

  // attach or dettach ant based on its state
  if (o1.getClass() == AntBlob.class && o2.getClass() == Ant.class) {
    Ant ant = (Ant) o2;
    if (!ant.attached) {
      println("add to blob 1");
      antBlob.addToBlob(ant);
      floatingObjects.remove(ant);
    }
  }

  if (o1.getClass() == Ant.class && o2.getClass() == AntBlob.class) {
    Ant ant = (Ant) o1;
    if (!ant.attached) {
      println("add to blob 2");
      antBlob.addToBlob(ant);
      floatingObjects.remove(ant);
    }
  }

  if (o1.getClass() == Floater.class && o2.getClass() == Ant.class) {
    Ant ant = (Ant) o2;
    if (ant.attached) {
      if (antBlob.removeFromBlob(ant)) {
        floatingObjects.add(ant);
      }
    }
  }
  if (o1.getClass() == Ant.class && o2.getClass() == Floater.class) {
    Ant ant = (Ant) o1;
    if (ant.attached) {
      if (antBlob.removeFromBlob(ant)) {
        floatingObjects.add(ant);
      }
    }
  }

  if (o1.getClass() == Ant.class && o2.getClass() == Ant.class) {
    Ant ant1 = (Ant) o1;
    Ant ant2 = (Ant) o2;

    if (!ant2.attached && ant1.attached) {
      antBlob.addToBlob(ant2);
      println("add to blob 3");
      floatingObjects.remove(ant2);
    }

    if (!ant1.attached && ant2.attached) {
      println("add to blob 4");
      antBlob.addToBlob(ant1);
      floatingObjects.remove(ant1);
    }
  }
}

// not used
void endContact(Contact cp) {
}

void mousePressed () {
  if (currentState == State.BEGIN &&
    mouseX >= startButtonX && mouseX <= startButtonX+startButtonWidth && 
    mouseY >= startButtonY && mouseY <= startButtonY+startButtonHeight) {
    changeState(State.PLAYING);
  }
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
