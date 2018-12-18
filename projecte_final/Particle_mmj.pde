class Particle_mmj {
  float posX;
  float posY;
  float velX;
  float velY;
  float rad;
  float newVX;
  float newVY;
  int type;
  int mode;
  int form;
  float alfa;
  float cparticle;

  Particle_mmj(float x, float y, int t) {
    posX = x;
    posY = y;
    newVX = map(slider[1], 0, 127, -5, 5);
    newVY = map(slider[2], 0, 127, -5, 5);
    velX = newVX;
    velY = newVY;
    rad = map(knob[1], 0, 127, 0, 50);
    type = t;
    mode = 0;
    form = 0;
    alfa = 0;
    cparticle = 255;
  }

  void move(int nx, int ny, float dy, float dx) {

    if (mode == 0) {
      posX=posX+velX;
      posY=posY+velY;
      velX = newVX*type;
      velY = newVY*type;
      alfa = 0;
    } else if (mode == 1) {
      alfa += 1;
      posX = (float)posX+sin(alfa)*20*0.5;
      posY=(float)posY+velY;
      velX = newVX*type;
      velY = newVY*type;
    }

    if (posY <= -dy) {
      posY = posY+dy*ny;
    } else if (posY >= height+dy) {
      posY = posY-dy*ny;
    }

    if (posX <= dx) {
      posX = posX+dx*nx;
    } else if (posX >= width+dx) {
      posX = posX-dx*nx;
    }
  }

  void display(float ks) {
    if (form == 0) {
      noStroke();
      fill(cparticle);
      ellipse(posX, posY, rad+ks/10, rad+ks/10);
      fill(cparticle, 80);
      ellipse(posX, posY, rad+5+ks/4, rad+5+ks/4);
      fill(cparticle, 50);
      ellipse(posX, posY, rad+5+ks/2*1.5, rad+5+ks/2*1.5);
    } else if (form == 1) {
      noStroke();
      fill(cparticle);
      rectMode(CENTER);
      rect(posX, posY, rad+ks/10, rad+ks/10);
      fill(cparticle, 80);
      rect(posX, posY, rad+5+ks/4, rad+5+ks/4);
      fill(cparticle, 50);
      rect(posX, posY, rad+5+ks/2, rad+5+ks/2);
    }
  }
}
