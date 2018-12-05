class Guillem extends Animacio{
  float g=0.05;
  rectangle[] qw;
  
  Guillem(String nameSong) {
    super(nameSong);
    reset();  
    song.play();
  }
  
  void reset(){
    qw = new rectangle[20];
    noFill();
    stroke(255);
    strokeWeight(3);
  }
  
  void display(){
    background(0);
    rectMode(CENTER);
    pushMatrix();
    translate(width/2,height/2);
    rotate(g);
    rect(0,0,75,75);
    g+=0.05;
    popMatrix();
    beat.detect(song.mix);
    if (beat.isOnset()){
    //cridar funcio
    }
  }
}
