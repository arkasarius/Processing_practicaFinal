class particle {
  PVector pos=new PVector(0,0);
  PVector dest=new PVector(0,0);
  int steps=-1;
  particle() {
    pos.x=random(width);
    pos.y=random(height);
    dest=pos;
  }
  void display() {
    noStroke();
    fill((int)random(255),(int)random(255),(int)random(255));
    ellipse(pos.x, pos.y, 3, 3);
  }
  void moveto(PVector destination,int _steps) {
    dest = destination.sub(pos);
    steps=_steps;
    dest.div(steps);
    //print(dest);
  }
  void compute(){
    if(steps>0){
      nextStep();
    }
  }
  void nextStep(){
    pos.add(dest);
    steps--;
  }
}
