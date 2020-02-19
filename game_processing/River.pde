class River {

  float x1;
  float y1;

  float x2;
  float y2;

  float x3;
  float y3;

  float x4;
  float y4;

  private Body leftMargin;
  private Body rightMargin;
  float riverWidth;

  River() {
    riverWidth = width/2;

    x1 = width/2 - (riverWidth/3);
    y1 = height/3;

    x2 = width/2 + riverWidth/3;
    y2 = height/3;

    x3 = width/2 + riverWidth;
    y3 = height;

    x4 = width/2 - (riverWidth);
    y4 = height;

    createLeftMargin();
    createRightMargin();
  }


  void createLeftMargin () {

    // left margin
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(5);
    float box2dH = box2d.scalarPixelsToWorld(590);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = 2.679; 
    bd.position.set(box2d.coordPixelsToWorld(0, y2 + (height - y2)));
    leftMargin = box2d.createBody(bd);

    // Attached the shape to the body using a Fixture
    leftMargin.createFixture(sd, 1);
  }

  void createRightMargin () {


    // rigjt margin
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(5);
    float box2dH = box2d.scalarPixelsToWorld(590);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = -2.679; 
    bd.position.set(box2d.coordPixelsToWorld(width, y2 + (height - y2)));
    rightMargin = box2d.createBody(bd);

    // Attached the shape to the body using a Fixture
    rightMargin.createFixture(sd, 1);
  }

  // Drawing the boundaries for debug
  void debug() {

    // We look at each body and get its screen position
    Vec2 posL = box2d.getBodyPixelCoord(leftMargin);
    // Get its angle of rotation
    float aL = leftMargin.getAngle();

    Fixture fL = leftMargin.getFixtureList();
    PolygonShape psL = (PolygonShape) fL.getShape();

    pushMatrix();

    rectMode(CENTER);
    translate(posL.x, posL.y);
    rotate(-aL);
    fill(255, 0, 0);
    stroke(0);
    beginShape();
    //println(vertices.length);
    // For every vertex, convert to pixel vector
    for (int i = 0; i < psL.getVertexCount(); i++) {
      Vec2 vL = box2d.vectorWorldToPixels(psL.getVertex(i));
      vertex(vL.x, vL.y);
    }
    endShape(CLOSE);
    popMatrix();


    // We look at each body and get its screen position
    Vec2 posR = box2d.getBodyPixelCoord(rightMargin);
    // Get its angle of rotation
    float aR = rightMargin.getAngle();

    Fixture fR = rightMargin.getFixtureList();
    PolygonShape psR = (PolygonShape) fR.getShape();

    pushMatrix();

    rectMode(CENTER);
    translate(posR.x, posR.y);
    rotate(-aR);
    fill(255, 0, 0);
    stroke(0);
    beginShape();
    //println(vertices.length);
    // For every vertex, convert to pixel vector
    for (int i = 0; i < psR.getVertexCount(); i++) {
      Vec2 vR = box2d.vectorWorldToPixels(psR.getVertex(i));
      vertex(vR.x, vR.y);
    }
    endShape(CLOSE);
    popMatrix();
  }

  //draw river
  void draw() {
    fill(0, 0, 255);
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
  }
}
