class Roger extends Animacio {

  Roger(String nameSong) {
    super(nameSong);
    reset();  
    song.play();
  }

  void reset() {
    frameCount=0;
    number=1;
    String[] lines = loadStrings("1.txt");
    for (int i = 0; i < lines.length; i=i+11) {// 11 es estable
      String[] parts = lines[i].split(":");
      int x= Integer.parseInt(parts[0]);
      int y= Integer.parseInt(parts[1]);
      points.add(new PVector(x, y));
    }
    for (PVector a : points) {
      par.add(new particle());
    }
    for (int i = 0; i < points.size(); i++) {
      par.get(i).moveto(points.get(i), 4);
    }
    frameRate(24);
    background(255);
    PImage img = loadImage("portada.jpg");
    image(img, 0, 0);
  }

  void run() {
  }

  void display() {
    if (frameCount>304) {
      background(255);
      for (particle a : par) {
        a.compute();
        a.display();
      }
      if (frameCount%4==0) {
        duk();
      }
    }
  }

  void f_keyPressed() {
    println("I'm here!");
  }
}

void duk() {
  points.clear();
  number++;
  if (number>1125) {
    print("done");
  } else {
    String[] lines = loadStrings(Integer.toString(number)+".txt");
    //println("there are " + lines.length + " lines");
    for (int i = 0; i < lines.length; i=i+11) {// 11 es estable
      String[] parts = lines[i].split(":");
      int x= Integer.parseInt(parts[0]);
      int y= Integer.parseInt(parts[1]);
      points.add(new PVector(x, y));
    }
    for (int i = 0; i < par.size(); i++) {
      if (i<points.size()) {
        par.get(i).moveto(points.get(i), 4);
      }
    }
    //print(points.size());
  }
}
