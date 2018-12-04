import themidibus.*;

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;

Animacio a;
boolean animationOn;

// variables per al MIDI
// les variables son globals i es poden utilitzar dins de les classes
// les funcions de gestio del MIDI s'han de cridar des de la classe principal
MidiBus bus;
int[] slider = new int[9];
int[] knob = new int[9];
boolean[] buttonR = new boolean[9];
boolean[] buttonM = new boolean[9];
boolean[] buttonS = new boolean[9];

color bgColor=0;

void setup() {
  size(1000, 800);
  //fullScreen();

  // inicialitzem la Minim
  minim = new Minim(this);

  // inicialitzem el MIDI
  // quan inicialitzem, hem de veure quin nom li dona processing al controlador.
  // Ho fem amb la instruccio MidiBus.list()
  // despres posarem el nom que ens interessi en la creadora del bus.
  // MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  bus = new MidiBus(this, 0, -1); 
  // bus = new MidiBus(this, "nan0KONTROL", -1);

  animationOn = false;
}

void draw() {
  if (animationOn) {
    a.run();
    a.display();
  } else {
    // el que fem quan no hi ha cap animacio activa
    background(bgColor);
  }
}

void keyPressed() {
  if (animationOn) {
    a.f_keyPressed();
  } else {
    switch(key) {
    case '1':
      a = new Lali("songLali.mp3");
      a.reset();
      animationOn = true;
    }
  }
}

void controllerChange(int channel, int number, int value) {
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);

  if (number/10 == 1) {
    slider[number%10] = value;
  }

  if (number/10 == 4) {
    knob[number%10] = value;
  }

  // els botons que tenen la lletra S son instantanis.
  // serveixen per disparar coses.
  // posem la variable a true quan es diferent de zero. 
  // nomes actua mentre el boto esta apretat.
  if (number/10 == 5) {
    buttonS[number%10] = (value!=0);
  }

  // els botons que tenen la lletra M o R canvien cada vegada 
  // de 0 a 1 o de 1 a 0 (a vegades es 0-127, 127-0).
  // quan es diferent de zero posem la variable a true. 
  // quan el boto te llum, el valor es diferent de zero. 
  if (number/10 == 3) {
    buttonM[number%10] = (value!=0);
  }

  if (number/10 == 2) {
    buttonR[number%10] = (value!=0);
  }
}
