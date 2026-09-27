class Particule {
  Vecteur3D Position;
  Vecteur3D Vitesse;
  Vecteur3D Acceleration;
  float mass;
  float rayon = 5;
  int couleur = color(0);
  
  Particule(float mass, Vecteur3D posInit, Vecteur3D vitesseInit, Vecteur3D force){
    this.mass = mass;
    Position = posInit;
    Vitesse = vitesseInit;
    Acceleration = new Vecteur3D(force.x, force.y, force.z);
    Acceleration.Divide(mass); // somme(force) = m*a donc a = somme(force)/m or une seule force donc a = force/m
  }
  
  float getInvMass(){
    return(1/mass);
  }
  
  void setInvMass(float invMass){
    mass = 1/invMass;
  }
  
  void Integrer(float temps){
    Position.x += Vitesse.x*temps+Acceleration.x*temps*temps*0.5;
    Position.y += Vitesse.y*temps+Acceleration.y*temps*temps*0.5;
    Position.z += Vitesse.z*temps+Acceleration.z*temps*temps*0.5;
    //inversion sinon on applique 2 fois l acceleration
    Vitesse.Multiply(pow(damping,temps)); // damping
    Vitesse.x += Acceleration.x*temps; // v = v+a*t
    Vitesse.y += Acceleration.y*temps;
    Vitesse.z += Acceleration.z*temps;
}
  
  void update(float temps) {
    Integrer(temps);
  }
 
  
  void display() {
    pushMatrix();
    translate(Position.x, Position.y, Position.z);
    fill(couleur);
    sphere(rayon);
    popMatrix();
  }
  
  boolean touche(Particule autre) {
    Vecteur3D d = new Vecteur3D(Position.x, Position.y, Position.z);
    d.Substract(autre.Position);
    float r = rayon + autre.rayon;
    return d.NormeCarre() <= r*r;
  }
}
