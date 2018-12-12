class Walker_mgd {

  PVector pos, vel, acc; 
  boolean muerto; 
  float radi, velocitat; 
  color c;

  Walker_mgd(color col) {
    pos = new PVector(width/2, height/2);
    vel = new PVector(random(-1, 1), random(-1, 1));
    acc = new PVector(0, 0);
    muerto = false;
    c=col;
    stroke(c);
  }

  void moviment(float kickSize, float snareSize, float hatSize) {

    vel.add(acc);
    vel.mult(velocitat);
    vel.limit(5);
    pos.add(vel);
    acc.x = acc.x + (kickSize);
    acc.y= acc.y -(kickSize);

    int dir = int(random(4)); 

    if (snareSize!=0) {
      if (dir == 0) {
        pos.x+=snareSize;
      }
      if (dir == 1) {
        pos.x-=snareSize;
      }
    }
    if (hatSize!=0) {
      if (dir == 2) {
        pos.y+=hatSize;
      } 
      if (dir ==3) {
        pos.y-=hatSize;
      }
    }
  }

  void limits() {
    if (pos.x > width || pos.x <0) {
      muerto = true;
    }
    if (pos.y > height || pos.y < 0) {
      muerto = true;
    }
  }

  void dibuixa(float kickSize, int type) {
    ellipseMode(RADIUS);
    fill(c);
    noStroke();

    if (type == 1) {
      quadrats(kickSize);
    }
    if (type == 2) {
      ellipses(kickSize);
    }
  }

  void quadrats(float kickSize) {
    rect(pos.x, pos.y, 10+(kickSize*0.5)+radi, 10+(kickSize*0.5)+radi);
  }

  void ellipses(float kickSize) {
    ellipse(pos.x, pos.y, 5+(kickSize*0.4)+radi, 5+(kickSize*0.4)+radi);
  }
}
