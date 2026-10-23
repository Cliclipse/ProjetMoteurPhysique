abstract class ForceGenerator{
  abstract void updateforce(Particule particule , float duration);
}

class particuleForceRegistry{
  class ParticuleForceRegistration{
    
    ParticuleForceRegistration(Particule particule, ForceGenerator fg){
      this.particule = particule;
      this.fg = fg;
    }
    
    Particule particule;
    ForceGenerator fg;
  }
 
  ArrayList<ParticuleForceRegistration> Registre = new ArrayList<ParticuleForceRegistration>();
  void Add(Particule particule, ForceGenerator fg){
    Registre.add(new ParticuleForceRegistration(particule, fg));
  }
  void Remove(Particule particule, ForceGenerator fg){
    Registre.remove(new ParticuleForceRegistration(particule, fg));
  }
  void UpdateForces(float duration){
    for(ParticuleForceRegistration r : Registre){
      r.fg.updateforce(r.particule,duration);
    }
  }
}

class ParticuleGravity extends ForceGenerator{
  Vecteur3D gravity = new Vecteur3D(0,-9.81,0);
  
  void updateforce(Particule particule, float duration){
    gravity.Multiply(particule.getMass());
    particule.AddForce(gravity);
  }
}

//TODO: Implémenter les différents ressorts : Bungee, particule-particule, point-particule
class ParticuleRessort extends ForceGenerator
{
  float k;
  float l0;
  Vecteur3D o;
  
  ParticuleRessort(float k, float l0, Vecteur3D o){
    this.k = k;
    this.o = o;
    this.l0  = l0;
  }
  
  void updateforce(Particule particule, float duration){
    Vecteur3D l = particule.Position;
    l.Substract(o);
    
    Vecteur3D dir = l;
    dir.Normalised();
    dir.Multiply(k*(l0 - l.Norme()));
    particule.AddForce(dir);
  }
}

//TODO: Je comprend pas non plus quoi faire de K1 et K2
class ParticuleFriction extends ForceGenerator
{
  float K1;
  float K2;
  void updateforce(Particule particule, float duration){
    Vecteur3D friction = particule.Vitesse;
    friction.Normalised();
    friction.Multiply(K1*particule.Vitesse.Norme() + K2*particule.Vitesse.Norme());
  }
}
