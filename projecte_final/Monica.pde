class Monica extends Animacio {
  ArrayList<Particle_mmj> particleList;
  float x;
  float y;
  float dx;
  float dy;
  int nx;
  int ny;
  int tipus;
  float snareSize;
  color boletes;
  float red, green, blue;
  float limits;
  float fadeOut;
  boolean canFadeOut;
  float fadeIn;
  boolean canFadeIn;


  Monica(String nameSong) {
    super(nameSong);
    reset();  
    song.play();
  }

  void reset() {
    particleList = new ArrayList<Particle_mmj>();
    x = 0;
    y = 0;
    nx=16;
    ny=8;
    dx=width/(nx-1);
    dy=height/(ny-1);
    
    
    tipus = 1;
    background(bgColor);
    red = green = blue = bgColor;
    x = 0;
    y = 0;
    limits = 5;
    fadeOut = 0;
    canFadeOut = false;
    fadeIn = 255;
    canFadeIn = true;

    for (int i = 0; i<ny; i++) {
      for (int j = 0; j<nx; j++) {
        particleList.add(new Particle_mmj(x, y, tipus));
        x += dx;
        tipus = -tipus;
      }
     x = 0;
     y += dy;
    }
println(particleList.size());
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
  }

  void display() {
    bgColor = color(red, green, blue);
    background(bgColor);
    fill(bgColor, 80);
    rect(0, 0, width, height);


    for (int i = 0; i< particleList.size(); i++) {
      Particle_mmj p = particleList.get(i);
      p.move(nx,ny,dy,dx);
      p.display(snareSize);
    }

    if (canFadeOut == true) {
      rectMode(CORNER);
      fill(0, 0, 0, fadeOut);
      rect(0, 0, width, height);
      fadeOut+=2;
    }
    
    if (canFadeIn == true) {
      rectMode(CORNER);
      fill(0, 0, 0, fadeIn);
      rect(0, 0, width, height);
      fadeIn-=2;
      if(fadeIn <= 0){
        canFadeIn = false;
    }
    
  }
  }


  void f_keyPressed() {
    switch(keyCode) {
    case 'f':
    case 'F':
      canFadeOut = true;
      break;

    }
  }
}
