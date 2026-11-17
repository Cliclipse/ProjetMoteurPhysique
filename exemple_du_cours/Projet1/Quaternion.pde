class Quaternion{
  float r,i,j,k;
  
  Quaternion(float reel, float i, float j, float k)
  {
    this.r = reel;
    this.i = i;
    this.j = j;
    this.k = k;
  }
  
  Matrix4 GetMatrix4()
  {
    float[] contenu = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    Matrix4 retour = new Matrix4(contenu);
    retour.contenu[0] = r;
    retour.contenu[1] = -k;
    retour.contenu[2] = j;
    retour.contenu[3] = i;
    retour.contenu[4] = k;
    retour.contenu[5] = r;
    retour.contenu[6] = -i;
    retour.contenu[7] = j;
    retour.contenu[8] = -j;
    retour.contenu[9] = i;
    retour.contenu[10] = r;
    retour.contenu[11] = k;
    retour.contenu[12] = -i;
    retour.contenu[13] = -j;
    retour.contenu[14] = -k;
    retour.contenu[15] = r;
    return(retour);
  }
  
  Vecteur3D RotateVecteurAndGet(Vecteur3D vecteur){
    //code retournant le vecteur avec une rota, pas encore implémentée
    return new Vecteur3D(0,0,0); 
  }
}
