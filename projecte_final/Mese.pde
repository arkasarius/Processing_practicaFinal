class Mese extends Animacio {
  float kickSize, snareSize, hatSize;
  float x, y;
  ArrayList<Walker_mgd> walkingClub; 
  int type; 
  float radi;
  color c; 
  boolean bg, bl; 

  Mese(String nameSong) {
    super(nameSong);
    reset();  
    song.play();
  }

  void reset() {
    walkingClub = new ArrayList<Walker_mgd>(); 
    kickSize = snareSize = hatSize = 32;
    x= 400; 
    y= 300;
    c = color(50, 255, 255);
    strokeWeight(6);
    bg = true;
    bl = false; 
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


    if (kickSize==100) {
      walkingClub.add(new Walker_mgd(c));
      walkingClub.add(new Walker_mgd(c));
      c = setColor();
    }

    //////Controlar walkers
    for (Walker_mgd x : walkingClub) {
      x.dibuixa(kickSize, type); 
      x.moviment(kickSize, snareSize, hatSize);
      x.limits();
    }

    //////Matar
    for (int i = walkingClub.size()-1; i>=0; i--) {
      Walker_mgd w = walkingClub.get(i); 
      if (w.muerto) {
        walkingClub.remove(i);
      }
    }

    //SLIDERS Stuff
    for (Walker_mgd w : walkingClub) {
      w.radi = map(slider[1], 0, 127, -5, 5);
      w.velocitat = map(slider[2], 0, 127, -5, 5);
    }

    ///BTN Stuff
    if (buttonS[3]) {
      type=3;
      walkingClub.clear();
    } 
    if (buttonS[4]) {
      type=4;
      walkingClub.clear();
    } 
    if (buttonS[1]) {
      type=1;
    } 
    if (buttonS[2]) {
      type=2;
    }

    if (buttonR[5]) {
      bg = false;
    }else{
      bg=true;
    }
    
    if (buttonS[6]) {
      type=0;
      frameCount = 0;
    }
    
  }

  void display() {
    noStroke();
    
    if(type== 0){
      fill(245, frameCount);
      rect(0, 0, width, height);
    }
  
    if (!bg) {
      fill(c, 50);
      rect(0, 0, width, height);
      stroke(255);
    } else {
      fill(245, 50);
      rect(0, 0, width, height);
      stroke(c);
    }

    if (type == 3) {
      radi = map(slider[3], 0, 127, 50, 200);
      arcs(kickSize);
    }

    if (type == 4) {
      radi = map(slider[3], 0, 127, 50, 200);
      dobleArcs(kickSize);
    }
    
   
  }


  void arcs(float kickSize) {
    noFill();
    //stroke(c); 
    arc(width/2, height/2, 100+radi, 100+radi, HALF_PI+(kickSize*0.05), PI+(kickSize*0.05));
    arc(width/2, height/2, 150+radi, 150+radi, HALF_PI-(kickSize*0.05), PI-(kickSize*0.05));
    arc(width/2, height/2, 200+radi, 200+radi, HALF_PI+(kickSize*0.05), PI+(kickSize*0.05));
  }

  void dobleArcs(float kickSize) {
    noFill();
    //stroke(c); 
    arc(width/4, height/2, 100+radi, 100+radi, HALF_PI+(kickSize*0.05), PI+(kickSize*0.05));
    arc(width/4, height/2, 150+radi, 150+radi, HALF_PI-(kickSize*0.05), PI-(kickSize*0.05));
    arc(width/4, height/2, 200+radi, 200+radi, HALF_PI+(kickSize*0.05), PI+(kickSize*0.05));

    arc(3*width/4, height/2, 100+radi, 100+radi, HALF_PI-(kickSize*0.05), PI-(kickSize*0.05));
    arc(3*width/4, height/2, 150+radi, 150+radi, HALF_PI+(kickSize*0.05), PI+(kickSize*0.05));
    arc(3*width/4, height/2, 200+radi, 200+radi, HALF_PI-(kickSize*0.05), PI-(kickSize*0.05));
  }


  color setColor() {
    color origen, fi, c1, c2;
    color relleno=0;
    origen = color(255, 255, 25); 
    fi = color(50, 255, 255);
    c1  = lerpColor(origen, fi, 0.3); 
    c2 = lerpColor(origen, fi, 0.7); 

    int colorDice = (int) random(0, 4);

    if (colorDice == 0) { 
      relleno = origen;
    }
    if (colorDice == 1) { 
      relleno = c1;
    }
    if (colorDice == 2) { 
      relleno = c2;
    }
    if (colorDice == 3) { 
      relleno = fi;
    }
    return relleno;
  }
  
}
