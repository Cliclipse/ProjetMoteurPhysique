Particule p;

void setup() {
  size(640, 360);
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
  
  Particule(float mass, float coefAcceleration){
    this.mass = mass;
    Position = new Vecteur3D(0,100,0);
    Vitesse = new Vecteur3D(0,0,0);
    Acceleration = new Vecteur3D(1,0,0);
    Acceleration.Multiply(coefAcceleration);
  }
  
  float getInvMass(){
    return(1/mass);
  }
  
  void setMass(float invMass){
    mass = 1/invMass;
  }
  
  void Integrer(float temps){
    Vitesse.x += Acceleration.x*temps;
    Vitesse.y += Acceleration.y*temps;
    Vitesse.z += Acceleration.z*temps;
    Position.x += Vitesse.x*temps;
    Position.y += Vitesse.y*temps;
    Position.z += Vitesse.z*temps;
  }
  
  void update(float temps) {
    Integrer(temps);
  }
 
  
  void display() {
  pushMatrix();
  translate(Position.x, Position.y);
  fill(255);
  ellipse(0, 0, 10, 10);
  popMatrix();
  }
}
