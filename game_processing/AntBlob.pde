class AntBlob {
    // my ants
  ArrayList<Ant> ants;
  PVector antMassCenter;
  PImage queenImg;
  int colliderSize = 40;

  Body body;

  AntBlob () {
   ants = new ArrayList<Ant>();
   antMassCenter = new PVector(width/2, height -100);
   
   
   // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(colliderSize/2);
    float box2dH = box2d.scalarPixelsToWorld(colliderSize/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
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
   for (int i = 0; i < 1; i++) {
     Ant ant = new Ant(antMassCenter);
     ants.add(ant); 
     ant.attach(antMassCenter);
   }
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
  
  void reset () {
    ants.clear(); 
  }

  
  
}
