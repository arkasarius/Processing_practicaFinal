class Mese extends Animacio {
  float kickSize, snareSize, hatSize;
  float x, y;
  ArrayList<Walker_mgd> walkingClub; 
  int type;

  Mese(String nameSong) {
    super(nameSong);
    reset();  
    song.play();
  }

  void reset() {
    // bgColor = color(255); 
    // background(bgColor);
    walkingClub = new ArrayList<Walker_mgd>(); 
    kickSize = snareSize = hatSize = 32;
    x= 400; 
    y= 300;
  }

  void run() {
    x += 1.5;
    y += -1.8;
    beat.detect(song.mix);

    kickSize = constrain(kickSize * 0.95, 16, 100);
    snareSize = constrain(snareSize * 0.95, 16, 50);
    hatSize = constrain(snareSize * 0.95, 16, 75);
    if ( beat.isKick() ) kickSize = 100;
    if ( beat.isSnare() ) snareSize = 100;
    if ( beat.isHat() ) hatSize = 100;

    fill(255, 50);
    rect(0, 0, width, height);
    if (kickSize==100) {
      walkingClub.add(new Walker_mgd());
      walkingClub.add(new Walker_mgd());
    }

    for (Walker_mgd x : walkingClub) {
      x.dibuixa(kickSize, type); 
      x.moviment(kickSize, snareSize, hatSize);
      x.limits();
    }
    //////Matar
    for (int i = walkingClub.size()-1; i>=0; i--) {
      Walker_mgd w = walkingClub.get(i); 
      if (w.muerto == true) {
        walkingClub.remove(i);
      }
    }
  }

  void f_keyPressed(){
  switch(keyCode){
    case 'Q': 
    case 'q': 
      type = 1; 
      break; 
   case 'W': 
   case 'w': 
     type = 2; 
     break; 
     
  
  }
  }
}
