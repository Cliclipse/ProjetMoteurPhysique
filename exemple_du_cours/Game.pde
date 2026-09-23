ArrayList<Particule> bullets;
int bulletType = 0;
float dt; // duree de la frame
int timeLastFrame; //temps actuel
float damping = 0.95;

void setup() {
  size(1280, 720, P3D);
  noStroke();
  bullets = new ArrayList<Particule>();
  timeLastFrame = millis();
  background(102);
}

void mousePressed() {
  if (mouseButton == LEFT){
    int scale = bulletType + 1;
    float coefVitesse = 0.25 * scale;// coef arbitraire * scale
    Vecteur3D v0 = new Vecteur3D((mouseX-width*0.5) * coefVitesse,(mouseY-height*0.5) * coefVitesse,0);
    Vecteur3D pos0 = new Vecteur3D(width*0.5,height*0.5,0);
    float masse = 10.0 * scale;
    Vecteur3D force = new Vecteur3D(0,10,0); //y vertical et vers le bas -> g selon y et positif ?
    force.Multiply(masse);
    Particule p = new Particule(masse, pos0, v0, force);
    bullets.add(p);
  }
  else if (mouseButton == RIGHT){
    bulletType = (bulletType+1) % 4;
  }
}

void draw() {
  //background(102);
  dt = (millis() - timeLastFrame)*0.001; // millisecondes -> secondes
  timeLastFrame = millis();
  print("duree frame:" + dt + " secondes\n");
  for (int i = bullets.size()-1; i>=0; i--){ 
    Particule p = bullets.get(i);
    p.update(dt);
    p.display();
    if (0 > p.Position.x || p.Position.x > width || 0 > p.Position.y || p.Position.y > height) {
      bullets.remove(i);
    }  
  }
}
