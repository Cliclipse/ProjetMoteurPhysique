class World{
  Particule[] WorldParticule;
  Vecteur3D groundDimensions = new Vecteur3D(width*5,10,1000);
  Blob bob;
  Particule camParticule;
  particuleForceRegistry registry;
  
  void Setup(){
    bob = new Blob(15,0.5,50,color(255,60,60));
    camParticule = new Particule(999999, new Vecteur3D(width/2,height/2,650), new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
    registry = new particuleForceRegistry();
    registry.Add(camParticule, new ParticuleRessort(1000,20,bob.membre[0].Position,true));
  }
    
  void Update(float dt){
    registry.UpdateForces(dt);
    //camera(camParticule.Position.x,camParticule.Position.y,camParticule.Position.z,bob.membre[0].Position.x,bob.membre[0].Position.y,bob.membre[0].Position.z,0,1,0);
    //camera(width/2,height/2,650,bob.membre[0].Position.x,bob.membre[0].Position.y,bob.membre[0].Position.z,0,1,0);
}
  
  void display(){
    pushMatrix();
    translate(width/2, height, -100);
    fill(color(60,255,60));
    box(groundDimensions.x,groundDimensions.y,groundDimensions.z);
    popMatrix();
  }
}
