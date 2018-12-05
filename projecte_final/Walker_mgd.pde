class Walker_mgd{
  
  color origen, fi, c1, c2, relleno;
  PVector pos, vel, acc; 
  boolean muerto; 

  Walker_mgd() {
    setColor();
    pos = new PVector(width/2, height/2);
    vel = new PVector(2, -1.5);
    acc = new PVector(0.5, -0.8);
    muerto = false;
  }

  void moviment(float kickSize, float snareSize, float hatSize) {

    vel.add(acc);
    vel.limit(1.5);
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
      } if(dir ==3){
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


  void setColor() {
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
  }

  void dibuixa(float kickSize,int type) {
    ellipseMode(RADIUS);
    fill(relleno);
    noStroke();
    
    if(type == 1){
    rect(pos.x, pos.y, 20+(kickSize*0.5), 20+(kickSize*0.5));
    }
    
    if(type == 2){
      ellipse(pos.x, pos.y, 20+(kickSize*0.5), 20+(kickSize*0.5));
    }
  }
}
