// generic class for the any collidable. It is destroyed when y is bigger than screen height.

class Collidable {

  Body body;
  private Vec2 pos;
  public PVector position;
  float angle;

  BodyType bodyType;

  float x1;
  float y1;

  float x2;
  float y2;

  float x3;
  float y3;

  float x4;
  float y4;


  Collidable (BodyType b, float _x1, float _y1, float _x2, float _y2, float _x3, float _y3, float _x4, float _y4) {
    position = new PVector(0, 0);
    bodyType = b;
    x1 = _x1;
    y1 = _y1;

    x2 = _x2;
    y2 = _y2;

    x3 = _x3;
    y3 = _y3;

    x4 = _x4;
    y4 = _y4;
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Is it off the bottom of the screen?
    if (pos.y > height + 10) {
      killBody();
      return true;
    }
    return false;
  }


  void update () {
    pos = box2d.getBodyPixelCoord(body);
    angle = body.getAngle();
    position.x = pos.x;
    position.y = pos.y;
  }


  // Drawing the box
  void debug() {

    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();

    pushMatrix();
    rectMode(CENTER);

    translate(pos.x, pos.y);
    rotate(-angle);
    fill(255, 0, 0);
    stroke(0);
    beginShape();
    //println(vertices.length);
    // For every vertex, convert to pixel vector
    for (int i = 0; i < ps.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float density, float friction, float restitution, float yCenterAdd) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();

    Vec2[] vertices = new Vec2[4];

    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(x1, y1));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(x2, y2));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(x3, y3));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(x4, y4));

    sd.set(vertices, vertices.length);

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();

    bd.type = bodyType;
    bd.position.set(box2d.coordPixelsToWorld(new Vec2(center.x, center.y)));
    body = box2d.createBody(bd);
    pos = box2d.getBodyPixelCoord(body);
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = density;
    fd.friction = friction;
    fd.restitution = restitution;
    body.createFixture(fd);
  }

  // abstract?
  void draw () {
    // meant to be overriden
  }
}
