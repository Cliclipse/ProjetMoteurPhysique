class Vecteur3D {
  float x, y, z;
  
  Vecteur3D(float tx , float ty , float tz){ // coordonnées mises e float
    x = tx;
    y = ty;
    z = tz;
  }
  
  // addition de vecteurs
  void Add(Vecteur3D vector) {
    x += vector.x;
    y += vector.y;
    z += vector.z;
  }
  
  // Soustraction de vecteurs
  void Substract(Vecteur3D vector) {
    x -= vector.x;
    y -= vector.y;
    z -= vector.z;
  }
  
  // Multiplication avec un coef
  void Multiply(float coef) {
    x *= coef;
    y *= coef;
    z *= coef;
  }
  
  // Division avec un coef
  void Divide(float coef) {
    x /= coef;
    y /= coef;
    z /= coef;
  }
  
  //Produit Scalaire
  float ProdScalaire(Vecteur3D vector){
    float result = this.x * vector.x + this.y * vector.y + this.z * vector.z;
    return result;
  }
  
   //Produit Vectoriel
  Vecteur3D ProdVectoriel(Vecteur3D vector){
    Vecteur3D result = new Vecteur3D(0,0,0);
    result.x = this.y * vector.z - vector.y * this.z;
    result.y = this.z * vector.x - vector.z * this.x;
    result.z = this.x * vector.y - vector.x * this.y;
    return result;
  }
  
  //Norme
  float NormeCarre(){
    float result = this.x * this.x + this.y * this.y + this.z * this.z;
    return result; 
  }
  
  float Norme(){
    return(sqrt(this.NormeCarre()));
  }

  void Normalised(){
    if (this.Norme() != 0){
      this.Divide(this.Norme());
    }
  }
  
  boolean Egal(Vecteur3D v){
    return (abs(this.x - v.x) < 0.0001 && abs(this.y - v.y) < 0.0001 && abs(this.z - v.z) < 0.001);
  }
}
