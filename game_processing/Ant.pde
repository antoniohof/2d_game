class Ant extends Collidable {
  
  PImage img;
  Spring spring;
  
  boolean attached = false;
  
  // constructor
  Ant (PVector p) {
    super(BodyType.DYNAMIC, -2, -10, -10, 10, 10, 10, 2, -10);
    int spread = 30;
    // randomly around center of ants
    makeBody(new Vec2(p.x + random(-spread, spread), p.y + random(-spread,spread)));
    body.setUserData(this);

    spring = new Spring();
    
    img = loadImage("images/formiga.png");
    image(img, 0, 0);
  }
  
  
  void draw (Vec2 pos) {
    if (attached) {
      spring.update(pos.x, pos.y);
    }
    update();
    if (DEBUG_MODE) {
      super.debug(); 
    }
    pushMatrix();
      imageMode(CENTER);
      image(img, position.x, position.y, 50, 50);
    popMatrix();
  }
  
  void dettach () {
   if (attached && spring != null) {
     if (spring.destroy()) {
       attached = false;
       println("ANT DETTACHED!");
     }
   }
  }
  
  void attach (PVector p) {
    if (!attached) {
      attached = true;
       println("ANT ATTACHED!");

      spring.bind(p.x, p.y, body);
    }
  }
}
