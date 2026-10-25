class World{
  Particule[] WorldParticule;
  Vecteur3D groundDimensions = new Vecteur3D(1000000,10,1000000);
  Blob bob;
  Particule camParticule;
  particuleForceRegistry registry;
  Particule sol;
  
  //particules hors du blob au début
  float invMassParticule = 0.5;
  float rayonParticule = 10;
  float[][] spawn = {{150, 0}, {350, -200}, {900, -100}, {1100, 150}, {640, -350}, {250, 100}, {500, -300}, {800,  120}, {1000, -250}, {1200, -50}}; // positions fixes sur le sol
  
  void Setup(){
    bob = new Blob(15,0.5,10,color(255,60,60)); 
    camParticule = new Particule(0.5, new Vecteur3D(640,700,50), new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
    registry = new particuleForceRegistry();
    registry.Add(camParticule, new ParticuleRessort(10,50,bob.membre[0].Position,false));
    sol = new Particule(0, new Vecteur3D(0, height - groundDimensions.y/2, 0), new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
    //bob.UpdateBlob(dt);
    //camera(640,360,650,bob.membre[0].Position.x,bob.membre[0].Position.y,bob.membre[0].Position.z,0,1,0);
    
    Particule[] libres = new Particule[spawn.length];
    for (int i = 0; i < spawn.length; i++){
      float y = sol.Position.y - rayonParticule; // bas de la sphère au niveau du sol
      libres[i] = new Particule(invMassParticule, new Vecteur3D(spawn[i][0], y - 200, spawn[i][1]), new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
      libres[i].rayon = rayonParticule;
      libres[i].couleur = color(120);
      registry.Add(libres[i], new ParticuleGravity());
    }  
    
    WorldParticule = (Particule[]) concat(bob.membre, libres);
  }
    
  void Update(float dt){
    registry.UpdateForces(dt);
    //camera(camParticule.Position.x,camParticule.Position.y,camParticule.Position.z,bob.membre[0].Position.x,bob.membre[0].Position.y,bob.membre[0].Position.z,0,1,0);
}
  
  void display(){
    pushMatrix();
    translate(width/2, height, -100);
    fill(color(60,255,60));
    box(groundDimensions.x,groundDimensions.y,groundDimensions.z);
    popMatrix();
  }
}
