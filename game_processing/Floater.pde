

class Floater extends Collidable {
  PImage image;
  int fWidth;
  int fHeight;
  // constructor
  Floater (PImage _image, int w, int h) {
    super(BodyType.DYNAMIC, -w, -h, -w, h, w, h, w, -h);

    fWidth = w;
    fHeight = h;

    image = _image;

    // randomize right / left where floaters are born
    int rand = (int)random(0, 100);

    float sideForce = 5;

    if (rand % 2 == 0) {
      makeBody(new Vec2(random ((width/2) - 100, width/2), height/3 + 10), 400, 0.1);
      body.setLinearVelocity(new Vec2(random(-sideForce, 0), random(-2, -15)));
    } else {
      makeBody(new Vec2(random (width/2, (width/2) + 100), height/3 + 10), 400, 0.1);
      body.setLinearVelocity(new Vec2(random(0, sideForce), random(-2, -15)));
    }
    body.setUserData(this);

    body.setAngularVelocity(random(-3, 3));
  }

  void draw () {
    update();
    if (DEBUG_MODE) {
      super.debug();
    }

    pushMatrix();
    float scaleY = pow((position.y/height) + 0.15, 1.5); 
    imageMode(CENTER);
    translate(position.x, position.y);
    rotate(-angle);
    translate(-position.x, -position.y);
    image(image, position.x, position.y, 70 * scaleY, 70 * scaleY);
    popMatrix();
  }
}
