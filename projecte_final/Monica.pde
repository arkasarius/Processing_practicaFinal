class Monica extends Animacio {
  ArrayList<Particle_mmj> particleList;
  float n;
  float x;
  float y;
  int tipus;
  float snareSize;
  color boletes;

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

    x = 0;
    y = 0;

    for (int i = 0; i<width; i++) {
      for (int j = 0; j<n+1; j++) {
        particleList.add(new Particle_mmj(x, y, tipus));
        x += width/(n-1);
        tipus = -tipus;
      }
      x = 0;
      y +=height/7;
    }
    snareSize = 16;
  }

  void run() {


    beat.detect(song.mix);
    snareSize = constrain(snareSize * 0.95, 16, 80);
    if ( beat.isSnare() ) snareSize = 80;
  }

  void display() {
    background(bgColor);
    for (int i = 0; i< width/n; i++) {
      Particle_mmj p = particleList.get(i);
      p.move(n);
      p.display(snareSize);
    }
  }

  void f_keyPressed() {
    switch(keyCode) {
    case UP:
      for (int i = 0; i< width/n; i++) {
        Particle_mmj p = particleList.get(i);
        p.newVY = p.newVY + 1;
      }
      break;
    case DOWN:
      for (int i = 0; i< width/n; i++) {
        Particle_mmj p = particleList.get(i);
        p.newVY = p.newVY - 1;
      }
      break;
    case LEFT:
      for (int i = 0; i< width/n; i++) {
        Particle_mmj p = particleList.get(i);
        p.newVX = p.newVX + 1;
      }
      break;
    case RIGHT:
      for (int i = 0; i< width/n; i++) {
        Particle_mmj p = particleList.get(i);
        p.newVX = p.newVX - 1;
      }
      break;
    case 'f':
    case 'F':
      for (int i = 0; i< width/n; i++) {
        Particle_mmj p = particleList.get(i);
        if (p.form == 0) {
          p.form = 1;
        } else {
          p.form = 0;
        }
      }
    case 'm':
    case 'M':
      for (int i = 0; i< width/n; i++) {
        Particle_mmj p = particleList.get(i);
        if (p.mode == 0) {
          p.mode = 1;
        } else {
          p.mode = 0;
        }
      }
    case 'q':
    case 'Q':
      for (int i = 0; i< width/n; i++) {
        Particle_mmj p = particleList.get(i);
        if (p.rad<=20) {
          p.rad = p.rad + 1;
        }
      }
      
    case 'w':
    case 'W':
      for (int i = 0; i< width/n; i++) {
        Particle_mmj p = particleList.get(i);
        if (p.rad>=0) {
          p.rad = p.rad - 1;
        }
      }
    case 'o':
    case 'O':
      for (int i = 0; i< width/n; i++) {
        Particle_mmj p = particleList.get(i);
        p.cparticle-=5;
      }
      bgColor+=5;
    case 'p':
    case 'P':
      for (int i = 0; i< width/n; i++) {
        Particle_mmj p = particleList.get(i);
        p.cparticle+=5;
      }
      bgColor-=5;
    }
  }
}
