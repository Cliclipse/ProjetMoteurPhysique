class CorpsRigide{
  Vecteur3D gravityCenter;
  Particule ElemDeMasse[];
  int nbElemMasse;
  
  
  Quaternion Rotation;
  float currentVelocity;
  float currentRotationVelocity;
  
  CorpsRigide(Vecteur3D newGravityCenter , Particule[] newElemDeMasse, int nbElemMasse )
  {
    gravityCenter = newGravityCenter;
    
    for(int i = 0 ; i<nbElemMasse ; i++)
    {
      newElemDeMasse[i].corpsRigideBelonged = this;
      newElemDeMasse[i].SetLocalPositionWithGlobal();
    }
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
