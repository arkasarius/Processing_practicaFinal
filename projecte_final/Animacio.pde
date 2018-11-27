abstract class Animacio {
  
  Animacio(String nameSong){
    setupMusica(nameSong);
  }

  void setupMusica(String nameSong) {
    song = minim.loadFile(nameSong);
    beat = new BeatDetect(song.bufferSize(), song.sampleRate());

    beat.setSensitivity(300);  // tots igual?

    song.play(); // potser a un altre lloc
  }

  void reset() {
  }

  void run() {
  }

  void display() {
  }
}
