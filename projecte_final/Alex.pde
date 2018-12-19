class Alex extends Animacio {
float rWidth, rHeight;
int seleccio, w;
PImage fade;
  //-------------------------------------
float[] previousValues;
float[] rotation;
PVector[][] prevPos;
PVector[][] prevPosRot;
float totalAvg, rotAngle,scaling,escala;
boolean flag=false;
color c,c1,c2,ca1,cs1;
//------------------------------------
float a;
float giro =random(0, 6.289);  
//-------------------------------------
float j=0,k=0,i=0,num=1;
int escalado,escalado2; 
int tiempo=0;
//-------transicion
int opac=255;
float aTrans = 0.0,aTrans2=0.0;

 Alex(String nameSong){
  super(nameSong);
  reset();
  song.play();
 }
  
 void reset(){
  fft=new FFT(song.bufferSize(), song.sampleRate());
  fft.logAverages(30,7);
  seleccio=0;
  background(0);
  //animacio1-----------------------------------------------------
  fade = get(0, 0, width, height);
  rWidth = width *0.99;
  rHeight = height *0.99;
  //animacio2------------------------------------------------------
  noCursor();
  escala=1.0; 
  prepare();
  c1=color(random(200,255),random(125),125);
  c2 = color(random(0,125),random(125,255),255);
 }
 
 void display(){
 fill(0, 50);
  noStroke();
  rect(0, 0, width, height);
  tiempo=millis();
  
  if(tiempo>90000){
    seleccio=4;
  }else if(tiempo>60000){
    seleccio=3; 
  }else if(tiempo>30000){
    seleccio=2; 
  }else{
   seleccio=1; 
  }
  if(tiempo>27000 && tiempo<32000){
    background(0);
    fade = get(0, 0, width, height);
    image(fade, (width)/2, (height)/2, width, height);
    rotate(aTrans);
    aTrans=aTrans+0.06;
    
  }
  if(tiempo>57000 && tiempo<63050){
    rotate(aTrans2);
    aTrans2=aTrans2-0.045;
  }
  if(tiempo>87000 && tiempo<92000){
    fill(0, opac);
    noStroke();
    rect(0, 0, width, height);
    opac=opac+(255/10);
  }
  switch(seleccio){ 
   case 1:
     animacio1();
     break;
   case 2:
     pushMatrix();
     c = c1;
     translate(-width/3+100,0);
     animacio2();
     popMatrix();
     pushMatrix();
     c = c2;
     translate(width/3-100,0);
     animacio2();
     popMatrix();
     break;
   case 3:
    if(beat.isOnset()){
      translate(width/2,height/2);
     animacio5();
    }else{
     animacio3();
    }
     break;
   case 4:
     animacio4();
     break;
  }
  if(tiempo<6000){
    fill(0, opac);
    noStroke();
    rect(0, 0, width, height);
    opac=opac-255/10;
  }
    if(tiempo>56000 && tiempo<60000){
    fill(0, opac);
    noStroke();
    rect(0, 0, width, height);
    opac=opac+(255/10);
  }
 }
 
 void prepare(){
  scaling = 2.5;
  beat = new BeatDetect();
  previousValues = new float[fft.specSize()/10];
  prevPos = new PVector[previousValues.length][20];
  rotation = new float[previousValues.length];
  prevPosRot = new PVector[2][30];

  background(50);
  fill(0, 50);
  noStroke();
  for (int i = 0; i < 10; i++)
    rect(0, 0, width, height);
 }
 
void animacio1(){  
  w=27;
  strokeWeight(10);
  background(0);
  image(fade, (width - rWidth)/2, (height-rHeight)/2, rWidth, rHeight);
  fft.forward(song.mix);
  ca1=escullColor();
  cs1=escullSColor();
  fill(ca1);
  stroke(cs1);
  int average=fft.avgSize();
  for(int i = 0; i<average; i++){
    float a = i*TWO_PI/average;
    float a2 = (i+31)*TWO_PI/average;
    float r = 150 + song.right.get(i)*150;
   arc(width/2,height/2,2*r,2*r,a, a2-fft.getAvg(i));
  }
  fade = get(0, 0, width, height);
  stroke(255,200);
  for(int i = 0; i<15; i++){
    float a = i*TWO_PI/average;
    float r = 50 + song.right.get(i);
   line(width/2, height/2, r*cos(a), r*sin(a) ); 
  }
}
color escullColor(){
  int scull = (int) random(0,4);
  switch(scull){
   case 1:
     ca1=color(35,184,255);
     break;
   case 2:
     ca1=color(71,232,164);
     break;
   case 3:
     ca1=color(66,255,3);
     break;
   case 4:
     ca1=color(323,219,8);
     break;
   default:
     ca1=color(255,170,2);
     break;
  }
  
  return ca1;
}

color escullSColor(){
  int scull2 = (int) random(0,4);
  switch(scull2){
   case 1:
     cs1=color(109,0,255);
     break;
   case 2:
     cs1=color(71,208,232);
     break;
   case 3:
     cs1=color(19,169,0);
     break;
   case 4:
     cs1=color(232,184,12);
     break;
   default:
     cs1=color(255,135,111);
     break;
  }
  
  return cs1;
}
void animacio2(){
  calculaValors();
  translate(width/2,height/2);
  dibuixaBeat();
}

void calculaValors(){
  fft.forward(song.mix);
  totalAvg = 0;
  int totalCount = 0;
  noStroke();
  fill(120);
  int size = 10;
  for (int n = 0; n < fft.specSize()-size; n += size) {
    float percent = (float)n / (fft.specSize()-size);
    float avg = 0;
    for (int i = n; i < n+size; i++){
      avg += fft.getBand(n);
    }
    avg = avg * lerp(4, 8, percent) * scaling / size;
    float previous = previousValues[n/size];
    previous *= 0.9;
    previous = max(avg, previous);
    previousValues[n/size] = previous;
    totalAvg += previous;
    totalCount++;
  } 
  totalAvg /= totalCount;
}


void dibuixaBeat(){  
  float positionRadius = height*0.20;
  positionRadius *= (1+totalAvg*0.01);
  translate(0, 0);
  rotate(rotAngle);
  translate(-width/2, -height/2);
  noFill();
  noStroke();
  for (int i = 0; i < previousValues.length; i++){ 
    int count = 20;
    float startAngle = (i*PI/100);
    float deltaAngle = PI*2 / count;
    float value = previousValues[i];
    float percent = (float)i/previousValues.length;
    fill(c, 100);
    float s = max(2, value*0.5f*positionRadius/360f);
    float distance = positionRadius-(percent*positionRadius*value/40);
    distance = max(-positionRadius, distance);
    for (int j = 0; j < count; j++){
      float a = startAngle + deltaAngle * j;
      if (j%2 == 0) a -= startAngle*2;
      PVector prev = prevPos[i][j];
      PVector curr = new PVector(width/2 + cos(a) * distance, height/2 + sin(a) * distance);
      if (prev != null){
        float dx = prev.x - curr.x;
        float dy = prev.y - curr.y;
        float d = sqrt(dx*dx + dy*dy);
        pushMatrix();
        translate(curr.x, curr.y);
        rotate(atan2(dy, dx));
        rect(0, -s/2, d, s);
        popMatrix();
      }
      prevPos[i][j] = curr;
    }
  }
}

void animacio3(){ 
  translate(width/2, height/2);
  background(0);
  stroke(143,74,221,50);
  giro=giro+0.007;  
  beat.detect(song.mix);

  rama(130);
  rotate(PI/2);
  rama(130);
}


void rama(float h){
  h = h *0.7;
  if (h > 27) { 
    
    pushMatrix();    
    rotate(giro);  
    line(0, 0, 0, -h*2);  
    translate(0, -h*2); 
    rama(h);     
    popMatrix();  
    
    pushMatrix();
    rotate(-giro);
    stroke(8,162,198,30);
    fill(255);
    ellipse(0,0,5,5);
    line(0, 0, 0, -h*2);
    translate(0, -h*2);
    rama(h);
    popMatrix();
    
    pushMatrix();
    line(0, 0, 0, -h*2);
    translate(0, -h*2);
    rama(h);
    popMatrix();
    
    pushMatrix();    
    rotate(giro);   
    line(0, 0, 0, h*2);  
    translate(0, h*2); 
    rama(h);     
    popMatrix();  
    
    pushMatrix();
    rotate(-giro);
    line(0, 0, 0, h*2);
    translate(0, h*2);
    rama(h);
    popMatrix();
    
    pushMatrix();
    line(0, 0, 0, h*2);
    translate(0, h*2);
    rama(h);
    popMatrix();
  }
  
}

void animacio4(){
  strokeWeight(2);
   fill(0,20);   
  noStroke();
  rect(0, 0, width, height);
  
  beat.detect(song.mix);
    
    
  i = i + .01; 
  j = j + .05; 
  k = k + num; 
  if ((k > 255)||(k < 0)) {
   num = num *-1;
   }
  stroke(50,k,200); 
  float a = map(cos(i+PI/2), -2, 2, 0, width);
  float b = map(sin(i), -2, 2, 0, height);
  float c = map(cos(j), -2, 2, 0, width);
  float d = map(sin(j+PI/2), -2, 2, 0, height);
 
  if ( beat.isOnset() ){
   escalado=1; 
  }
  scale(escalado);
  line(a, b, c, d);
  for(int i=0;i<8;i++){
    translate(width/2-270,height/2-1065);
    rotate(radians(45));
    scale(escalado);
    line(a, b, c, d);
  }
  escalado-=0.0000005;
  if(escalado<0) escalado=0; 
}
void animacio5(){
  giro=giro+0.05;
  beat.detect(song.mix);
  for (int i =0; i <8; i++ ){
  branca(height/4,7);
  rotate(PI/4);
  }
}

void branca(float len, int num){
  len =len/sqrt(2);
  num = num-1;
  if ((len > 1) && (num > 0)){
    pushMatrix();
    rotate(giro);
    stroke(152,247,255);
    strokeWeight(num/4);
    line(0, 0, 0, -len/3);
    translate(0, -len/3);
    branca(len, num);
    popMatrix();
    
    pushMatrix();
    rotate(-giro);
    stroke(152,247,255);
    strokeWeight(num/4);
    line(0, 0, 0, -len);
    translate(0, -len);
    branca(len, num);
    popMatrix();
    
    pushMatrix();
    rotate(-2*giro);
    stroke(152,247,255);
    strokeWeight(num/4);
    line(0, 0, 0, -len/6);
    translate(0, -len/6);
    branca(len, num);
    popMatrix();
  }
  /*void f_keyPressed(){
    if(keyCode==h) c1=color(random(255),random(255),random(255));
    if(keyCode==j) c2=color(random(255),random(255),random(255));
  }*/
}
}
