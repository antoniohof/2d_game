// game state machine
static enum State {
  BEGIN,
  PLAYING,
  END
}

State currentState;

// floating objects in the river
ArrayList<Collidable> floatingObjects;

// my ants
ArrayList<Ant> ants;

// overall speed of objects appearing;
float waterSpeed;

int riverWidth;

void changeState(State to) {
  switch (to) {
    case BEGIN:
      println("changed state to BEGIN");
      resetVariables();
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
  ants.add(new Ant()); 
  
  riverWidth = width/4;
}


void setup () {
  size (800, 800);
  ants = new ArrayList<Ant>();
  floatingObjects = new ArrayList<Collidable>();

  changeState(State.BEGIN);
}


void draw () {  
  background(0);
  
  drawBackground();
  drawRiver();

  
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
    // sky
    fill(0,128,255);
    rect(0, 0, width, height/3); 
    
    // grass
    fill(0,255,0);
    rect(0, height/3, width, height - height/3); 
  }
  
  void drawRiver () {
    // grass
    fill(0,0,255);
    // width/2 - (riverWidth/2), height/3, riverWidth, height - height/3
    quad(width/2 - (riverWidth/2), height/3, width/2 + riverWidth/2, height/3, width/2 + riverWidth, height, width/2 - (riverWidth), height); 
    
  }
