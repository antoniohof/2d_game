// game state machine
static enum State {
  BEGIN,
  PLAYING,
  END
}

State currentState;

ArrayList<Collidable> floatingObjects;

void changeState(State to) {
  switch (to) {
    case BEGIN:
      println("changed state to BEGIN");
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
}

void setup () {
  size (500, 500);
  currentState = State.BEGIN;
}


void draw () {  
  background(0);

  
  switch (currentState) {
    case BEGIN:
      println("BEGIN");
      break;
    case PLAYING:
      println("PLAYING");
      break;
    case END:
      println("END"); 
      break;
    default:
      break;
  }  
}
