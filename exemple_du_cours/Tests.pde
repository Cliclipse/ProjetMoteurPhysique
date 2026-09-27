void lancerTests(){
  int nbEchecs = 0;
  Vecteur3D vec1 = new Vecteur3D(3,4,0);
  Vecteur3D vec2 = new Vecteur3D(1,-5,6.3);
  Vecteur3D vec3 = new Vecteur3D(-3,2,7);
  Vecteur3D vec4 = new Vecteur3D(0,8.5,6);
  Vecteur3D vec5 = new Vecteur3D(28,-21,18);
  
  if (!vec1.Egal(new Vecteur3D(3.0,4,0.0))){
    nbEchecs++;
    print("test 0 echoué \n");
  }
  
  vec2.Add(vec3);
  if(!vec2.Egal(new Vecteur3D(-2,-3,13.3))){
    nbEchecs++;
    print("test 1 echoué \n");
  }
  vec2.Substract(vec3);
  if(!vec2.Egal(new Vecteur3D(1,-5,6.3))){
    nbEchecs++;
    print("test 2 echoué \n");
  }
  vec4.Multiply(2.5);
  if(!vec4.Egal(new Vecteur3D(0,21.25,15))){
    nbEchecs++;
    print("test 3 echoué \n");
  }
  vec4.Divide(2.5);
  if(!vec4.Egal(new Vecteur3D(0,8.5,6))){
    nbEchecs++;
    print("test 4 echoué \n");
  }
  if(vec3.ProdScalaire(vec4) != 59){
    nbEchecs++;
    print("test 5 echoué \n");
  }
  if(!vec1.ProdVectoriel(vec3).Egal(vec5)){
    nbEchecs++;
    print("test 6 echoué \n");
  }
  if(abs(vec1.Norme() - 5) > 0.0001){
    nbEchecs++;
    print("test 7 echoué \n");
  }
  vec5.Normalised();
  if(abs(vec5.Norme() - 1) > 0.001){
    nbEchecs++;
    print("test 8 echoué \n");
  }
  print(nbEchecs + " test(s) unitaire(s) échoué(s)\n");
}
