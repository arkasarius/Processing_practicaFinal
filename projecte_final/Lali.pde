class Lali extends Animacio {

  Lali(String nameSong) {
    super(nameSong);
    reset();  

    song.play();
  }

  void reset() {
  bgColor = color(random(255), random(255), random(255));
    background(bgColor);
  }

  void run() {
    if(buttonS[1]){
      bgColor = color(random(255), random(255), random(255));
      buttonS[1]=false;
    }
  }

  void display() {
    background(bgColor);
    if (buttonM[1]) {
      ellipse(width/2, height/2, slider[1], slider[2]);
    }
  }
  
  void f_keyPressed(){
    println("I'm here!");
  }
}
