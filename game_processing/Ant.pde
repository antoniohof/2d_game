class Ant extends Collidable {

  PImage img;
  Rope rope;

  // if is attached to ant blob
  boolean attached = false;

  // overloaded constructor for ant as a floater
  Ant () {
    super(BodyType.DYNAMIC, -2, -10, -10, 10, 10, 10, 2, -10);
    println("NEW FLOTER ANT");
    attached = false;

    // randomize right / left where floaters are born
    int rand = (int)random(0, 100);
    if (rand % 2 == 0) {
      //(Vec2 center, float density, float friction, float restitution, float yCenterAdd)
      makeBody(new Vec2(random ((width/2) - 100, width/2), height/3 + 10), 0.5, 0.6, 0.3, 0);
      body.setLinearVelocity(new Vec2(random(-3.0, 0), random(-2, -15)));
    } else {
      makeBody(new Vec2(random (width/2, (width/2) + 100), height/3 + 10), 0.5, 0.6, 0.3, 0);
      body.setLinearVelocity(new Vec2(random(0, 3), random(-2, -15)));
    }

    body.setUserData(this);

    rope = new Rope();

    img = antImage;
  }


  void draw () {
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

  boolean dettach () {
    if (rope.destroy()) {
      attached = false;
      return true;
    }
    return false;
  }

  void attach () {
    if (!attached) {
      attached = true;
      println("ANT ATTACHED!");
      rope.bind(body, antBlob.body);
    }
  }
}
