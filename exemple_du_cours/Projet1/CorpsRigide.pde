class CorpsRigide{
  // Decrit l'objet
  Vecteur3D gravityCenter;
  ArrayList<Particule> ElemDeMasse;
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
    forceRegistry = new particuleForceRegistry();
    torqueManager = new TorqueManager();
    ElemDeMasse = new ArrayList<Particule>();
    
     Longueur = demiLongueur * 2;
     Largeur = demiLargeur * 2;
     Hauteur = demiHauteur * 2;
  
    this.torqueManager= new TorqueManager(); 
    this.GeometricalCenter = CentreGeometrique;
    gravityCenter = new Vecteur3D(0,0,0);
    //forceManager = new ForceManager();
    //torqueManager = new TorqueManager();
    if(type == 0){
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique, impulse));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,demiHauteur)),impulse));
    }
    else if(type == 1){
      ElemDeMasse.add(new Particule(14/mass, CentreGeometrique, impulse));
      ElemDeMasse.add(new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,demiHauteur)),impulse));
    }
    else{
      ElemDeMasse.add(new Particule(14/mass, CentreGeometrique, impulse));
      ElemDeMasse.add(new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,-1*demiHauteur)),impulse));
      ElemDeMasse.add(new Particule(14/(2*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,demiHauteur)),impulse));
    }
    for(int i = 0; i<9; i++){
      ElemDeMasse.get(i).corpsRigideBelonged = this;
      ElemDeMasse.get(i).SetLocalPositionWithGlobal();
      gravityCenter.Add(ElemDeMasse.get(i).Position.GetMultiply(ElemDeMasse.get(i).getMass()));
    torqueManager.AddTorqueToAccumulator(this, new Vecteur3D(0,98.1,0),ElemDeMasse.get(i));
    }
    gravityCenter.Divide(9);
    if(type == 0){
      ElemDeMasse.add(new Particule(10/mass, gravityCenter, impulse));
      ElemDeMasse.get(9).corpsRigideBelonged = this;
      ElemDeMasse.get(9).SetLocalPositionWithGlobal();
    }
    else{
      ElemDeMasse.add(new Particule(14/mass, gravityCenter, impulse));
      ElemDeMasse.get(9).corpsRigideBelonged = this;
      ElemDeMasse.get(9).SetLocalPositionWithGlobal();
    }
    forceRegistry.Add(ElemDeMasse.get(9), new ParticuleGravity());
    torqueManager.AddTorqueToAccumulator(this, new Vecteur3D(0,98.1,0),ElemDeMasse.get(9));
  }
  
  
  void Display(){
    pushMatrix();
    stroke(255, 255 , 255);
    fill(255);
    translate(GeometricalCenter.x ,GeometricalCenter.y, GeometricalCenter.z);
    box(50, 50, 50);
    for(int i = 0; i<10; i++){
      ElemDeMasse.get(i).display();
    }
    popMatrix();
  }
  
  //Met à jour l'état du corps rigide à partir des forces et torques appliquées
  //Absolument pas certain que la fct est correcte faut que je vérifie avec le cours
  void Update(float dt){
    //Vecteur3D alpha = torqueManager.CurrentJ.InvMat().Mv(torqueManager.CurrentTorque);
    torqueManager.ResetJ();
    torqueManager.ResetTorque();
    forceRegistry.UpdateForces(dt);
    //Vecteur3D omega = alpha.GetMultiply(dt);
    Vecteur3D newCentreGeo = new Vecteur3D(0,0,0);
    for(int i = 0; i<10; i++){
      ElemDeMasse.get(i).update(dt);
      newCentreGeo.Add(ElemDeMasse.get(i).Position);
      //ElemDeMasse.get(i).Vitesse.Add(omega.ProdVectoriel(ElemDeMasse.get(i).Position.GetSubstract(gravityCenter)));
      //torqueManager.AddTorqueToAccumulator(this, new Vecteur3D(0,98.1,0),ElemDeMasse.get(i));
    }    
    newCentreGeo.Substract(ElemDeMasse.get(9).Position);
    newCentreGeo.Substract(ElemDeMasse.get(0).Position);
    GeometricalCenter = newCentreGeo.GetDivide(8);
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
