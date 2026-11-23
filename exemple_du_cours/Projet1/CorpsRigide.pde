class CorpsRigide{
  // Decrit l'objet
  Vecteur3D gravityCenter;
  ArrayList<Particule> ElemDeMasse;
  int nbElemMasse;
  float masseTotale;
  Vecteur3D GeometricalCenter;
  //float theta;
  Vecteur3D omega;
  
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
    omega = new Vecteur3D(0,0,0);
    //theta = 0;
    forceRegistry = new particuleForceRegistry();
    torqueManager = new TorqueManager();
    ElemDeMasse = new ArrayList<Particule>();
    
     Longueur = demiLongueur * 2;
     Largeur = demiLargeur * 2;
     Hauteur = demiHauteur * 2;
  
    this.torqueManager= new TorqueManager(); 
    this.GeometricalCenter = CentreGeometrique;
    gravityCenter = new Vecteur3D(0,0,0);
    if(type == 0){
      ElemDeMasse.add(new Particule(10/mass, new Vecteur3D(CentreGeometrique.x, CentreGeometrique.y, CentreGeometrique.z), new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,demiHauteur)), new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(10/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,demiHauteur)),new Vecteur3D(0,0,0)));
    }
    else if(type == 1){
      ElemDeMasse.add(new Particule(22/mass, new Vecteur3D(CentreGeometrique.x, CentreGeometrique.y, CentreGeometrique.z), new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/(4*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/(4*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/(4*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/(4*mass), CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/mass, CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,demiHauteur)),new Vecteur3D(0,0,0)));
    }
    else{
      ElemDeMasse.add(new Particule(22/mass, new Vecteur3D(CentreGeometrique.x, CentreGeometrique.y, CentreGeometrique.z), new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/mass, CentreGeometrique.GetSubstract(new Vecteur3D(-1*demiLongueur,demiLargeur,demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/(4*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/(4*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,-1*demiLargeur,demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/(4*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,-1*demiHauteur)),new Vecteur3D(0,0,0)));
      ElemDeMasse.add(new Particule(22/(4*mass), CentreGeometrique.GetSubstract(new Vecteur3D(demiLongueur,demiLargeur,demiHauteur)),new Vecteur3D(0,0,0)));
    }
    for(int i = 0; i<9; i++){
      ElemDeMasse.get(i).corpsRigideBelonged = this;
      //ElemDeMasse.get(i).SetLocalPositionWithGlobal();
      gravityCenter.Add(ElemDeMasse.get(i).Position.GetMultiply(ElemDeMasse.get(i).getMass()));
      //torqueManager.AddTorqueToAccumulator(this, new Vecteur3D(0,98.1,0),ElemDeMasse.get(i));
    }
    if(type == 0){
      gravityCenter.Divide(mass*9/10);
      ElemDeMasse.add(new Particule(10/mass, gravityCenter, new Vecteur3D(impulse.x, impulse.y, impulse.z)));
      ElemDeMasse.get(9).corpsRigideBelonged = this;
      //ElemDeMasse.get(9).SetLocalPositionWithGlobal();
    }
    else{
      gravityCenter.Divide(mass*21/22);
      ElemDeMasse.add(new Particule(22/mass, gravityCenter, new Vecteur3D(impulse.x, impulse.y, impulse.z)));
      ElemDeMasse.get(9).corpsRigideBelonged = this;
      //ElemDeMasse.get(9).SetLocalPositionWithGlobal();
    }
    forceRegistry.Add(ElemDeMasse.get(9), new ParticuleGravity());
    //torqueManager.AddTorqueToAccumulator(this, new Vecteur3D(0,98.1,0),ElemDeMasse.get(9));
    for(int i = 0; i<10; i++){
      ElemDeMasse.get(i).SetLocalPositionWithGlobal();
      torqueManager.CurrentJ = torqueManager.CurrentJ.GetAdd(torqueManager.GetJ(ElemDeMasse.get(i), this));
    }
    Rotation = new Quaternion(1, 0, 0, 0);
    Vecteur3D r = CentreGeometrique.GetSubstract(gravityCenter);
    Vecteur3D impulsionAngulaire = r.ProdVectoriel(impulse.GetMultiply(mass));
    omega = torqueManager.CurrentJ.InvMat().Mv(impulsionAngulaire);
  }
  
  
  void Display(){
    pushMatrix();
    stroke(0);// contours noirs
    strokeWeight(2);
    fill(255);
    //for(int i = 0; i<10; i++){
//      ElemDeMasse.get(i).display();
  //  }
    translate(GeometricalCenter.x ,GeometricalCenter.y, GeometricalCenter.z);
    //rotate(theta);
    float[] m = Rotation.GetMatrix3WithQuaternion().contenu;
    applyMatrix(m[0], m[1], m[2], 0,
                m[3], m[4], m[5], 0,
                m[6], m[7], m[8], 0,
                0,    0,    0,    1);
    box(Longueur, Largeur, Hauteur);
    popMatrix();
    hint(DISABLE_DEPTH_TEST);
    pushMatrix();
    translate(gravityCenter.x, gravityCenter.y, gravityCenter.z);
    noStroke();
    fill(ElemDeMasse.get(9).couleur);
    sphere(4);
    popMatrix();
    hint(ENABLE_DEPTH_TEST);
  }
  
  //Met à jour l'état du corps rigide à partir des forces et torques appliquées
  //Absolument pas certain que la fct est correcte faut que je vérifie avec le cours
  void Update(float dt){
    Vecteur3D alpha = torqueManager.CurrentJ.InvMat().vM(torqueManager.CurrentTorque);
    //torqueManager.ResetJ();
    torqueManager.ResetTorque();
    forceRegistry.UpdateForces(dt);
    omega.Add(alpha.GetMultiply(dt));
    Rotation = Rotation.UpdateWithAngularVelocity(omega, dt);
    ElemDeMasse.get(9).update(dt);
    Vecteur3D newCentreGeo = new Vecteur3D(0,0,0);
    for(int i = 0; i<9; i++){
      ElemDeMasse.get(i).setGlobalPositionWithLocal();
      newCentreGeo.Add(ElemDeMasse.get(i).Position);
      //theta = omega.Norme()*dt;
      //torqueManager.AddTorqueToAccumulator(this, new Vecteur3D(0,98.1,0),ElemDeMasse.get(i));
    }    
    //newCentreGeo.Substract(ElemDeMasse.get(9).Position);
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
