class Blob{
  Particule[] membre;
  particuleForceRegistry ressorts;
  //ParticuleRessort[][] ressorts;
  int nbMembre;
  int indexMasterParticule;
  float particulesSpeed;
  float invMassPart;
  color colorBlob = color(255, 0, 0);
  float rayon = 0.5f;
  float kBlob = 10f; // arbitraire
  float l0 = 5f;

    //Fonction qui apply la physique pour chaque particule du blob
  public void ApplyPhysic(){
    for(int i = 0 ; i <nbMembre ; i++); //membre[i].calculForce();
  }
  
  
  public void Move(char keyPressed, float dt)
  {
    print(keyPressed);
    Vecteur3D move = new Vecteur3D(0,0,0);
    
    
    if (key == 'q') move.x -= particulesSpeed * dt ;
    if (key == 'd') move.x += particulesSpeed * dt ;
    if (key == 's') move.z -= particulesSpeed * dt ;
    if (key == 'z') move.z += particulesSpeed * dt ;

    for (int i = 0; i<nbMembre ; i++){
        membre[i].AddForce(move);
    }
  }
   //Ajout à la particule maitre dans son accumulator de force une certaine force vers la droite.
  
  
  Blob(int nbMembre, float invMassPart, float rayonPart, color couleurPart){
    this.ressorts = new particuleForceRegistry();
    this.membre = new Particule[nbMembre];
    rayon = rayonPart;
    this.nbMembre = nbMembre;
    colorBlob = couleurPart;
    for (int i = 0; i<nbMembre ; i++){
        Vecteur3D vecteurNul = new Vecteur3D(0,0,0);
        membre[i] = new Particule(invMassPart, new Vecteur3D(640,700,0) , vecteurNul , vecteurNul);
        membre[i].rayon = rayon;
        membre[i].couleur = colorBlob;
        membre[i].isInBlob = true;
        
        ressorts.Add(membre[i],new ParticuleGravity());
        
        for (int j = 0; j<i ; j++){
          if (i != j){
            ressorts.Add(membre[i],new ParticuleRessort(kBlob,l0,membre[j].Position,true));
            ressorts.Add(membre[j],new ParticuleRessort(kBlob,l0,membre[i].Position,true));
          }
        }
    }
  }
     
    public void DrawBlob(){
    for (int i = 0; i<nbMembre ; i++){
       membre[i].display();
       
    }
  }
  
  
  void UpdateBlob(float dt){
      ressorts.UpdateForces(dt);
      //membre[0].Position = new Vecteur3D(550,550,0);
  }
}
