class Contact {
  Particule a, b;
  int type;        // 0: classique, 1: câble, 2: tige, 3: sol
  float longueur;  // L (câble ou tige)
  float e;  // coefficient de restitution

  Contact(Particule a, Particule b, int type, float longueur, float e){
    this.a = a;
    this.b = b;
    this.type = type;
    this.longueur = longueur;
    this.e = (type == 2) ? 0 : e; // tige: inelastique
  }

  float dist(){
    Vecteur3D d = new Vecteur3D(b.Position.x - a.Position.x, b.Position.y - a.Position.y, b.Position.z - a.Position.z);
    return d.Norme();
  }

  Vecteur3D normale(){
    if (type == 3){
      return new Vecteur3D(0, 1, 0); // normale vers le sol
    }
    Vecteur3D n = new Vecteur3D(b.Position.x - a.Position.x, b.Position.y - a.Position.y, b.Position.z - a.Position.z);
    if (n.Norme() < 0.0001){
      // centres confondus, on prend une direction aleatoire pour la séparation
      Vecteur3D r = new Vecteur3D(random(-1, 1), random(-1, 1), random(-1, 1));
      if (r.Norme() < 0.0001){ //r(0,0,0)
        r = new Vecteur3D(1, 0, 0);
      }
      r.Normalised();
      return r;  
    }
    n.Normalised();
    boolean inverser = (type == 1) || (type == 2 && dist() > longueur); // câble ou tige trop longue
    if (inverser){
      n.Multiply(-1);
    }
    return n;
  }

  float penetration(){
    if (type == 3){ //interpenetration dans le sol
      return (a.Position.y + a.rayon) - b.Position.y;
    }
    float l = dist();
    if (type == 0) {
      return a.rayon + b.rayon - l;
    }
    if (type == 1){
      return l - longueur;   // > 0 si le câble est trop tendu
    }
    return abs(l - longueur); // tige : écart à la longueur fixe
  }
}
