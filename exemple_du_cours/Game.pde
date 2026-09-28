ArrayList<Particule> bullets;
Particule target;
Particule player;
int bulletType = 0;
float dt; // duree de la frame
int timeLastFrame; //temps actuel
float damping = 0.95;
UI ui;
float gravity = 9.8;

int score = 0;
int essais = 3;
boolean gameOver = false;
boolean aNettoyer = true;
boolean afficherFrame = false;

color[] couleurs = {
  color(255, 220, 0),
  color(220, 0, 0),
  color(0, 170, 0),
  color(0)
};

float rayonType() {
  return 2*bulletType + 5;
}

void setup() {
  lancerTests();
  size(1280, 720, P3D);
  noStroke();
  bullets = new ArrayList<Particule>();
  player = new Particule(10.0, new Vecteur3D(width*0.5,height*0.5,0), new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
  player.rayon = rayonType();
  player.couleur = couleurs[bulletType];
  nouvelleCible();
  timeLastFrame = millis();
  background(102);
  ui = new UI(this);
  ui.setupUI();
}

void mousePressed() {
  if (ui.cp5.isMouseOver() || gameOver) return;
  if (mouseButton == LEFT && essais > 0){
    float coefVitesse = 30 * (4-bulletType);// coef arbitraire * scale
    Vecteur3D v0 = new Vecteur3D(mouseX,mouseY,0);
    v0.Substract(player.Position);
    v0.Normalised();
    v0.Multiply(coefVitesse);
    Vecteur3D pos0 = new Vecteur3D(player.Position.x,player.Position.y,player.Position.z);
    float masse = 10.0 * (bulletType+1);
    Vecteur3D force = new Vecteur3D(0,gravity,0); //y vertical et vers le bas -> g selon y et positif ?
    force.Multiply(masse);
    Particule p = new Particule(masse, pos0, v0, force);
    p.rayon = rayonType();
    p.couleur = couleurs[bulletType];
    bullets.add(p);
    essais--;
  }
  else if (mouseButton == RIGHT && essais == 3){
    bulletType = (bulletType+1) % 4;
    player.rayon = rayonType();
    player.couleur = couleurs[bulletType];
    background(102);
  }
}

void keyPressed() {
  if (key == ' ') {
    afficherFrame = !afficherFrame;  
  }
  if ((key == 'r' || key == 'R') && gameOver) {
    score = 0;
    essais = 3;
    gameOver = false;
    bullets.clear();
    nouvelleCible();
    aNettoyer = true;
  }
}

void nouvelleCible() {
  Vecteur3D pos;
  do {
    pos = new Vecteur3D(random(40, width-40), random(40, height-40), 0);
    pos.Substract(player.Position);
    } while (pos.Norme() < 150);
  pos.Add(player.Position);
  target = new Particule(1.0, pos, new Vecteur3D(0,0,0), new Vecteur3D(0,0,0));
  target.rayon = 20;
  target.couleur = color(127,0,0);
}

void cibleTouchee() {
  score += 100 * (bulletType + 1);
  essais = 3;
  bullets.clear();
  nouvelleCible();
  aNettoyer = true;
}

void afficherHUD() {
  
  fill(102);
  rect(width-270, 10, 260, 85);
  fill(255);
  textSize(16);
  text("Score : " + score, width-260, 35);
  text("Essais restants : " + essais, width-260, 60);
  if(afficherFrame){
    text("Durée frame : " + nf(dt * 1000, 0, 1) + " ms", width-260, 85);
  }
  if (gameOver) {
    textSize(48);
    textAlign(CENTER);
    text("GAME OVER", width/2, height/2 - 60);
    textSize(20);
    text("Score : " + score + "  -  R pour rejouer", width/2, height/2 + 60);
    textAlign(LEFT);
  }

}

void draw() {
  if (aNettoyer) {
    background(102);
    aNettoyer = false;
  }
  player.Position.x = width*0.5;
  player.Position.y = height*0.5;
  player.display();
  target.display();
  dt = (millis() - timeLastFrame)*0.001; // millisecondes -> secondes
  timeLastFrame = millis();
  for (int i = bullets.size()-1; i>=0; i--){ 
    Particule p = bullets.get(i);
    p.update(dt);
    p.display();
    if (p.touche(target)) {
      cibleTouchee();
      break;
    }
    if (aNettoyer || 0 > p.Position.x || p.Position.x > width || 0 > p.Position.y || p.Position.y > height) {
      bullets.remove(i);
    }
  }
  if (essais <= 0 && bullets.size() <= 0) {
    gameOver = true;
    aNettoyer = true;
  }
  
  afficherHUD();
}
