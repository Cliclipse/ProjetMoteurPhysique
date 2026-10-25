class Blob{
  Particule[] membre;
  particuleForceRegistry forceRegistry;
  ParticuleRessort[][] ressorts;
  int nbMembre;
  int indexMasterParticule;
  float particulesSpeed = 5000000;
  float invMassPart;
  color colorBlob = color(255, 0, 0);
  float rayon = 0.5f;
  float kBlob = 5f; // arbitraire
  float l0 = 1f;
  ArrayList<Contact> liens = new ArrayList<Contact>();
  float lCable = 45;   // longueur max d'un lien (câble si superieur)
  float eCable = 0.2f;

    //Fonction qui apply la physique pour chaque particule du blob
  public void ApplyPhysic(){
    for(int i = 0 ; i <nbMembre ; i++); //membre[i].calculForce();
  }
  
  
  public void Move(char keyPressed, float dt)
  {
    print(keyPressed);
    Vecteur3D move = new Vecteur3D(0,0,0);
    print("test");
    
    if (key == 'q') move.x -= particulesSpeed * dt ;
    if (key == 'd') move.x += particulesSpeed * dt ;
    if (key == 's') move.z += particulesSpeed * dt ;
    if (key == 'z') move.z -= particulesSpeed * dt ;

    for (int i = 0; i<nbMembre ; i++){
        membre[i].AddForce(move);
    }
  }
   //Ajout à la particule maitre dans son accumulator de force une certaine force vers la droite.
  
  
  Blob(int nbMembre, float invMassPart, float rayonPart, color couleurPart){
    ressorts = new ParticuleRessort[nbMembre][nbMembre]; 
    this.forceRegistry = new particuleForceRegistry();
    this.membre = new Particule[nbMembre];
    rayon = rayonPart;
    this.nbMembre = nbMembre;
    colorBlob = couleurPart;
    float frequenceLien = 1; //arbitraire, 1 oscillation par seconde
    this.invMassPart = invMassPart;

    //f = (1/2pi)·√(k/m), k = m·(2pif)²
    kBlob = (1/invMassPart)* sq(TWO_PI * frequenceLien);
    
    for (int i = 0; i< nbMembre ; i++){
        this.AddParticuleToBlob(new Vecteur3D(640,700,0), i);
    }
  }
  
  
  public void AddParticuleToBlob(Vecteur3D positionBlob, int indexParticule ){
        print("test");
        Vecteur3D vecteurNul = new Vecteur3D(0,0,0);
        membre[indexParticule] = new Particule(invMassPart, positionBlob , vecteurNul , vecteurNul);
        membre[indexParticule].rayon = rayon;
        membre[indexParticule].couleur = colorBlob;
        membre[indexParticule].isInBlob = true;
        
        forceRegistry.Add(membre[indexParticule],new ParticuleGravity());
        
        for (int indexParticuleLiee = 0; indexParticuleLiee<indexParticule ; indexParticuleLiee++){         
          if (indexParticule != indexParticuleLiee){
            ressorts[indexParticule][indexParticuleLiee] = new ParticuleRessort(kBlob, l0, membre[indexParticule].Position, false);
            ressorts[indexParticuleLiee][indexParticule] = new ParticuleRessort(kBlob, l0, membre[indexParticuleLiee].Position, false);

            forceRegistry.Add(membre[indexParticule], ressorts[indexParticule][indexParticuleLiee]);
            forceRegistry.Add(membre[indexParticuleLiee], ressorts[indexParticuleLiee][indexParticule]);
            
            liens.add(new Contact(membre[indexParticule], membre[indexParticuleLiee], 1, lCable, eCable));
          }
        }
      }
 
  
     
    public void DrawBlob(){
    for (int i = 0; i<nbMembre ; i++){
       membre[i].display();
       
    }
  }
  
  
  void UpdateBlob(float dt){
      forceRegistry.UpdateForces(dt);
      //membre[0].Position = new Vecteur3D(550,550,0);
  }
  
  
  public void AddParticule(Particule p){
    if (p.isInBlob) {
      return;
    }
    p.isInBlob = true;
    p.couleur = colorBlob;
    
    this.AddParticuleToBlob(p.Position, nbMembre);

  

    
    membre = (Particule[]) append(membre, forceRegistry);
    nbMembre++;
  }
  
  
  
  public void Split(char keyPressed, float dt)
  {
    print("Split");
    // Remove des ressorts
    int mid = nbMembre/2;
    for (int i = 0; i < mid ; i++){
      for (int j = mid; j < nbMembre ; j++){
        //forceRegistry.Remove(membre[i], forceRegistry);
      }
    }
  }
  
  
  
}
