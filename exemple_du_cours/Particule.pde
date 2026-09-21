Particule p;

void setup() {
  size(640, 360, P3D);
  noStroke();
  p = new Particule(10.0,1.0);
}


void draw() {
  background(102);
  p.update(1);
  p.display();
}


class Particule {
  Vecteur3D Position;
  Vecteur3D Vitesse;
  Vecteur3D Acceleration;
  float mass;
  float invMass;
  
  Particule(float mass, float coefAcceleration){
    this.mass = mass;
    Position = new Vecteur3D(320,180,0);
    Vitesse = new Vecteur3D(0,0,0);
    Acceleration = new Vecteur3D(0,0,-1);
    Acceleration.Multiply(coefAcceleration);
  }
  
  float getInvMass(){
    return(1/mass);
  }
  
  void setMass(float invMass){
    mass = 1/invMass;
  }
  
  void Integrer(float temps){
    Vitesse.x += Acceleration.x*temps; // v = v+a*t
    Vitesse.y += Acceleration.y*temps;
    Vitesse.z += Acceleration.z*temps;
    Position.x += Vitesse.x*temps+Acceleration.x*temps*temps/2;
    Position.y += Vitesse.y*temps+Acceleration.y*temps*temps/2;
    Position.z += Vitesse.x*temps+Acceleration.z*temps*temps/2;
  }
  
  void update(float temps) {
    Integrer(temps);
  }
 
  
  void display() {
  pushMatrix();
  translate(Position.x, Position.y, Position.z);
  fill(255);
  sphere(10);
//  ellipse(0, 0, 10, 10);
  popMatrix();
  }
}
