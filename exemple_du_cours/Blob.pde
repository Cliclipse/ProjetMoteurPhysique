class Blob{
  Particule[] membre;
  int nbMembre;
  int indexMasterParticule;
  float masterparticuleSpeed;
  
  //Ressort[] muscle;
  
  //Fonction qui apply la physique pour chaque particule du blob
  public void ApplyPhysic(){
    for(int i = 0 ; i <nbMembre ; i++); //membre[i].calculForce();
  }
  
  public void Move(char keyPressed)
  {
    print("test\n");
    print(keyPressed);
    
   
  }

}
