class CorpsRigide{
  // Decrit l'objet
  Vecteur3D gravityCenter;
  Particule ElemDeMasse[];
  int nbElemMasse;
  float masseTotale;
  
  // Gère l'état de la rota
  Quaternion Rotation;
  Vecteur3D currentVelocity;
  Vecteur3D currentRotationVelocity;
  
  // Gère les forces et les torques pour upadate l'état du corps
  ForceManager forceManager;
  TorqueManager torqueManager;
  
  
  
  CorpsRigide(Vecteur3D newGravityCenter , Particule[] newElemDeMasse, int nbElemMasse )
  {
    gravityCenter = newGravityCenter;
    forceManager = new ForceManager();
    torqueManager = new TorqueManager();
    
    for(int i = 0 ; i<nbElemMasse ; i++)
    {
      newElemDeMasse[i].corpsRigideBelonged = this;
      newElemDeMasse[i].SetLocalPositionWithGlobal();
    }
  }
  
  //Met à jour l'état du corps rigide à partir des forces et torques appliquées
  //Absolument pas certain que la fct est correcte faut que je vérifie avec le cours
  void Update(float dt){
    Vecteur3D deltaVelocity = forceManager.CurrentForce.GetMultiply(dt).GetDivide(masseTotale);
    currentVelocity.Substract(deltaVelocity);
    
    //Vecteur3D deltaRotationVelocity = torqueManager.CurrentTorque.GetMultiply(dt).GetDivide(masseTotale); //Pas encore de classe quaternion fonctionnelle
    //currentVelocity.Substract(deltaRotationVelocity);
    
  }
  

  void ApplyForceAndTorque(){
    //Fct où on donnerait une force, l'endroit où on l'aplique et qui ajouterait aux accumulateurs la force et le torque généré
  }
  
  
  
  //Pour bouger on bouge le centre de masse et de rotas pouis on appelle la fct qui calc la position global des particules à partir de leur position local, la position local change jamais
  //PLus simple que tenir constamment la position globale
  
  
  
  /*
  CorpsRigide(float mass, Vecteur3D position, Vecteur3D scale)
  {
    this.ElemDeMasse[0] = new Particule(3/mass, position, new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
    this.ElemDeMasse[1] = new Particule(3/mass, position.GetAdd(scale), new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
    this.CentreGravite = new Particule(3/mass, ElemDeMasse[0].Position.GetAdd(ElemDeMasse[1].Position), new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
  }
  */
}
