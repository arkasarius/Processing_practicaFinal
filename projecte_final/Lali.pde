class Lali extends Animacio {

  Lali(String nameSong) {
    super(nameSong);
    reset();  

    song.play();
  }

  void reset() {
    background(0);
  }

  void run() {
  }

  void display() {
    if (buttonUp[1]) {
      ellipse(width/2, height/2, slider[1], slider[2]);
    }
  }
  
  void f_keyPressed(){
    println("I'm here!");
  }
}
