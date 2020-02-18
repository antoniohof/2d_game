class AntBlob {
    // my ants
  ArrayList<Ant> ants;
  PVector antMassCenter;

  
  AntBlob () {
   ants = new ArrayList<Ant>();
   antMassCenter = new PVector(width/2, height -100);


   for (int i = 0; i < 20; i++) {
     ants.add(new Ant(antMassCenter)); 
   }
  }
  
  
  void draw () {
    
   for (int i = 0; i < ants.size(); i++) {
     ants.get(i).draw(new Vec2(mouseX, height -100)); 
    } 
  }
  
  void reset () {
    ants.clear(); 
  }

  
  
  
}
