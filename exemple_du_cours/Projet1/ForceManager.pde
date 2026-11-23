int rapportPixelMetre = 40; // arbitraire


abstract class ForceManager{
  abstract void updateforce(Particule particule , float duration);
}
  
class particuleForceRegistry{
  class ParticuleForceRegistration{
   
    ParticuleForceRegistration(Particule particule, ForceManager fg){
      this.particule = particule;
      this.fg = fg;
    }
      
    Particule particule;
    ForceManager fg;
  }

  ArrayList<ParticuleForceRegistration> Registre = new ArrayList<ParticuleForceRegistration>();
  void Add(Particule particule, ForceManager fg){
    Registre.add(new ParticuleForceRegistration(particule, fg));
  }
  void Remove(Particule particule, ForceManager fg){
    Registre.remove(new ParticuleForceRegistration(particule, fg));
  }
  void UpdateForces(float duration){
    for(ParticuleForceRegistration r : Registre){
      r.fg.updateforce(r.particule,duration);
    }
  }
}

class ParticuleGravity extends ForceManager{
  Vecteur3D gravity = new Vecteur3D(0, 9.81 * rapportPixelMetre, 0);  
  
  
  void updateforce(Particule particule, float duration){
    Vecteur3D f = new Vecteur3D(gravity.x, gravity.y, gravity.z);
    f.Multiply(particule.getMass());
    particule.AddForce(f);
  }
}
  
//  Vecteur3D CurrentForce;
  
  
//  void AddForceToAccumulator(){
//  }
  
//  void ResetForce(){
//  }
//}
