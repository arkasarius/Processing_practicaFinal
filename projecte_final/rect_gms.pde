class rectt{
  float d=75, g=0;
  int x,y;
  rectt(int p){
    rectMode(CENTER);
    noFill();
    switch(p){
      case 1: x=width/2;
              y=height/4;
              break;
      case 2: x=(width/4)*3;
              y=height/2;
              break;
      case 3: x=width/2;
              y=(height/4)*3;
              break;
      case 4: x=width/4;
              y=height/2;
              break;
    }
  }
  
  void rectP(){
    stroke(255);
    strokeWeight(3);
    pushMatrix();
    translate(x,y);
    rotate(g);
    rect(0,0,150,150);
    g+=0.05;
    popMatrix();
  }
  
  void drawextra(){
    for(int i=0; i<6;i++){
      d+=50;
      g+=0.05;
      
      stroke(255);
      strokeWeight(3);
      pushMatrix();
      translate(x,y);
      rotate(g);
      rect(0,0,d,d);
      popMatrix();
    }
    d=150;
    g=0;
  }
}
////////////////////////////////////////////////////////////////////////////////////////////
class elli{
  float d;
  int v, t;
  color c;
  float sw;
  
  elli(int n){
    noFill();
    t =(int)random(153,256);
    v =(int)random(2);
    if(v==0){
      c= color(255,255,255,t);
    } else{
      c= color(25,149,247,t);
    }
    
    sw=random(1,5);
    d=random(5,10)*n;
  }
  
  void drawelli(){
    stroke(c);
    strokeWeight(sw);
    ellipse(width/2, height/2,d,d);
  }
}
////////////////////////////////////////////////////////////////////////////////////////
class linemove{
 float x,y,y2,v1,v2;
 
 linemove(){
   x=random(0,width);
   y=random(height/5,height/2);
   v1=1;
   v2=-1;
   y2=height/2+(height/2-y);
 }
 
 void drawlinemove(){
   stroke(255);
   strokeWeight(10);
   y=y+v1;
   y2=y2+v2;
   if(y>=height/2){
     v1=-1;
     v2=1;
   }
   if(y<=height/4){
     v1=1;
     v2=-1;
   }
   
   line(x,y,x,y2);
 }
}
////////////////////////////////////////////////////////////////////////////////////////
class linetrans{
 float x,y1,y2,t,v;
 
 linetrans(){
   x=random(0,width);
   y1=random(0,height/2);
   y2=random(height/2,height);
   t=0;
   v=1;
 }
 
 void drawlinetrans(){
   strokeWeight(10);
   stroke(25,149,247,t);
   t=t+v;
   if(t>=255){
     v=-2;
   }
   if(t<=0){
     v=2;
   }
   line(x,y1,x,y2);
 }
}
