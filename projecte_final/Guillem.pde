class Guillem extends Animacio{
  float g=0.05, diam=200,x,y;
  ArrayList<Float> diametre;
  boolean p1, p2, p3, p4, p5, p6,p7;
  int j,k;
  rectt[] qw;
  elli[] er;
  linemove[] ty;
  linetrans[] ui;
  
  Guillem(String nameSong) {
    super(nameSong);
    reset();  
    song.play();
    beat = new BeatDetect();
  }
  
  void reset(){
    qw = new rectt[4];
  for (int i=0; i<4; i++) {
    qw[i] = new rectt(i+1);
  }

  er = new elli[250];
  for (int i=0; i<er.length; i++) {
    er[i] = new elli(i+1);
  }
  
  ty = new linemove[30];
  for( int i=0; i<ty.length; i++){
    ty[i]=new linemove();
  }
  
  ui = new linetrans[40];
  for( int i=0; i<ui.length; i++){
    ui[i]=new linetrans();
  }

  diametre = new ArrayList<Float>();
  p1=p2=p3=p4=p5=p6=p7=false;
  background(0);
  }
  
  void display(){
    if(p6==false){
    for (int i=0;i<=500;i++) {
      strokeWeight(1);
      stroke(random(0,255));
      x = random(0,width);
      y = random(0,height);
      line(x,y,x+random(0,100),y);
    }
    strokeWeight(3);
    stroke(0);
    line(0,j,width,j);
    j++;
    if (j>height) {
      j=0;
    }
    strokeWeight(3);
    stroke(0);
    line(0,k,width,k);
    k++;
    if (k>height) {
      k=0;
    }
  } else{
      background(0);
  }
  
  if(p7==true){
    for( int i=0; i<ty.length; i++){
      ty[i].drawlinemove();
    }
  
    for( int i=0; i<ui.length; i++){
      ui[i].drawlinetrans();
    }
  }
  
  if(p5==true){
    for (int i=0; i<er.length; i++) {
      er[i].drawelli();
    }
  }

  if (p1==true) {
    qw[0].rectP();
  }
  if (p2==true) {
    qw[1].rectP();
  }
  if (p3==true) {
    qw[2].rectP();
  }
  if (p4==true) {
    qw[3].rectP();
  }


  pushMatrix();
  noFill();
  stroke(0);
  strokeWeight(50);
  translate(width/2, height/2);
  for (int i = diametre.size()-1; i>=0; i--) {
    diam = diametre.get(i);
    ellipse(0, 0, 10*diam, 10*diam);
    diam=diam-10;

    if (diam<=0) {
      diametre.remove(i);
    } else{
    diametre.set(i,diam);
    }
  }
  popMatrix();

  beat.detect(song.mix);
  if (beat.isOnset()) {
    if (p1==true) {
      qw[0].drawextra();
    }
    if (p2==true) {
      qw[1].drawextra();
    }
    if (p3==true) {
      qw[2].drawextra();
    }
    if (p4==true) {
      qw[3].drawextra();
    }
  }
  if (song.position() > 180000) {
      song.pause();
      animationOn = false;
    }
  }
  
  void f_keyPressed() {
  if (key==CODED) {
    if (keyCode==UP) {
      p1=!p1;
    }
    if (keyCode==RIGHT) {
      p2=!p2;
    }
    if (keyCode==DOWN) {
      p3=!p3;
    }
    if (keyCode==LEFT) {
      p4=!p4;
    }
    if (keyCode==CONTROL) {
      diametre.add(250.0);
    }
    
  } 
  if (key=='x'){
    p6=!p6;
  }
  if (key=='z'){
    p7=!p7;
  }
  if (keyCode=='.') {
    p5=!p5;
  }
}
}
