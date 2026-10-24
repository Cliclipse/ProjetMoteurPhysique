class World{
  Particule[] WorldParticule;
  Vecteur3D groundDimensions = new Vecteur3D(200,10,400);
  Blob bob;
  Particule camParticule;
  particuleForceRegistry registry;
  
  void Setup(){
    bob = new Blob(15,0.5,5,color(255,60,60));
    camParticule = new Particule(999999, new Vecteur3D(width/2,height/2,650), new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
    camera(camParticule.Position.x,camParticule.Position.y,camParticule.Position.z,width/2,height/2,0,0,1,0);
    registry = new particuleForceRegistry();
    registry.Add(camParticule, new ParticuleRessort(1,20,bob.membre[0].Position,true));
    registry.Add(bob.membre[0], new ParticuleRessort(1,20,camParticule.Position,true));
  }
    
  
  void display(){
    pushMatrix();
    translate(width/2, height, -100);
    fill(color(60,255,60));
    box(width*5,10,1000);
    popMatrix();
    bob.DrawBlob();
  }
}
