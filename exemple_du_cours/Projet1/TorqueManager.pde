class TorqueManager{
  
  Vecteur3D CurrentTorque;
  Matrix3 CurrentJ;
  
  TorqueManager(){
    this.CurrentTorque = new Vecteur3D(0,0,0);
    this.CurrentJ = new Matrix3();
  }
  
  void AddTorqueToAccumulator(CorpsRigide c, Vecteur3D force, Particule point){
    Vecteur3D r = point.Position.GetSubstract(c.gravityCenter);
    CurrentTorque.Add(force.ProdVectoriel(r));    
    CurrentJ = CurrentJ.GetAdd(GetJ(point,c));
  }
  
  void ResetTorque(){
    CurrentTorque.Reset();
  }
  
  void ResetJ(){
    for(int i = 0; i<9; i++){
      CurrentJ.contenu[i] = 0;
    }
  }
  
  Matrix3 GetJ(Particule p, CorpsRigide c){
    float mass = p.getMass();
    Vecteur3D r = p.Position.GetSubstract(c.gravityCenter);
    float contenu[] = new float[9];
    contenu[0] = mass*(r.y*r.y+r.z*r.z);
    contenu[1] = mass*r.y*r.x*(-1);
    contenu[2] = mass*r.z*r.x*(-1);
    contenu[3] = mass*r.x*r.y*(-1);
    contenu[4] = mass*(r.z*r.z+r.x*r.x);
    contenu[5] = mass*r.z*r.y*(-1);
    contenu[6] = mass*r.x*r.z*(-1);
    contenu[7] = mass*r.y*r.z*(-1);
    contenu[8] = mass*(r.x*r.x+r.y*r.y);
    return(new Matrix3(contenu));
  }
}
