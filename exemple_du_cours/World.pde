class World{
  Particule[] WorldParticule;
  Vecteur3D groundDimensions = new Vecteur3D(200,10,400);
  
  void display(){
    pushMatrix();
    translate(width/2, height, -100);
    fill(color(60,255,60));
    box(width*3,10,500);
    popMatrix();
  }
}
