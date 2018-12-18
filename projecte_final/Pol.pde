class Pol extends Animacio {

  Network nw;
  int numNodes = 1000;
  PImage img;
  int startTime = 0;

  Pol(String nameSong) {
    super(nameSong);
    song.play();
    fft = new FFT( song.bufferSize(), song.sampleRate() );
    img = loadImage("imgPol.jpg");
    reset();
    startTime = millis();
    pushMatrix();
  }

  void reset() {
    nw = new Network();
    img.loadPixels();
    for (int i=0; i<numNodes; i++) {
      float maxR = dist(0, 0, 0.5*width, 0.5*height);
      float r = 0.9*0.5*height * sqrt(random(1.0));
      float a = random(TAU);
      float x = 0.5*width + r*cos(a);
      float y = 0.5*height + r*sin(a);
      color imgc = img.pixels[floor(random(0, img.width*img.height-1))];
      nw.addNode(x, y, 0, false, imgc);
    }
    nw.connectAll();
    //song.skip(50000);
    //song.skip(175000);
  }

  void display() {
    int myMillis = millis() - startTime;

    background(0);

    translate(width/2, height/2);
    rotate(millis()/30000.0);
    //scale(min(myMillis/70000.0 + 0.2, 1.0));
    translate(-width/2, -height/2);

    nw.advect();
    nw.damp();

    nw.move(true);
    nw.display();

    if (song.position() > 56000) {
      nw.displayColor = true;
    }

    if (song.position() > 187900) {
      song.pause();
      popMatrix();
      animationOn = false;
    }

    if (song.position() > 180000) {
      float f = map(song.position(), 180000, 187900, 0, 255);
      fill(0, f);
      rect(0, 0, width, height);
    }

    //println(frameRate);
  }
}

class Network {
  ArrayList<Node> nodes;
  boolean displayColor = false;

  Network() {
    nodes = new ArrayList<Node>();
  }

  void addNode(float x, float y, float s, boolean isFixed, color c) {
    nodes.add(new Node(x, y, s, isFixed, c));
  }

  void connectNodes(Node a, Node b) {
    a.connectTo(b);
    b.connectTo(a);
  }

  // Minimum spanning tree
  void connectAll() {
    ArrayList<Node> reached = new ArrayList<Node>();
    ArrayList<Node> unreached = new ArrayList<Node>();

    for (Node n : nodes) {
      unreached.add(n);
    }

    reached.add(unreached.get(0));
    unreached.remove(0);

    while (unreached.size() > 0) {
      float minD = 10000000;
      int minI = 0;
      int minJ = 0;

      for (int i=0; i<reached.size(); i++) {
        for (int j=0; j<unreached.size(); j++) {
          float d = PVector.dist(reached.get(i).p, unreached.get(j).p);
          if (d < minD) {
            minD = d;
            minI = i;
            minJ = j;
          }
        }
      }

      connectNodes(reached.get(minI), unreached.get(minJ));

      reached.add(unreached.get(minJ));
      unreached.remove(minJ);
    }
  }

  void display() {
    // FFT display
    float freqThreshold = 5; //15
    fft.forward( song.mix );
    IntList topFreq = new IntList();
    for (int i = 0; i < fft.specSize(); i++) {
      float freq = fft.getBand(i);
      if (freq > freqThreshold) {
        topFreq.append(i);
      }
    }
    float songLevel = song.mix.level();
    for (int i : topFreq) {
      int idx = (int)map(i, 0, 1024, 0, nodes.size());
      nodes.get(idx).setVal(min(5*songLevel, 0.999));
    }

    // Display links
    for (Node n : nodes) {
      for (Node o : n.coNodes) {
        float val = (n.val + o.val)/2;
        if (displayColor) {
          stroke(lerpColor(n.col, o.col, 0.5), 255*val);
        } else {
          stroke(255, 255*val);
        }

        line(n.p.x, n.p.y, o.p.x, o.p.y);
      }
    }

    // Display nodes
    noStroke();
    for (Node n : nodes) {
      float val = n.val;

      if (displayColor) {
        fill(n.col, 255*val);
      } else {
        fill(255, 255*val);
      }

      ellipse(n.p.x, n.p.y, n.val*15, n.val*15);
    }
  }

  void move(boolean isCos) {
    float songLevel = song.mix.level();
    for (Node n : nodes) {
      if (isCos) {
        n.moveCos(songLevel);
      } else {
        n.moveExp(songLevel);
      }
    }
  }

  void advect() {
    for (Node n : nodes) {
      n.advect();
    }
  }

  void damp() {
    for (Node n : nodes) {
      n.damp();
    }
  }
}

class Node {
  float val, val_1, val_2;
  PVector p0, p;
  ArrayList<Node> coNodes;
  color col;

  float kdi = 0.1;
  float kwa = 0.01;
  float kad = 0.2;
  float kda = 0.1;

  Node(float x, float y, float value, boolean isFixed, color c) {
    val = value;
    val_1 = value;
    p0 = new PVector(x, y);
    p = new PVector(x, y);
    coNodes = new ArrayList<Node>();
    col = c;
  }

  void connectTo(Node o) {
    coNodes.add(o);
  }

  void setVal(float value) {
    val = value;
    val_1 = value;
    val_2 = value;
  }

  void moveCos(float medLevel) {
    float songPos = song.position();
    float ampA = (songPos > 56000)? 50 : 0;
    float ampB = min(20, songPos/3000.0);

    PVector rel = new PVector(p0.x-0.5*width, p0.y-0.5*height);
    float d = rel.magSq();
    rel.setMag(ampA*medLevel*(cos(d*TAU/500000.0)) + ampB*(0.5*cos(TAU*millis()/1500.0)+0.5));
    p.set(PVector.add(p0, rel));
  }

  void moveExp(float medLevel) {
    PVector rel = new PVector(p0.x-0.5*width, p0.y-0.5*height);
    float d = rel.magSq();
    rel.setMag(50*(medLevel+1.0)*pow(2, -d/500000));
    p.set(PVector.add(p0, rel));
  }

  void advect() {
    float sum = 0;
    for (Node o : coNodes) {
      sum += pow(o.val_1 - val_1, 2);
    }
    sum = sqrt(sum);

    val = constrain(val_1 + kad*(sum), -1, 1);

    val_2 = val_1;
    val_1 = val;
  }

  void damp() {
    val_1 *= (1.0 - kda);
  }
}
