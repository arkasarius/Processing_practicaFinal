class Pol extends Animacio {

  Network nw;
  int numNodes = 1000;

  Pol(String nameSong) {
    super(nameSong);
    reset();  
    song.play();
  }

  void reset() {
    nw = new Network();
    float margin = 10;
    for (int i=0; i<numNodes; i++) {
      nw.addNode(random(margin, width-margin), random(margin, height-margin), 0, false);
    }
    nw.connectAll();
  }

  void display() {
    background(0);

    //nw.diffuse();
    //nw.wave();
    nw.advect();
    nw.damp();

    nw.display();

    //println(frameRate);
  }
}

class Network {
  ArrayList<Node> nodes;

  Network() {
    nodes = new ArrayList<Node>();
  }

  void addNode(float x, float y, float s, boolean isFixed) {
    nodes.add(new Node(x, y, s, isFixed));
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
      float minD = 100000;
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
    // Activate some node based on the music
    int ri = (int)random(nodes.size());
    float songLevel = song.mix.level();
    nodes.get(ri).setVal(songLevel);

    // Display links
    for (Node n : nodes) {
      for (Node o : n.coNodes) {
        float val = (n.val + o.val)/2;
        boolean isPositive = val >= 0;
        float mag = abs(val);
        stroke(isPositive? 255*mag : 0, 255*mag, isPositive? 0 : 255*mag);
        line(n.p.x, n.p.y, o.p.x, o.p.y);
      }
    }

    // Display nodes
    for (Node n : nodes) {
      n.display();
    }
  }

  void diffuse() {
    for (Node n : nodes) {
      n.diffuse();
    }
  }

  void wave() {
    for (Node n : nodes) {
      n.wave();
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
  PVector p;
  ArrayList<Node> coNodes;
  boolean isFixed;

  float kdi = 0.1;
  float kwa = 0.01;
  float kad = 0.2;
  float kda = 0.1;

  Node(float x, float y, float value, boolean isFixed) {
    val = value;
    val_1 = value;
    p = new PVector(x, y);
    coNodes = new ArrayList<Node>();
    this.isFixed = isFixed;
  }

  void display() {
    boolean isPositive = val >= 0;
    float mag = abs(val);
    fill(isPositive? 255*mag : 0, 255*mag, isPositive? 0 : 255*mag);

    noStroke();
    ellipse(p.x, p.y, 5, 5);
  }

  void connectTo(Node o) {
    coNodes.add(o);
  }

  void setVal(float value) {
    val = value;
    val_1 = value;
    val_2 = value;
  }

  void diffuse() {
    if (isFixed) return;

    int N = coNodes.size();

    float sum = 0;
    for (Node o : coNodes) {
      sum += o.val_1;
    }

    val = val_1 + kdi*(sum/(N) - N*val_1);

    if (val > 0.3) {
      setVal(1);
    }

    val_2 = val_1;
    val_1 = val;
  }

  void wave() {
    if (isFixed) return;

    int N = coNodes.size();

    float sum = 0;
    for (Node o : coNodes) {
      sum += o.val_1;
    }

    val = constrain(2*val_1 - val_2 + kwa*(sum/(N+0.0001) - N*val_1), -1, 1);

    val_2 = val_1;
    val_1 = val;
  }

  void advect() {
    float sum = 0;
    for (Node o : coNodes) {
      sum += pow(o.val_1 - val_1, 2);
    }
    sum = sqrt(sum); // Més efficient la suma de valors absoluts ?

    val = constrain(val_1 + kad*(sum), -1, 1);

    val_2 = val_1;
    val_1 = val;
  }

  void damp() {
    val_1 *= (1.0 - kda);
  }
}
