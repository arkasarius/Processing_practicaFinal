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
boolean[] buttonUp = new boolean[9];
boolean[] buttonDown = new boolean[9];

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
  bus = new MidiBus(this, "SLIDER/KNOB", -1); 
  // bus = new MidiBus(this, "nan0KONTROL", -1);

  animationOn = false;
}

void draw() {
  if (animationOn) {
    a.run();
    a.display();
  } else {
    // el que fem quan no hi ha cap animacio activa
    background(0);
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
  //  println("Channel:"+channel);
  //  println("Number:"+number);
  //  println("Value:"+value);

  if (number/10 == 1) {
    slider[number%10] = value;
  }

  if (number/10 == 4) {
    knob[number%10] = value;
  }

  if (number/10 == 3) {
    buttonUp[number%10] = (value==1);
  }

  if (number/10 == 2) {
    buttonDown[number%10] = (value==1);
  }
}
