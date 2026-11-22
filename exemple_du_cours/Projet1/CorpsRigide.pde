class CorpsRigide{
  // Decrit l'objet
  Vecteur3D gravityCenter;
  Particule ElemDeMasse[];
  int nbElemMasse;
  float masseTotale;
  Vecteur3D GeometricalCenter;
  
  // Gère l'état de la rota
  Quaternion Rotation;
  Vecteur3D currentVelocity;
  Vecteur3D currentRotationVelocity;
  
  // Gère les forces et les torques pour upadate l'état du corps
  particuleForceRegistry forceRegistry;
  TorqueManager torqueManager;
  
  float Longueur;
  float Largeur;
  float Hauteur;
  
  CorpsRigide(Vecteur3D CentreGeometrique , float demiLongueur, float demiLargeur, float demiHauteur, float mass, int type, Vecteur3D impulse)
  {
     Longueur = demiLongueur * 2;
     Largeur = demiLargeur * 2;
     Hauteur = demiHauteur * 2;
  
    this.torqueManager= new TorqueManager(); 
    this.GeometricalCenter = CentreGeometrique;
    gravityCenter = new Vecteur3D(0,0,0);
    //forceManager = new ForceManager();
    //torqueManager = new TorqueManager();
    if(type == 0){
      ElemDeMasse[0] = new Particule(10/mass, CentreGeometrique, new Vecteur3D(0,0,0));
      ElemDeMasse[1] = new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[2] = new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[3] = new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[4] = new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[5] = new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[6] = new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[7] = new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[8] = new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
    }
    else if(type == 1){
      ElemDeMasse[0] = new Particule(14/mass, CentreGeometrique, new Vecteur3D(0,0,0));
      ElemDeMasse[1] = new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[2] = new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[3] = new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[4] = new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[5] = new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[6] = new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[7] = new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[8] = new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
    }
    else{
      ElemDeMasse[0] = new Particule(14/mass, CentreGeometrique, new Vecteur3D(0,0,0));
      ElemDeMasse[1] = new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[2] = new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[3] = new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[4] = new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[5] = new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[6] = new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[7] = new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0));
      ElemDeMasse[8] = new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,demiHauteur)),new Vecteur3D(0,0,0));
    }
    for(int i = 0; i<9; i++){
      ElemDeMasse[i].corpsRigideBelonged = this;
      ElemDeMasse[i].SetLocalPositionWithGlobal();
      gravityCenter.Add(ElemDeMasse[i].Position.GetMultiply(ElemDeMasse[i].getMass()));
    torqueManager.AddTorqueToAccumulator(this, new Vecteur3D(0,98.1,0),ElemDeMasse[i]);
    }
    gravityCenter.Divide(10);
    if(type == 0){
      ElemDeMasse[9] = new Particule(10/mass, gravityCenter, impulse);
      ElemDeMasse[9].corpsRigideBelonged = this;
      ElemDeMasse[9].SetLocalPositionWithGlobal();
    }
    else{
      ElemDeMasse[9] = new Particule(14/mass, gravityCenter, impulse);
      ElemDeMasse[9].corpsRigideBelonged = this;
      ElemDeMasse[9].SetLocalPositionWithGlobal();
    }
    forceRegistry.Add(ElemDeMasse[9], new ParticuleGravity());
    torqueManager.AddTorqueToAccumulator(this, new Vecteur3D(0,98.1,0),ElemDeMasse[9]);
  }
  
  
  void Display(){
    stroke(255, 255 , 255);
    fill(255);
    translate(GeometricalCenter.x ,GeometricalCenter.y, GeometricalCenter.z);
    box(Largeur, Hauteur, Longueur);
  }
  
  //Met à jour l'état du corps rigide à partir des forces et torques appliquées
  //Absolument pas certain que la fct est correcte faut que je vérifie avec le cours
  void Update(float dt){
    Vecteur3D alpha = torqueManager.CurrentJ.InvMat().Mv(torqueManager.CurrentTorque);
    torqueManager.ResetJ();
    torqueManager.ResetTorque();
    Vecteur3D omega = alpha.GetMultiply(dt);
    for(int i = 0; i<10; i++){
      ElemDeMasse[i].update(dt);
      ElemDeMasse[i].Vitesse.Add(omega.ProdVectoriel(ElemDeMasse[i].Position.GetSubstract(gravityCenter)));
      torqueManager.AddTorqueToAccumulator(this, new Vecteur3D(0,98.1,0),ElemDeMasse[i]);
    }    
  }
  
  
  
  
  /*
  CorpsRigide(float mass, Vecteur3D position, Vecteur3D scale)
  {
    this.ElemDeMasse[0] = new Particule(3/mass, position, new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
    this.ElemDeMasse[1] = new Particule(3/mass, position.GetAdd(scale), new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
    this.CentreGravite = new Particule(3/mass, ElemDeMasse[0].Position.GetAdd(ElemDeMasse[1].Position), new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
  }
  */
}
