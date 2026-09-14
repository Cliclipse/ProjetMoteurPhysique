class EquaAcceleration{
  //Equation vitesse de la forme K pour x y et z;

  //Pour le moment je pars du prinicipe qu'on utilise une accélération sous forme de vecteur constant. Pas de modif durant le mvt
  
  Vector vecteurAcceleration;
 
  EquaVitesse Derivation(Vector conditionInitiale){
    return EquaVitesse(vecteurAcceleration ,  conditionInitiale); 
  } 
  
  
  
