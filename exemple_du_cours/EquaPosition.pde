class EquaPosition {
  //Equation vitesse de la forme At^2 +Bt +K pour x y et z;
  
   Vector A;
   Vector B;
   Vector K;


    EquaPosition(Vector newA , Vector newB, Vector newK){
       A = newA;
       B = newB;
       K = newK;
    }
    
    Vector GetPosition(float time){
      return  A*t*t + B*t + K;
    }
    
    //Calcul t lorsque y est à son maximum
    //y au maximum quand vy = 0    vy = at+b    t = a/b
    float GetHigher(){
      return A.y / B.y;
    }


  
}
  
