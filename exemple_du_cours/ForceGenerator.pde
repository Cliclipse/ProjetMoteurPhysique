abstract class ForceGenerator{
  abstract void updateforce(Particule particule , float duration);
}

class particuleForceRegistry{
  class ParticuleForceRegistration{
    Particule particule;
    ForceGenerator fg;
  }
 
  ParticuleForceRegistration[] Registre;
}

class ParticuleGravity extends ForceGenerator{
  Vecteur3D gravity = new Vecteur3D(0,-9.81,0);
  
  void updateforce(Particule particule, float duration){
    gravity.Multiply(particule.getMass());
    particule.AddForce(gravity);
  }
}
