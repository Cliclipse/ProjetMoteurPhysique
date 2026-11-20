class Matrix3{
  float[] contenu;
  
  Matrix3(){
    this.contenu = new float[]{0,0,0,0,0,0,0,0,0};
  }
  
  Matrix3(float[] contenu){
    float[] copy = new float[contenu.length];
    arrayCopy(contenu, copy);
    this.contenu = copy;
  }
  
  Matrix3 GetAdd(Matrix3 other){
    Matrix3 retour = new Matrix3(contenu);
    for(int i = 0; i<9; i++){
      retour.contenu[i] += other.contenu[i];
    }
    return(retour);
  }
  
  Matrix3 GetProdCoef(float coef){
    Matrix3 retour = new Matrix3(contenu);
    for(int i = 0; i<3; i++){
      for(int j = 0; j<3; j++){
        retour.contenu[3*i+j] = contenu[i*3+j]*coef;
      }
    }
    return(retour);
  }
  
  Matrix3 GetProduct(Matrix3 other){
    Matrix3 retour = new Matrix3(contenu);
    for(int i = 0; i<3; i++){
      for(int j = 0; j<3; j++){
        retour.contenu[3*i+j] = contenu[i*3]*other.contenu[j] + contenu[i*3+1]*other.contenu[j+3] + contenu[i*3+2]*other.contenu[j+6];
      }
    }
    return(retour);
  }
  
  float GetDet(){
    float[] c = contenu;
    float det = c[0]*c[4]*c[8] + c[1]*c[5]*c[6] + c[2]*c[3]*c[7] - c[2]*c[4]*c[6] - c[1]*c[3]*c[8] - c[5]*c[0]*c[7];
    return det;
  }
  /*
  Matrix3 InvMat(){
    float det = GetDet();
    if(abs(GetDet())<0.0001){
      return null;
    }
    Matrix3 inv = new Matrix3(contenu);
    return inv.GetProdCoef(1.0/det);
  }*/
}

class Matrix4{
  float[] contenu;
  
  Matrix4(float[] contenu){
    float[] copy = new float[contenu.length];
    arrayCopy(contenu, copy);
    this.contenu = copy;
  }
  
  Matrix4 GetAdd(Matrix4 other){
    Matrix4 retour = new Matrix4(contenu);
    for(int i = 0; i<12; i++){
      retour.contenu[i] += other.contenu[i];
    }
    return(retour);
  }
  
  Matrix4 GetProdCoef(float coef){
    Matrix4 retour = new Matrix4(contenu);
    for(int i = 0; i<3; i++){
      for(int j = 0; j<4; j++){
        retour.contenu[4*i+j] = contenu[i*4+j]*coef;
      }
    }
    return(retour);
  }
  
  Matrix4 GetProduct(Matrix4 other){
    Matrix4 retour = new Matrix4(contenu);
    for(int i = 0; i<3; i++){
      for(int j = 0; j<4; j++){
        retour.contenu[4*i+j] = contenu[i*4]*other.contenu[j] + contenu[i*4+1]*other.contenu[j+4] + contenu[i*4+2]*other.contenu[j+8] + contenu[i*4+3]*(j/3);
      }
    }
    return(retour);
  }
  
  float GetDet(){ //diagonale par bloc donc 1*determinant de la matrice 3*3
    float[] c = contenu;
    float det = c[0]*c[5]*c[10] + c[1]*c[6]*c[8] + c[2]*c[4]*c[9] - c[2]*c[5]*c[8] - c[1]*c[4]*c[10] - c[6]*c[0]*c[9];
    return det;
  }
  
  Matrix4(){
    this.contenu = new float[]{0,0,0,0,0,0,0,0,0,0,0,0};
  }
}
