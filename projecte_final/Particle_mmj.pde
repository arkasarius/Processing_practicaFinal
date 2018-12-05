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
    newVX = 0;
    newVY = 1;
    velX = newVX;
    velY = newVY;
    rad = 10;
    type = t;
    mode = 0;
    form = 0;
    alfa = 0;
    cparticle = 255;
  }

  void move(float n) {

    if (mode == 0) {
      posX=posX+velX;
      posY=posY+velY;
      velX = newVX*type;
      velY = newVY*type;
      alfa = 0;
    } else if (mode == 1) {
      alfa += 1;
      posX = posX+sin(alfa)*velX*0.5;
      posY=posY+velY;
      velX = newVX*type;
      velY = newVY*type;
    }

    if (posY < 0-height/n) {
      posY = height+height/n;
    } else if (posY > height+height/n) {
      posY = -height/n;
    }

    if (posX < 0-width/n) {
      posX = width+width/n;
    } else if (posX > width+width/n) {
      posX = -width/n;
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
