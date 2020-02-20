// class to manage the how ants behave together around the queen //<>//
class AntBlob {

  // ants attached to the queen
  public ArrayList<Ant> ants;
  // position of the queen
  PVector antMassCenter;
  private PImage queenImg;
  // size of queen collider
  private int colliderSize = 10;

  public Body body;

  AntBlob () {
    ants = new ArrayList<Ant>();
    antMassCenter = new PVector(width/2, height -200);

    CircleShape circle;
    circle = new CircleShape();
    circle.m_radius = box2d.scalarPixelsToWorld(colliderSize/2);
    ;

    FixtureDef fd = new FixtureDef();
    fd.shape = circle;
    fd.isSensor = true; // no need to really collide with stuff

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC;
    bd.position.set(box2d.coordPixelsToWorld(antMassCenter));
    bd.angle = random(TWO_PI);

    body = box2d.createBody(bd);
    body.createFixture(fd);
    body.setUserData(this);

    queenImg = loadImage("images/queen.png");
  }



  void draw () {
    antMassCenter.x = mouseX;
    if (DEBUG_MODE) {
      debug();
    }
    for (int i = 0; i < ants.size(); i++) {
      ants.get(i).draw();
    } 
    Vec2 pos = box2d.getBodyPixelCoord(body);

    body.setTransform(box2d.coordPixelsToWorld(antMassCenter.x, antMassCenter.y), body.getAngle());

    pushMatrix();
    imageMode(CENTER);

    translate(pos.x, pos.y);
    rotate(-2.1);
    translate(-pos.x, -pos.y);
    image(queenImg, pos.x, pos.y, 70, 70);
    popMatrix();
  }

  void debug () {

    Vec2 pos = box2d.getBodyPixelCoord(body);
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    fill(255, 0, 0);
    stroke(0);
    circle(0, 0, colliderSize);
    popMatrix();
  }

  void addToBlob (Ant ant) {
    ant.attach();
    ants.add(ant);
  }

  boolean removeFromBlob(Ant ant) {
    if (ant.dettach()) {
      ants.remove(ant);
      return true;
    } else {
      return false;
    }
  }

  void reset () {
    for (int i = 0; i < ants.size(); i++) {
      ants.get(i).rope.destroy();
      ants.get(i).killBody();
      ants.remove(ants.get(i));
    }
    ants = new ArrayList<Ant>();
  }
}
