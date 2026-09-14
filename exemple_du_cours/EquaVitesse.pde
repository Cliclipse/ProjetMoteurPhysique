class EquaVitesse {
  //Equation vitesse de la forme at + B pour x y et z;
  
   Vector A;
   Vector B;

   EquaVitesse(Vector newVecteurVitesseA , Vector vecteurVitesseB){
      B = newVecteurVitesseB;
      A = newVecteurVitesseA;
    }
  
  EquaPosition Integration(Vector conditionInitiale){
    return EquaPosition(A , B , conditionInitiale); 
  } 
  
    EquaAcceleration Derivation(Vector conditionInitiale){
    return EquaAcceleration(A); 
  } 
  
}
  
  
  
  

  
