class TorqueManager{
  
  Vecteur3D CurrentTorque;
  
  void AddTorqueToAccumulator(CorpsRigide c, Vecteur3D force, Particule point){
    Vecteur3D r = point.Position.GetSubstract(c.GeometricalCenter);
    CurrentTorque.Add(force.ProdVectoriel(r));    
  }
  
  void ResetTorque(){
    CurrentTorque.Reset();
  }
  
  Matrix3 GetJ(Particule p, CorpsRigide c){
    float mass = p.getMass();
    Vecteur3D r = p.Position.GetSubstract(c.GeometricalCenter);
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
