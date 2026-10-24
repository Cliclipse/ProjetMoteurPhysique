class Blob{
  Particule[] membre;
  int nbMembre;
  int indexMasterParticule;
  float particulesSpeed;
  float invMassPart;
  color colorBlob = color(255, 220, 0);
  float rayon = 0.5f;
  
  
  
  //Ressort[] muscle;
  
  //Fonction qui apply la physique pour chaque particule du blob
  public void ApplyPhysic(){
    for(int i = 0 ; i <nbMembre ; i++); //membre[i].calculForce();
  }
  
  public void Move(char keyPressed)
  {
    print("test\n");
    print(keyPressed);
    
   //Ajout à la particule maitre dans son accumulator de force une certaine force vers la droite
  }
  
  

  
  Blob(int nbMembre, float invMassPart, float rayonPart, color couleurPart){
    for (int i = 0; i<nbMembre ; i++){
        Vecteur3D vecteurNul = new Vecteur3D(0,0,0);
        membre[i] = new Particule(invMassPart, vecteurNul , vecteurNul , vecteurNul);
        rayon = rayonPart;
        colorBlob = couleurPart;
    }
  }
  
    public void DrawBlob(){
    for (int i = 0; i<nbMembre ; i++){
       membre[i].display();
        
    }
  }
  

}
