Vecteur3D v1;

void setup(){
  size(640, 360);
  noStroke();
  v1 = new Vecteur3D(0,0,0);
}

void draw(){
  background(102);
  v1.update(mouseX, mouseY);
  v1.display();
}

class Vecteur3D {
  float x, y, z;
  
  Vecteur3D(int tx , int ty , int tz){
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
    Vector result;
    result.x = this.y * vector.z - vector.y - this.z;
    result.y = this.z * vector.x - vector.z - this.x;
    result.x = this.x * vector.y - vector.x - this.y;
    return result;
  }
  
  //Norme
  float Norme(){
    result = 0;
    //result = sqrt(this.x * this.x + this.y * this.y + this.z * this.z); // A test je sais pas si sqrt est natif
    return result; 
  }

  //Normaliser (jsp si ce sera utile)
  Vecteur3D Normalised(){
    return this.Divide(this.Norme());
  }
  
  void update(float mx, float my){
    x = mx;
    y = my;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    fill(255);
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
}
