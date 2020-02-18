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

  River(float _x1,float _y1, float _x2,float _y2, float _x3,float _y3, float _x4,float _y4) {
    x1 = _x1;
    y1 = _y1;

    x2 = _x2;
    y2 = _y2;
    
    x3 = _x3;
    y3 = _y3;
    
    x4 = _x4;
    y4 = _y4;
        
    createMargins();
  }

  
  void createMargins () {
   // left
    PolygonShape sdLeft = new PolygonShape();

    Vec2[] verticesLeft = new Vec2[4];
    verticesLeft[0] = new Vec2(x1, y1);
    verticesLeft[1] = new Vec2(x1 + 4, y1);
    verticesLeft[2] = new Vec2(x4 + 4, y4);
    verticesLeft[3] = new Vec2(x4, y4);
    

    sdLeft.set(verticesLeft, verticesLeft.length);

    // Define the body and make it from the shape
    BodyDef bdLeft = new BodyDef();
    bdLeft.type = BodyType.STATIC;
    bdLeft.position.set(0,0);
    leftMargin = box2d.createBody(bdLeft);

    leftMargin.createFixture(sdLeft, 1.0); 
    
    //right
    PolygonShape sdRight = new PolygonShape();

    Vec2[] verticesRight = new Vec2[4];
    verticesRight[0] = new Vec2(x2, y2);
    verticesRight[1] = new Vec2(x2 + 4, y2);
    verticesRight[2] = new Vec2(x3 + 4, y3);
    verticesRight[3] = new Vec2(x3, y3);
    

    sdRight.set(verticesRight, verticesRight.length);

    // Define the body and make it from the shape
    BodyDef bdRight = new BodyDef();
    bdRight.type = BodyType.STATIC;
    bdRight.position.set(0,0);
    rightMargin = box2d.createBody(bdRight);

    rightMargin.createFixture(sdRight, 1.0); 
    
  }

  // Drawing the boundaries for debug
  void debug() {
    
    Fixture fL = leftMargin.getFixtureList();
    PolygonShape psL = (PolygonShape) fL.getShape();
    fill(255,0, 0);

    beginShape();
    //println(vertices.length);
    // For every vertex, convert to pixel vector
    for (int i = 0; i < psL.getVertexCount(); i++) {
      Vec2 v = psL.getVertex(i);
      vertex(v.x, v.y);
    }
    endShape(CLOSE);


    Fixture fR = rightMargin.getFixtureList();
    PolygonShape psR = (PolygonShape) fR.getShape();
    fill(255,0,0);

    beginShape();
    //println(vertices.length);
    // For every vertex, convert to pixel vector
    for (int i = 0; i < psR.getVertexCount(); i++) {
      Vec2 v = psR.getVertex(i);
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }
  
  //draw river
  void draw() {
   fill(0, 0, 255);
   quad(x1, y1, x2, y2, x3, y3, x4, y4);
  }
 

}
