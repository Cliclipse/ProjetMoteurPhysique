class Particule {
  Vecteur3D Position;
  Vecteur3D Vitesse;
  Vecteur3D Acceleration;
  float inverseMass;
  float rayon = 5;
  int couleur = color(0);
  boolean isInBlob = false;
  Vecteur3D AccumForce = new Vecteur3D(0,0,0);
  
  Particule(float invMass, Vecteur3D posInit, Vecteur3D vitesseInit, Vecteur3D force){
    this.inverseMass = invMass;
    Position = posInit;
    Vitesse = vitesseInit;
    Acceleration = new Vecteur3D(force.x, force.y, force.z);
    Acceleration.Multiply(invMass); // somme(force) = m*a donc a = somme(force)/m or une seule force donc a = force/m
  }
  
  float getInvMass(){
    return(inverseMass);
  }
  
  void setInvMass(float invMass){
    inverseMass = invMass;
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
    Acceleration = AccumForce.GetMultiply(inverseMass);
    clearAccum();
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
  
  // Partie 2
  //Vecteur3D AccumForce;
  
  public float getMass(){
    return (1/inverseMass);
  }

  public float getInverseMass(){
    return inverseMass;
  }
  void AddForce(Vecteur3D force){
    AccumForce.Add(force); 
  }

  
  void clearAccum(){
    AccumForce.Reset();
  }
  
  void SetColor(color colorPart){
    couleur = colorPart; 
  }
  
  void SetRayon(float rayonPart){
    rayon = rayonPart; 
  }
  
  void detectCollisions(float dframe, World w, ParticuleGravity Pg, Blob b, ArrayList<Contact> liens){
    int n = w.WorldParticule.length;
    float e = 0.5; // coefficient de restitution

    ArrayList<Contact> contacts = new ArrayList<Contact>();

    // Sphères : interpénétrations
    for(int i = 0; i < n; i++){
      Particule pi = w.WorldParticule[i];
      for(int j = 0; j < i; j++){
        Particule pj = w.WorldParticule[j];
        if(pi.touche(pj)){
          /*if(pi.isInBlob && pj.isInBlob) {
            continue; // pas de collision dans le blob
          }*/
          if(pi.isInBlob != pj.isInBlob){
            Particule libre  = pi.isInBlob ? pj : pi;
            Particule membre = pi.isInBlob ? pi : pj;
            libre.Vitesse = new Vecteur3D(membre.Vitesse.x, membre.Vitesse.y, membre.Vitesse.z);
            b.AddParticule(libre);
          }
          contacts.add(new Contact(pi, pj, 0, 0, e));
        }
      }
    }

    // Câbles et tiges
    for(Contact c : liens){
      if(c.type == 1 && c.penetration() <= 0) continue; // câble détendu : aucun effet
      contacts.add(c);
    }
    
    // Sol
    for(int i = 0; i < n; i++){
      Particule p = w.WorldParticule[i];
      if(p.Position.y + p.rayon >= w.sol.Position.y){
        contacts.add(new Contact(p, w.sol, 3, 0, 0.3));
      }
    }

    //on résout les 2n contacts les plus "important" (vitesse relative plus grande)
    int maxIter = 2 * contacts.size();
    for(int it = 0; it < maxIter; it++){
      Contact pire = null;
      float pireVn = 0;
      float pirePen = 0;
      for(Contact c : contacts){
        float vn = vitesseRapprochement(c);
        float pen = c.penetration();
        if(c.type == 1 && pen < 0) continue; // câble détendu
        if(vn > 0 || pen > 0.01){
          // priorité : plus grande vitesse relative, puis plus grande pénétration
          if(pire == null || vn > pireVn || (vn == pireVn && pen > pirePen)){
            pire = c;
            pireVn = vn;
            pirePen = pen;
          }
        }
      }
      if(pire == null) break;
      resoudreContact(pire, dframe, Pg);
    }
  }

  //Vitesse relative selon la normale
  float vitesseRapprochement(Contact c){
    Vecteur3D vRel = new Vecteur3D(c.a.Vitesse.x - c.b.Vitesse.x, c.a.Vitesse.y - c.b.Vitesse.y, c.a.Vitesse.z - c.b.Vitesse.z);
    return vRel.ProdScalaire(c.normale());
  }

  void resoudreContact(Contact c, float dframe, ParticuleGravity Pg){
    Particule a = c.a;
    Particule b = c.b;
    float sommeInv = a.inverseMass + b.inverseMass;
    if(sommeInv <= 0) return; //masses infinies
    if(c.type == 1 && c.penetration() < 0) return; // câble détendu : aucun effet
    Vecteur3D nrm = c.normale();

    //Impulsion
     Vecteur3D vRel = new Vecteur3D(a.Vitesse.x - b.Vitesse.x, a.Vitesse.y - b.Vitesse.y, a.Vitesse.z - b.Vitesse.z);
    float vn = vRel.ProdScalaire(nrm);
    if(vn > 0){

      float vGravite = abs(Pg.gravity.ProdScalaire(nrm)) * dframe;
      float eContact = (vn <= vGravite) ? 0 : c.e; //0 : contact au repos

      float K = (eContact + 1) * vn / sommeInv;

      // variations vitesse
      Vecteur3D dvA = new Vecteur3D(nrm.x, nrm.y, nrm.z);
      dvA.Multiply(-K * a.inverseMass);
      a.Vitesse.Add(dvA);
      Vecteur3D dvB = new Vecteur3D(nrm.x, nrm.y, nrm.z);
      dvB.Multiply(K * b.inverseMass);
      b.Vitesse.Add(dvB);
    }

    //Séparation (inversement proportionnelle à la masse)
    float d = c.penetration();
    if(d > 0){
      Vecteur3D dpA = new Vecteur3D(nrm.x, nrm.y, nrm.z);
      dpA.Multiply(-d * a.inverseMass / sommeInv);
      a.Position.Add(dpA);
      Vecteur3D dpB = new Vecteur3D(nrm.x, nrm.y, nrm.z);
      dpB.Multiply(d * b.inverseMass / sommeInv);
      b.Position.Add(dpB);
    }
  }
  
  boolean toucheSol(Particule psol){
    return Position.y + rayon >= psol.Position.y - 1;
  }
  
}  
