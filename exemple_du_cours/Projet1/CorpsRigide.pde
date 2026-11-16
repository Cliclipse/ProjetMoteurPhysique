class CorpsRigide{
  Particule CentreGravite;
  Particule ElemDeMasse[];
  
  CorpsRigide(float mass, Vecteur3D position, Vecteur3D scale)
  {
    this.CentreGravite = new Particule(2/mass, position, new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
    this.ElemDeMasse[0] = this.CentreGravite;
    this.ElemDeMasse[1] = new Particule(2/mass, position.GetAdd(scale), new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
  }
}
