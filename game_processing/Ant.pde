class Ant extends Collidable {
  // constructor
  Ant (PVector p) {
    super(BodyType.STATIC, -2, -10, -10, 10, 10, 10, 2, -10);
    
    // randomly around center of ants
    makeBody(new Vec2(p.x + random(-10, 10), p.y + random(-10, 10)));
  }
  
  PVector position;
  PImage thumbnail;
  
  void draw () {
    if (DEBUG_MODE) {
      super.debug();
    }
  }
}
