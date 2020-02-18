class Ant extends Collidable {
  
  PImage img;
  Spring spring;
  
  // constructor
  Ant (PVector p) {
    super(BodyType.DYNAMIC, -2, -10, -10, 10, 10, 10, 2, -10);
    int spread = 50;
    // randomly around center of ants
    makeBody(new Vec2(p.x + random(-spread, spread), p.y + random(-spread,spread)));
    
        
      // Make the spring (it doesn't really get initialized until the mouse is clicked)
    spring = new Spring();
    spring.bind(p.x, p.y, body);
    
    img = loadImage("images/formiga.png");
    image(img, 0, 0);
  }
  
  
  void draw (Vec2 pos) {
    spring.update(pos.x, pos.y);

    update();
    if (DEBUG_MODE) {
      super.debug(); 
    }
    imageMode(CENTER);
    image(img, position.x, position.y, 50, 50);
  }
  
}
