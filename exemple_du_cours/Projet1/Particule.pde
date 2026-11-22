class Particule {
  Vecteur3D Position;
  
  Vecteur3D LocalPosition; //Utile pour les particules d'un corps rigide
  CorpsRigide corpsRigideBelonged;
  
  Vecteur3D Vitesse;
  Vecteur3D Acceleration;
  float inverseMass;
  float rayon = 5;
  int couleur = color(0);
  Vecteur3D AccumForce = new Vecteur3D(0,0,0);
  
  Particule(float invMass, Vecteur3D posInit, Vecteur3D vitesseInit){
    this.inverseMass = invMass;
    Position = posInit;
    Vitesse = vitesseInit;
    Acceleration = new Vecteur3D(0,0,0);
  }
  
  float getInvMass(){
    return(inverseMass);
  }
  
  public float getMass(){
    return (1/inverseMass);
  }
  
  void AddForce(Vecteur3D force){
    AccumForce.Add(force); 
  }

  
  void clearAccum(){
    AccumForce.Reset();
  }
  
  void setInvMass(float invMass){
    inverseMass = invMass;
  }
  
  void Integrer(float temps){
    Position.x += Vitesse.x*temps+Acceleration.x*temps*temps*0.5;
    Position.y += Vitesse.y*temps+Acceleration.y*temps*temps*0.5;
    Position.z += Vitesse.z*temps+Acceleration.z*temps*temps*0.5;
    //inversion sinon on applique 2 fois l acceleration
    Vitesse.Multiply(pow(damping,temps)); // damping
    Vitesse.x += Acceleration.x*temps; // v = v+a*t
    Vitesse.y += Acceleration.y*temps;
    Vitesse.z += Acceleration.z*temps;
}
  
  void update(float temps) {
    Acceleration = AccumForce.GetMultiply(inverseMass);
    clearAccum();
    Integrer(temps);
  }
 
  
  void display() {
    pushMatrix();
    translate(Position.x, Position.y, Position.z);
    fill(couleur);
    sphere(rayon);
    popMatrix();
  }
  
  boolean touche(Particule autre) {
    Vecteur3D d = new Vecteur3D(Position.x, Position.y, Position.z);
    d.Substract(autre.Position);
    float r = rayon + autre.rayon;
    return d.NormeCarre() <= r*r;
  }
  
  void setGlobalPositionWithLocal(){
    if (corpsRigideBelonged == null) return;
    Vecteur3D localPositionWithRotation = corpsRigideBelonged.Rotation.RotateVecteurAndGet(LocalPosition);
    Position = corpsRigideBelonged.gravityCenter.GetAdd(localPositionWithRotation);
  }
  
  void SetLocalPositionWithGlobal(){ //Utilisé à la création d'un Corps Rigide donc prend pas en compte les rotas
       if (corpsRigideBelonged == null) return;

    LocalPosition = Position.GetSubstract(corpsRigideBelonged.gravityCenter);
  }
  
}
