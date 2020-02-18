static enum FloaterType {
  NEUTRAL,
  BAD,
  ANT
}


class Floater extends Collidable {
  
  FloaterType fType;
  
  // constructor
  Floater (FloaterType t) {    
    super(BodyType.DYNAMIC, -10, -10, -10, 10, 10, 10, 10, -10);
    
    fType = t;
    
    int rand = (int)random(0, 100);
    
    if (rand % 2 == 0) {
      makeBody(new Vec2(random ((width/2) - 100, width/2), height/3));
      body.setLinearVelocity(new Vec2(random(-5, -1), random(-2, -5)));

    } else {
      makeBody(new Vec2(random (width/2, (width/2) + 100), height/3));
      body.setLinearVelocity(new Vec2(random(1, 5), random(-2, -5)));
    }
    
    // body.setAngularVelocity(random(-5, 5));
  }
  
  PImage thumbnail;
  
  void draw () {
    if (DEBUG_MODE) {
      super.debug();
    }  
  }
}
