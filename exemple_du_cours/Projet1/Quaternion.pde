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

  Quaternion ScalMultiplyAndGet(float coef){
    Quaternion q = new Quaternion(r, i, j, k);
    q.r *= coef;
    q.i *= coef;
    q.j *= coef;
    q.k *= coef;
    return q;
  }
 
  Quaternion ScalDivideAndGet(float coef){
    Quaternion q = new Quaternion(r, i, j, k);
    q.r /= coef;
    q.i /= coef;
    q.j /= coef;
    q.k /= coef;
    return q;
  }
  
  Quaternion AddAndGet(Quaternion q){
    float new_r = r + q.r;
    float new_i = i + q.i;
    float new_j = j + q.j;
    float new_k = k + q.k;
    return new Quaternion(new_r , new_i , new_j , new_k);
  }
  
   Quaternion SubAndGet(Quaternion q){
    float new_r = r - q.r;
    float new_i = i - q.i;
    float new_j = j - q.j;
    float new_k = k - q.k;
    return new Quaternion(new_r , new_i , new_j , new_k);
  }
  
  
  Quaternion MultiplyAndGet(Quaternion q)
  {
    float new_r = r * q.r - i * q.i - j * q.j - k * q.k;
    float new_i = r * q.i + i * q.r + j * q.k - k * q.j;
    float new_j = r * q.j - i * q.k + j * q.r + k * q.i;
    float new_k = r * q.k + i * q.j - j * q.i + k * q.r;
    return new Quaternion(new_r, new_i, new_j, new_k);
  }
  
   Quaternion GetConjugate()
  {
    return new Quaternion(r, -i, -j, -k);
  }

  float GetNorme()
  {
    float norme = sqrt(this.MultiplyAndGet(this.GetConjugate()).r);
    return norme;
  }
  
    
  Quaternion GetNormalize()
  {
    return this.ScalDivideAndGet(this.GetNorme());    
  }
  
  Quaternion GetInverse()
  {
    return this.GetConjugate().ScalDivideAndGet(pow(this.GetNorme(), 2));
  }
  
  
Vecteur3D RotateVecteurAndGet(Vecteur3D vecteur) {
    Quaternion qNormalized = this.GetNormalize();
    Quaternion qNormalizedConj = qNormalized.GetConjugate();

    Quaternion r = new Quaternion(0, vecteur.x, vecteur.y, vecteur.z); //Evite la matrice 4-3
    Quaternion rRot = qNormalized.MultiplyAndGet(r).MultiplyAndGet(qNormalizedConj);     // r rot = qrot, r, qrot*
    
    return new Vecteur3D(rRot.i, rRot.j, rRot.k);
}
  
  
  Matrix3 GetMatrix3WithQuaternion(){
    Quaternion qNorm = this.GetNormalize();

    float r = qNorm.r;
    float i = qNorm.i;
    float j = qNorm.j;
    float k = qNorm.k;

    Matrix3 m = new Matrix3();

    m.contenu[0] = 1 - 2*j*j - 2*k*k;
    m.contenu[1] = 2*(i*j - r*k);
    m.contenu[2] = 2*(i*k + r*j);

    m.contenu[3] = 2*(i*j + r*k);
    m.contenu[4] = 1 - 2*i*i - 2*k*k;
    m.contenu[5] = 2*(j*k - r*i);

    m.contenu[6] = 2*(i*k - r*j);
    m.contenu[7] = 2*(j*k + r*i);
    m.contenu[8] = 1 - 2*i*i - 2*j*j;

    return m;
  }

  float GetProdScal(Quaternion q){
    return r*q.r + i*q.i + j*q.j + k*q.k;
  }
  
  Quaternion SLerp(Quaternion q , float  t){
    Quaternion dq = q.MultiplyAndGet(this.GetInverse());
    float alpha = acos(dq.r);
    
    float partieReelle = cos(t * alpha);
    float partieComplexe = sin(t * alpha) / sin(alpha);
    Quaternion dqt = new Quaternion(partieReelle, partieComplexe * dq.i, partieComplexe * dq.j, partieComplexe * dq.k);
    return dqt.MultiplyAndGet(this);
  } 
  
  // q' = q + 1/2 * w * q * dt
  Quaternion UpdateWithAngularVelocity(Vecteur3D omega, float dt){
    Quaternion wq = new Quaternion(0, omega.x, omega.y, omega.z).MultiplyAndGet(this);
    return this.AddAndGet(wq.ScalMultiplyAndGet(0.5 * dt)).GetNormalize();
  }

}
