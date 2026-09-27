import controlP5.*; //Y'a une librairie qui existe pour ça


class UI {
  int ySliderDamping = 20;
  int xSliderDamping = 50;
  
  int ySliderGravity = 50;
  int xSliderGravity = 50;
  
  int size;
  
  ControlP5 cp5;
  PApplet sketch; // le sketch, me faut ça pour initialiser le slider
   
   UI(PApplet p) {
    sketch = p;
  }
   

void setupUI(){
  cp5 = new ControlP5(sketch);
  cp5.addSlider("damping").setPosition(xSliderDamping, ySliderDamping).setRange(0, 1).setSize(200, 20).setValue(0.95); // valeur par défaut;
  cp5.addSlider("gravity").setPosition(xSliderGravity, ySliderGravity).setRange(0, 30).setSize(200, 20).setValue(9.8); 

}
  
}
