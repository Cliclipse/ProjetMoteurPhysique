class Blob{
  Particule[] membre;
  int nbMembre;
  int indexMasterParticule;
  float particulesSpeed;
  float invMassPart;
  color colorBlob = color(255, 0, 0);
  float rayon = 0.5f;
  
  
  
  //Ressort[] muscle;
  
  //Fonction qui apply la physique pour chaque particule du blob
  public void ApplyPhysic(){
    for(int i = 0 ; i <nbMembre ; i++); //membre[i].calculForce();
  }
  /*
  public void Move(char keyPressed)
  {
    print(keyPressed);
    Vecteur3D move = new Vecteur3D(0,0,0);
    
    
    if (key == 'q') move.x += ;
    
    
    || key == 's' || key == 'd' || key == 'z')

    
   //Ajout à la particule maitre dans son accumulator de force une certaine force vers la droite
  }
  
  */
  
  Blob(int nbMembre, float invMassPart, float rayonPart, color couleurPart){
    rayon = rayonPart;
    colorBlob = couleurPart;
    for (int i = 0; i<nbMembre ; i++){
        Vecteur3D vecteurNul = new Vecteur3D(0,0,0);
        membre[i] = new Particule(invMassPart, vecteurNul , vecteurNul , vecteurNul);
        membre[i].rayon = rayon;
        membre[i].couleur = colorBlob;
        membre[i].isInBlob = true;
        
    }
  }
  
    public void DrawBlob(){
    for (int i = 0; i<nbMembre ; i++){
       membre[i].display();
    }
  }
  

}
