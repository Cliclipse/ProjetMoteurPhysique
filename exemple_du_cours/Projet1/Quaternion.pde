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
  
  Quaternion ScalMultiplyAndGet(Quaternion q, float coef){
    q.r *= coef;
    q.i *= coef;
    q.j *= coef;
    q.k *= coef;
    return q;
  }
 
  Quaternion ScalDivideAndGet(Quaternion q, float coef){
    q.r /= coef;
    q.i /= coef;
    q.j /= coef;
    q.k /= coef;
    return q;
  }
  
  Quaternion AddAndGet(Quaternion q1, Quaternion q2){
    float r = q1.r + q2.r;
    float i = q1.i + q2.i;
    float j = q1.j + q2.j;
    float k = q1.k + q2.k;
    Quaternion q = new Quaternion(r , i , j , k);
    return q;
  }
  
   Quaternion SubAndGet(Quaternion q1, Quaternion q2){
    float r = q1.r - q2.r;
    float i = q1.i - q2.i;
    float j = q1.j - q2.j;
    float k = q1.k - q2.k;
    Quaternion q = new Quaternion(r , i , j , k);
    return q;
  }
  
  
  Quaternion MultiplyAndGet(Quaternion q1, Quaternion q2)
  {
    float r = q1.r * q2.r - q1.i * q2.i - q1.j * q2.j - q1.k * q2.k;
    float i = q1.r * q2.i + q1.i * q2.r + q1.j * q2.k - q1.k * q2.j;
    float j = q1.r * q2.j - q1.i * q2.k + q1.j * q2.r + q1.k * q2.i;
    float k = q1.r * q2.k + q1.i * q2.j - q1.j * q2.i + q1.k * q2.r;
    return new Quaternion(r, i, j, k);
  }
  
   Quaternion GetConjugate(Quaternion q)
  {
    float r = q.r;
    float i = -q.i;
    float j = -q.j;
    float k = -q.k;
    return new Quaternion(r, i, j, k);
  }

  
  
  
}
