class Monica extends Animacio {
  ArrayList<Particle_mmj> particleList;
  float n;
  float x;
  float y;
  int tipus;
  float snareSize;
  color boletes;
  float red, green, blue;
  float limits;
  float fade;
  boolean canFade;


  Monica(String nameSong) {
    super(nameSong);
    reset();  
    song.play();
  }

  void reset() {
    particleList = new ArrayList<Particle_mmj>();
    n = 15;
    x = 0;
    y = 0;
    tipus = 1;
    background(bgColor);
    red = green = blue = bgColor;
    x = 0;
    y = 0;
    limits = 5;
    fade = 0;
    canFade = false;


    for (int i = 0; i<width; i++) {
      for (int j = 0; j<n+1; j++) {
        particleList.add(new Particle_mmj(x, y, tipus));
        x += (float)width/(n-1);
        tipus = -tipus;
      }
      x = 0;
      y += (float)height/7;
    }
    snareSize = 16;
  }

  void run() {
    beat.detect(song.mix);
    snareSize = constrain(snareSize * 0.95, 16, 80);
    if ( beat.isSnare() ) snareSize = 80;

    //SLIDER 1 VELOCITAT VERTICAL
    for (Particle_mmj p : particleList) {
      p.newVY = map(slider[1], 0, 127, -limits, limits);
    }

    //SLIDER 2 VELOCITAT HORITZONTAL
    for (Particle_mmj p : particleList) {
      p.newVX = map(slider[2], 0, 127, -limits, limits);
    }

    //SLIDER 3 CANAL RED
    red = map(slider[3], 0, 127, 0, 255);

    //SLIDER 4 CANAL GREEN
    green = map(slider[4], 0, 127, 0, 255);

    //SLIDER 5 CANAL BLUE
    blue = map(slider[5], 0, 127, 0, 255);

    //SLIDER 6 LIMITS VELOCITAT (per adequar-los al ritme de la cançó)
    limits = map(slider[6], 0, 127, 5, 20);


    //CANVI RADI
    for (Particle_mmj p : particleList) {
      p.rad = map(knob[1], 0, 127, 0, 50);
    }

    //CANVI COLOR (B&W)
    if (buttonS[1]) {
      for (Particle_mmj p : particleList) {
        if (p.cparticle == 255) {
          p.cparticle=0;
        } else {
          p.cparticle=255;
        }
      }
      buttonS[1]=false;
    }

    //CANVI FORMA (rodones, quadrats)
    if (buttonS[2]) {
      for (Particle_mmj p : particleList) {
        if (p.form == 0) {
          p.form = 1;
        } else {
          p.form = 0;
        }
      }
      buttonS[2]=false;
    }

    //CANVI MODE (normal o sinusoide vertical)
    if (buttonS[3]) {
      for (Particle_mmj p : particleList) {
        if (p.mode == 0) {
          p.mode = 1;
        } else {
          p.mode = 0;
        }
      }
      buttonS[3]=false;
    }

    /*
    //FADE
     if (buttonS[3]) {
     canFade = true;
     }
     buttonS[3]=false;
     }*/
  }

  void display() {
    bgColor = color(red, green, blue);
    background(bgColor);
    fill(bgColor,80);
    rect(0,0,width,height);
 

    for (int i = 0; i< width/n; i++) {
      Particle_mmj p = particleList.get(i);
      p.move(n);
      p.display(snareSize);
    }
    /*
    if(canFade == true){
     fill(0,0,0,fade);
     rect(0,0,width, height);
     fade+=2;
     }*/
  }


  void f_keyPressed() {
    switch(keyCode) {
      /*
    case 'f':
       case 'F':
       canFade = true;
       break;*/
    }
  }
}
