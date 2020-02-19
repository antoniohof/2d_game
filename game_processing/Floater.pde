

class Floater extends Collidable {
    
  // constructor
  Floater () {    
    super(BodyType.DYNAMIC, -12, -12, -12, 12, 12, 12, 12, -12);
        
    // randomize right / left where floaters are born
    int rand = (int)random(0, 100);
    
    if (rand % 2 == 0) {
      makeBody(new Vec2(random ((width/2) - 100, width/2), height/3 + 10), 200, 0.8);
      body.setLinearVelocity(new Vec2(random(-3.0, 0), random(-2, -15)));

    } else {
      makeBody(new Vec2(random (width/2, (width/2) + 100), height/3 + 10), 200, 0.8);
      body.setLinearVelocity(new Vec2(random(0, 3), random(-2, -15)));
    }
    body.setUserData(this);

    body.setAngularVelocity(random(-3, 3));
  }
  
  PImage thumbnail;
  
  void draw () {
    update();
      if (DEBUG_MODE) {
        super.debug();
      }
      
    pushMatrix();
    
      float scaleY = pow((position.y/height) + 0.15 , 1.5); 
      translate(position.x, position.y);
      scale(scaleY);
      rotate(-angle);
      fill(0, 255, 0);
      quad(-12, -12, -12, 12, 12, 12, 12, -12);
    popMatrix();
  }
}
