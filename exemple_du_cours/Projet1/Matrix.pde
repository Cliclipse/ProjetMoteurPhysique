class Matrix3{
  float[] contenu;
  
  Matrix3(float[] contenu){
    this.contenu = contenu;
  }
  
  Matrix3 GetAdd(Matrix3 other){
    Matrix3 retour = new Matrix3(contenu);
    for(int i = 0; i<9; i++){
      retour.contenu[i] += other.contenu[i];
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
}

class Matrix4{
  float[] contenu = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
  
  Matrix4(float[] contenu){
    this.contenu = contenu;
  }
  
  Matrix4 GetAdd(Matrix4 other){
    Matrix4 retour = new Matrix4(contenu);
    for(int i = 0; i<16; i++){
      retour.contenu[i] += other.contenu[i];
    }
    return(retour);
  }
  
  Matrix4 GetProduct(Matrix4 other){
    Matrix4 retour = new Matrix4(contenu);
    for(int i = 0; i<4; i++){
      for(int j = 0; j<4; j++){
        retour.contenu[4*i+j] = contenu[i*4]*other.contenu[j] + contenu[i*4+1]*other.contenu[j+4] + contenu[i*4+2]*other.contenu[j+8] + contenu[i*4+3]*other.contenu[j+12];
      }
    }
    return(retour);
  }
}
