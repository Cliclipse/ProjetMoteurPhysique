class Quaternion{
  float r,i,j,k;
  
  Quaternion()
  {
    this.r = 0;
    this.i = 0;
    this.j = 0;
    this.k = 0;
  }
  
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

  float GetNorme(Quaternion q)
  {
    float norme = sqrt(MultiplyAndGet(q , GetConjugate(q)).r);
    return norme;
  }
  
    
  Quaternion GetNormalize(Quaternion q)
  {
    Quaternion newQ = new Quaternion();
    newQ = ScalDivideAndGet(q , GetNorme(q));    
    return newQ;
  }
  
  Quaternion GetInverse(Quaternion q)
  {
    Quaternion newQ = new Quaternion();
    newQ = ScalDivideAndGet(GetConjugate(q), GetNorme(q));
    return newQ;
  }
  
   Quaternion GetRotationQuaternion(Vecteur3D vecteur , float theta)
  {
    float arg = theta/2; 
    float r = cos(arg);
    float i = vecteur.x * sin(arg);
    float j = vecteur.y * sin(arg);
    float k = vecteur.z * sin(arg);
    Quaternion newQ = new Quaternion(r, i, j, k);
    return newQ;
  }
  
Vecteur3D RotateVecteurAndGet(Vecteur3D vecteur, Quaternion q) {
    Quaternion qNormalized = GetNormalize(q);
    Quaternion qNormalizedConj = GetConjugate(qNormalized);

    Quaternion r = new Quaternion(0, vecteur.x, vecteur.y, vecteur.z); //Evite la matrice 4-3
    Quaternion rRot = MultiplyAndGet(MultiplyAndGet(qNormalized, r), qNormalizedConj);     // r rot = qrot, r, qrot*
    
    return new Vecteur3D(rRot.i, rRot.j, rRot.k);
}
  
  
  Matrix3 GetMatrixWithQuaternion(Quaternion q){
    Quaternion qNorm = GetNormalize(q);

    float r = qNorm.r;
    float i = qNorm.i;
    float j = qNorm.j;
    float k = qNorm.k;

    Matrix3 m = new Matrix3();
    m.contenu = new float[9];

    m.contenu[0] = 1 - 2*y*y - 2*z*z;
    m.contenu[1] = 2*(i*j - r*z);
    m.contenu[2] = 2*(i*k + r*j);

    m.contenu[3] = 2*(i*j + r*k);
    m.contenu[4] = 1 - 2*i*i - 2*k*k;
    m.contenu[5] = 2*(j*k - r*i);

    m.contenu[6] = 2*(i*k - r*y);
    m.contenu[7] = 2*(j*k + r*i);
    m.contenu[8] = 1 - 2*i*i - 2*j*j;

    return m;
}
  
 
}
