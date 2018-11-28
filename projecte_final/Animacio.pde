abstract class Animacio {

  Animacio(String nameSong) {
    setupMusica(nameSong);
  }
  
  void setupMusica(String nameSong) {
    song = minim.loadFile(nameSong);
    beat = new BeatDetect(song.bufferSize(), song.sampleRate());

    beat.setSensitivity(300);  // tots igual?

  }

  void reset() {
  }

  void run() {
  }

  void display() {
  }

  
  // Aquestes funcions (potser no calen totes), 
  // les haurem de programar com si fossin les funcions de teclat i ratoli.
  // Les cridem des del programa principal quan la nostra animacio esta activa.
  // 
  void f_keyPressed(){}
  
  void f_keyReleased(){}
  
  void f_mousePressed(){}
  
  void f_mouseDrgged(){}
  
  void f_mouseReleased(){}
}
