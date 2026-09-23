/*Particule p;
float dt; // duree de la frame
int timeLastFrame; //temps actuel
float damping = 0.95;

void setup() {
  size(640, 360, P3D);
  noStroke();
  Vecteur3D v0 = new Vecteur3D(50,-50,0);
  Vecteur3D pos0 = new Vecteur3D(100,500,0);
  float masse = 10.0;
  Vecteur3D force = new Vecteur3D(0,10,0); //y vertical et vers le bas -> g selon y et positif ?
  force.Multiply(masse);
  p = new Particule(masse, pos0, v0, force);
  timeLastFrame = millis();
}


void draw() {
  //background(102);
  dt = (millis() - timeLastFrame)*0.001; // millisecondes -> secondes
  timeLastFrame = millis();
  print("duree frame:" + dt + " secondes\n");
  p.update(dt);
  p.display();
}*/


class Particule {
  Vecteur3D Position;
  Vecteur3D Vitesse;
  Vecteur3D Acceleration;
  float mass;
  
  Particule(float mass, Vecteur3D posInit, Vecteur3D vitesseInit, Vecteur3D force){ // vitesse et position de base ajoutée
    this.mass = mass;
    Position = posInit;
    Vitesse = vitesseInit;
    Acceleration = force;
    Acceleration.Divide(mass); // somme(force) = m*a donc a = somme(force)/m or une seule force donc a = force/m
  }
  
  float getInvMass(){
    return(1/mass);
  }
  
  void setMass(float invMass){
    mass = 1/invMass;
  }
  
  void Integrer(float temps){
    Position.x += Vitesse.x*temps+Acceleration.x*temps*temps*0.5;
    Position.y += Vitesse.y*temps+Acceleration.y*temps*temps*0.5;
    Position.z += Vitesse.z*temps+Acceleration.z*temps*temps*0.5; //Vitesse.z pas .x
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
    if (0 < Position.x && Position.x < width && 0 < Position.y && Position.y < height){
      pushMatrix();
      translate(Position.x, Position.y, Position.z);
      fill(0);
      sphere(5);
//  ellipse(0, 0, 10, 10);
      popMatrix();
    }
  }
}
