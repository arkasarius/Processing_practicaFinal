class Alex extends Animacio {
 float t=0; 
 int m=0; 
  
 Alex(String nameSong){
  super(nameSong);
  reset();
  song.play();
 }
  
 void reset(){

 }
 
 void display(){
  background(125);
  stroke(0);
  for(int i = 0; i < song.bufferSize() - 1; i+=32)
  {
    float a = i*TWO_PI/song.bufferSize();
    float a2 = (i+31)*TWO_PI/song.bufferSize();
    float r = 100+ song.right.get(i)*200;
   pushMatrix();
   //fill(100);
   translate(width/2,height/2);
   beginShape();
       //add some vertices...
       for(float theta = 0; theta <= 2 * PI; theta += 0.01){
          float rad = r(theta,
          r/10 , //a --size
          r/10 , //b --size
          a2/10, //m --spikes
          1, //n1
          sin(t) * 0.5 + 0.5, //n2
          cos(t) * 0.5 + 0.5 //n3
          );
          float x = rad * cos(theta) * 50;
          float y = rad * sin(theta) * 50;
          vertex(x,y);
       }
       t+=0.005;
   endShape(); 
   popMatrix();
   fill(255);
   arc(width/2,height/2,2*r,2*r,a, a2);
   noFill();
  }
 }
 float r(float theta, float a, float b, float m, float n1, float n2, float n3){
   return pow(pow(abs(cos(m * theta/4.0)/a), n2) + pow(abs(sin(m * theta/4.0)/b), n3), -1.0/n1); 
 }
}
