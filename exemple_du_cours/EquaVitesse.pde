class EquaVitesse {
  //Equation vitesse de la forme at + K pour x y et z;
  
   Vector K;
   Vector A;

   EquaVitesse(Vector newVecteurVitesseA , Vector vecteurVitesseK){
      K = newVecteurVitesseK;
      A = newVecteurVitesseA;
    }
  
  EquaPosition Derivation(Vector conditionInitiale){
    return EquaPosition(A , K , conditionInitiale); 
  } 
  
}
  
  
  
  

  
