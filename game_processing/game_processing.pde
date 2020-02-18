// game state machine
static enum State {
  MENU,
  PLAYING,
  END
}

State currentState;

void changeState(State to) {
  switch (to) {
    case MENU:
      println("changed state to MENU");
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
}

void setup () {
  size (500, 500);
  background(0);
  
  currentState = State.MENU;
}


void draw () {
  
}
