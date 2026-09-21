class EquaAcceleration{
  //Equation vitesse de la forme A pour x y et z;

  //Pour le moment je pars du prinicipe qu'on utilise une accélération sous forme de vecteur constant. Pas de modif durant le mvt
  
  Vector A;
 
 EquaAcceleration(Vector newA)
 {
   A = newA;
 }
 
 
 
  EquaVitesse Integration(Vector conditionInitiale){
    return EquaVitesse(A ,  conditionInitiale); 
  } 
}
