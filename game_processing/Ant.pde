class Ant extends Collidable {

  PImage img;
  Spring spring;

  // if is attached to ant blob
  boolean attached = false;
  
  // spring distance when attaching ant
  int spread = 30;


  // overloaded constructor for ant as a floater
  Ant () {
    super(BodyType.DYNAMIC, -2, -10, -10, 10, 10, 10, 2, -10);
    println("NEW FLOTER ANT");
    attached = false;

    // randomize right / left where floaters are born
    int rand = (int)random(0, 100);
    if (rand % 2 == 0) {
      makeBody(new Vec2(random ((width/2) - 100, width/2), height/3 + 10), 1, 0);
      body.setLinearVelocity(new Vec2(random(-3.0, 0), random(-2, -15)));
    } else {
      makeBody(new Vec2(random (width/2, (width/2) + 100), height/3 + 10), 1, 0);
      body.setLinearVelocity(new Vec2(random(0, 3), random(-2, -15)));
    }

    body.setUserData(this);

    spring = new Spring();

    img = antImage;
  }


  void draw () {
    if (attached) {
      spring.update(mouseX, height -100);
    }
    update();
    if (DEBUG_MODE) {
      super.debug();
    }

    float scaleY = pow((position.y/height) + 0.15, 1.5); 
    pushMatrix();

    imageMode(CENTER);
    translate(position.x, position.y);
    rotate(-angle);
    translate(-position.x, -position.y);
    image(img, position.x, position.y, 50 * scaleY, 50 * scaleY);

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

  void attach () {
    if (!attached) {
      attached = true;
      println("ANT ATTACHED!");
      spring.bind(position.x + random(-spread, spread), position.y + random(-spread, spread), body);
    }
  }
}
