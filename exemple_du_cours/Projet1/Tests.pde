void lancerTests(){
  testVecteur3D();
  testMatrix3();
  testMatrix4();
  testQuaternion();
}

void testVecteur3D(){
  int nbEchecs = 0;
  Vecteur3D vec1 = new Vecteur3D(3,4,0);
  Vecteur3D vec2 = new Vecteur3D(1,-5,6.3);
  Vecteur3D vec3 = new Vecteur3D(-3,2,7);
  Vecteur3D vec4 = new Vecteur3D(0,8.5,6);
  Vecteur3D vec5 = new Vecteur3D(28,-21,18);
  
  if (!vec1.Egal(new Vecteur3D(3.0,4,0.0))){
    nbEchecs++;
    print("test Vecteur3D 0 echoué \n");
  }
  
  vec2.Add(vec3);
  if(!vec2.Egal(new Vecteur3D(-2,-3,13.3))){
    nbEchecs++;
    print("test Vecteur3D 1 echoué \n");
  }
  vec2.Substract(vec3);
  if(!vec2.Egal(new Vecteur3D(1,-5,6.3))){
    nbEchecs++;
    print("test Vecteur3D 2 echoué \n");
  }
  vec4.Multiply(2.5);
  if(!vec4.Egal(new Vecteur3D(0,21.25,15))){
    nbEchecs++;
    print("test Vecteur3D 3 echoué \n");
  }
  vec4.Divide(2.5);
  if(!vec4.Egal(new Vecteur3D(0,8.5,6))){
    nbEchecs++;
    print("test Vecteur3D 4 echoué \n");
  }
  if(vec3.ProdScalaire(vec4) != 59){
    nbEchecs++;
    print("test Vecteur3D 5 echoué \n");
  }
  if(!vec1.ProdVectoriel(vec3).Egal(vec5)){
    nbEchecs++;
    print("test Vecteur3D 6 echoué \n");
  }
  if(abs(vec1.Norme() - 5) > 0.0001){
    nbEchecs++;
    print("test Vecteur3D 7 echoué \n");
  }
  vec5.Normalised();
  if(abs(vec5.Norme() - 1) > 0.001){
    nbEchecs++;
    print("test Vecteur3D 8 echoué \n");
  }
  print(nbEchecs + " test(s) Vecteur3D échoué(s)\n");
}

boolean egalTab(float[] a, float[] b){
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++){
    if (abs(a[i] - b[i]) > 0.0001) return false;
  }
  return true;
}

void testMatrix3(){
  int nbEchecs = 0;
  Matrix3 A = new Matrix3(new float[]{1, 2, 3,
                                      0, 1, 4,
                                      5, 6, 0});//det = 1
  Matrix3 B = new Matrix3(new float[]{-1, 0, 2,
                                       3, 1, 0,
                                       0, 2, 1});
  Matrix3 I = new Matrix3(new float[]{1, 0, 0,
                                      0, 1, 0,
                                      0, 0, 1});
  Matrix3 S = new Matrix3(new float[]{1, 2, 3,
                                      2, 4, 6,
                                      1, 1, 1}); //det = 0
  Matrix3 R = new Matrix3(new float[]{0, -1, 0,
                                      1, 0, 0,
                                      0, 0, 1}); //rotation

  if(!egalTab(A.GetAdd(B).contenu, new float[]{0, 2, 5,
                                               3, 2, 4,
                                               5, 8, 1})){
    nbEchecs++;
    print("test Matrix3 0 echoué \n");
  }
  if(!egalTab(A.contenu, new float[]{1, 2, 3,
                                     0, 1, 4,
                                     5, 6, 0})){ // A non modifiée par GetAdd
    nbEchecs++;
    print("test Matrix3 1 echoué \n");
  }
  if(!egalTab(A.GetProdCoef(2).contenu, new float[]{2, 4, 6,
                                                    0, 2, 8,
                                                    10,12,0})){
    nbEchecs++;
    print("test Matrix3 2 echoué \n");
  }
  if(!egalTab(A.GetProduct(B).contenu, new float[]{5, 8, 5,
                                                   3, 9, 4,
                                                   13,6,10})){
    nbEchecs++;
    print("test Matrix3 3 echoué \n");
  }
  if(abs(A.GetDet() - 1) > 0.0001){
    nbEchecs++;
    print("test Matrix3 4 echoué \n");
  }
  if(!egalTab(A.InvMat().contenu, new float[]{-24,18, 5,
                                              20,-15,-4,
                                              -5, 4, 1})){
    nbEchecs++;
    print("test Matrix3 5 echoué \n");
  }
  if(!egalTab(A.GetProduct(A.InvMat()).contenu, I.contenu)){
    nbEchecs++;
    print("test Matrix3 6 echoué \n");
  }
  if(S.InvMat() != null){
    nbEchecs++;
    print("test Matrix3 7 echoué \n");
  }
  if(!egalTab(A.Transpose().contenu, new float[]{1, 0, 5,
                                                 2, 1, 6,
                                                 3, 4, 0})){
    nbEchecs++;
    print("test Matrix3 8 echoué \n");
  }
  if(!A.Mv(new Vecteur3D(1,1,1)).Egal(new Vecteur3D(6,5,11))){
    nbEchecs++;
    print("test Matrix3 9 echoué \n");
  }
  if(!R.Mv(new Vecteur3D(1,0,0)).Egal(new Vecteur3D(0,1,0))){
    nbEchecs++;
    print("test Matrix3 10 echoué \n");
  }
  if(abs(R.GetDet() - 1) > 0.0001 || !egalTab(R.Transpose().contenu, R.InvMat().contenu)){
    nbEchecs++;
    print("test Matrix3 11 echoué \n");
  }
  print(nbEchecs + " test(s) Matrix3 échoué(s)\n");
}

void testMatrix4(){
  int nbEchecs = 0;
  Matrix4 T = new Matrix4(new float[]{1, 2, 3, 4,
                                      0, 1, 4, 5,
                                      5, 6, 0, 6});
  Matrix4 U = new Matrix4(new float[]{-1, 0, 2, 1,
                                       3, 1, 0, 2,
                                       0, 2, 1, 3});
  Matrix4 translation = new Matrix4(new float[]{1, 0, 0, 10,
                                                0, 1, 0, 20,
                                                0, 0, 1, 30});
  float[] I = {1, 0, 0, 0,
               0, 1, 0, 0,
               0, 0, 1, 0};
  Vecteur3D p = new Vecteur3D(2,-1,3);

  if(!egalTab(T.GetProduct(U).contenu, new float[]{5, 8, 5, 18,
                                                   3, 9, 4, 19,
                                                   13,6,10, 23})){
    nbEchecs++;
    print("test Matrix4 0 echoué \n");
  }
  if(!egalTab(T.contenu, new float[]{1, 2, 3, 4,
                                     0, 1, 4, 5,
                                     5, 6, 0, 6})){ // T non modifiée par GetProduct
    nbEchecs++;
    print("test Matrix4 1 echoué \n");
  }
  if(abs(T.GetDet() - 1) > 0.0001){
    nbEchecs++;
    print("test Matrix4 2 echoué \n");
  }
  if(!egalTab(T.GetProduct(T.InvMat()).contenu, I)){
    nbEchecs++;
    print("test Matrix4 3 echoué \n");
  }
  if(!T.Mv(new Vecteur3D(1,1,1)).Egal(new Vecteur3D(10,10,17))){
    nbEchecs++;
    print("test Matrix4 4 echoué \n");
  }
  if(!T.InvMat().Mv(T.Mv(p)).Egal(p)){
    nbEchecs++;
    print("test Matrix4 5 echoué \n");
  }
  if(!translation.Mv(new Vecteur3D(1,2,3)).Egal(new Vecteur3D(11,22,33))){
    nbEchecs++;
    print("test Matrix4 6 echoué \n");
  }
  print(nbEchecs + " test(s) Matrix4 échoué(s)\n");
}

boolean egalQuat(Quaternion a, Quaternion b){
  return abs(a.r - b.r) < 0.0001 && abs(a.i - b.i) < 0.0001 && abs(a.j - b.j) < 0.0001 && abs(a.k - b.k) < 0.0001;
}

void testQuaternion(){
  int nbEchecs = 0;

  Quaternion a = new Quaternion(1,2,3,4);
  
  if(!egalQuat(a.MultiplyAndGet(new Quaternion(5,6,7,8)), new Quaternion(-60,12,30,24)) || !egalQuat(a, new Quaternion(1,2,3,4))){
    nbEchecs++;
    print("test Quaternion 0 echoué \n");
  }
  
  if(!egalQuat(new Quaternion(0,1,0,0).MultiplyAndGet(new Quaternion(0,0,1,0)), new Quaternion(0,0,0,1))){ // i * j = k
    nbEchecs++;
    print("test Quaternion 1 echoué \n");
  }
  if(!egalQuat(new Quaternion(0,0,1,0).MultiplyAndGet(new Quaternion(0,1,0,0)), new Quaternion(0,0,0,-1))){ // j * i = -k
    nbEchecs++;
    print("test Quaternion 2 echoué \n");
  }
  
  a = new Quaternion(1,2,3,4);
  if(!egalQuat(a.AddAndGet(new Quaternion(5,6,7,8)), new Quaternion(6,8,10,12)) || !egalQuat(a, new Quaternion(1,2,3,4))){
    nbEchecs++;
    print("test Quaternion 3 echoué \n");
  }
  
  a = new Quaternion(1,2,3,4);
  if(!egalQuat(a.SubAndGet(new Quaternion(5,6,7,8)), new Quaternion(-4,-4,-4,-4)) || !egalQuat(a, new Quaternion(1,2,3,4))){
    nbEchecs++;
    print("test Quaternion 4 echoué \n");
  }
  
  a = new Quaternion(1,2,3,4);
  if(!egalQuat(a.GetConjugate(), new Quaternion(1,-2,-3,-4)) || !egalQuat(a, new Quaternion(1,2,3,4))){
    nbEchecs++;
    print("test Quaternion 5 echoué \n");
  }
  
  a = new Quaternion(1,2,3,4);
  Quaternion a2 = a.ScalMultiplyAndGet(2);
  if(!egalQuat(a2, new Quaternion(2,4,6,8)) || !egalQuat(a, new Quaternion(1,2,3,4))){
    nbEchecs++;
    print("test Quaternion 6 echoué \n");
  }
  
  a = new Quaternion(1,2,3,4);
  a2 = a.ScalDivideAndGet(2);
  if(!egalQuat(a2, new Quaternion(0.5,1,1.5,2)) || !egalQuat(a, new Quaternion(1,2,3,4))){
    nbEchecs++;
    print("test Quaternion 7 echoué \n");
  }
  
  a = new Quaternion(1,2,3,4);
  if(abs(a.GetNorme() - sqrt(30)) > 0.0001 || !egalQuat(a, new Quaternion(1,2,3,4))){
    nbEchecs++;
    print("test Quaternion 8 echoué \n");
  }
  
  a = new Quaternion(1,2,3,4);
  Quaternion aN = a.GetNormalize();
  if(abs(aN.GetNorme() - 1) > 0.0001 || !egalQuat(a, new Quaternion(1,2,3,4))){
    nbEchecs++;
    print("test Quaternion 9 echoué \n");
  }
  
  a = new Quaternion(1,2,3,4);
  if(!egalQuat(a.MultiplyAndGet(a.GetInverse()), new Quaternion(1,0,0,0)) || !egalQuat(a, new Quaternion(1,2,3,4))){
    nbEchecs++;
    print("test Quaternion 10 echoué \n");
  }

  float c45 = cos(QUARTER_PI);
  Quaternion rz90 = new Vecteur3D(0,0,1).GetRotationQuaternion(HALF_PI);
  if(!egalQuat(rz90, new Quaternion(c45, 0, 0, c45))){//cos(45) = sin(45)
    nbEchecs++;
    print("test Quaternion 11 echoué \n");
  }
  if(abs(new Vecteur3D(0,0,2).GetRotationQuaternion(HALF_PI).GetNorme() - 1) > 0.0001){ // rotation norme 1
    nbEchecs++;
    print("test Quaternion 12 echoué \n");
  }
  if(!rz90.RotateVecteurAndGet(new Vecteur3D(1,0,0)).Egal(new Vecteur3D(0,1,0))){
    nbEchecs++;
    print("test Quaternion 13 echoué \n");
  }
  Quaternion q120 = new Quaternion(0.5, 0.5, 0.5, 0.5); // exemple du cours 120°
  if(!q120.RotateVecteurAndGet(new Vecteur3D(1,0,0)).Egal(new Vecteur3D(0,1,0)) ||
     !q120.RotateVecteurAndGet(new Vecteur3D(0,1,0)).Egal(new Vecteur3D(0,0,1))){
    nbEchecs++;
    print("test Quaternion 14 echoué \n");
  }
  if(!rz90.MultiplyAndGet(rz90).RotateVecteurAndGet(new Vecteur3D(1,0,0)).Egal(new Vecteur3D(-1,0,0))){
    nbEchecs++;
    print("test Quaternion 15 echoué \n");
  }
  Vecteur3D v = new Vecteur3D(0.3, -2, 5);
  if(!q120.GetMatrix3WithQuaternion().Mv(v).Egal(q120.RotateVecteurAndGet(v))){ //la rotation reste la même
    nbEchecs++;
    print("test Quaternion 16 echoué \n");
  }


  rz90 = new Vecteur3D(0,0,1).GetRotationQuaternion(HALF_PI);
  Quaternion q0 = new Quaternion(1,0,0,0);
  if(!egalQuat(q0.SLerp(rz90, 0), q0)){
    nbEchecs++;
    print("test Quaternion 17 echoué \n");
  }
  if(!egalQuat(q0.SLerp(rz90, 1), rz90)){
    nbEchecs++;
    print("test Quaternion 18 echoué \n");
  }
  if(!egalQuat(q0.SLerp(rz90, 0.5), new Vecteur3D(0,0,1).GetRotationQuaternion(QUARTER_PI))){
    nbEchecs++;
    print("test Quaternion 19 echoué \n");
  }

  if(abs(new Quaternion(1,2,3,4).GetProdScal(new Quaternion(5,6,7,8)) - 70) > 0.0001){
    nbEchecs++;
    print("test Quaternion 20 echoué \n");
  }
  print(nbEchecs + " test(s) Quaternion échoué(s)\n");
}
