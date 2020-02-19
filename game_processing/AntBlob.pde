// class to manage the how ants behave together around the queen

class AntBlob {

  // my ants
  public ArrayList<Ant> ants;
  PVector antMassCenter;
  private PImage queenImg;
  private int colliderSize = 40;

  private Body body;

  AntBlob () {
    ants = new ArrayList<Ant>();
    antMassCenter = new PVector(width/2, height -100);


    // just the queen square collidable
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(colliderSize/2);
    float box2dH = box2d.scalarPixelsToWorld(colliderSize/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.2;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(antMassCenter));
    bd.angle = random(TWO_PI);

    body = box2d.createBody(bd);
    body.createFixture(fd);

    body.setUserData(this);


    queenImg = loadImage("images/queen.png");
  }



  void draw () {
    antMassCenter.x = mouseX;
    antMassCenter.y = height -100;
    if (DEBUG_MODE) {
      debug();
    }
    for (int i = 0; i < ants.size(); i++) {
      ants.get(i).draw();
    } 

    body.setTransform(box2d.coordPixelsToWorld(antMassCenter.x, antMassCenter.y), body.getAngle());

    pushMatrix();
    imageMode(CENTER);
    translate(antMassCenter.x, antMassCenter.y);
    rotate(-2.1);
    translate(-antMassCenter.x, -antMassCenter.y);
    image(queenImg, antMassCenter.x, antMassCenter.y, 70, 70);
    popMatrix();
  }

  void debug () {

    Vec2 pos = box2d.getBodyPixelCoord(body);

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255, 0, 0);
    stroke(0);
    rect(0, 0, colliderSize, colliderSize);
    popMatrix();
  }

  void addToBlob (Ant ant) {
    ant.attach();
    ants.add(ant);
  }

  void removeFromBlob(Ant ant) {
    ant.dettach();
    ants.remove(ant);
  }

  void reset () {
    antMassCenter = new PVector(width/2, height -100);
    for (int i = 0; i < ants.size(); i++) {
      ants.get(i).spring.destroy();
      ants.get(i).killBody();
      ants.remove(ants.get(i));
    }
    ants.clear();
  }
}
