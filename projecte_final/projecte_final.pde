import themidibus.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;
FFT fft;

Animacio a;
boolean animationOn;

// variables per al MIDI
// les variables son globals i es poden utilitzar dins de les classes
// les funcions de gestio del MIDI s'han de cridar des de la classe principal
MidiBus bus;
int[] slider = new int[10];
int[] knob = new int[10];
boolean[] buttonR = new boolean[10];
boolean[] buttonM = new boolean[10];
boolean[] buttonS = new boolean[10];

color bgColor=0;

void setup() {
  //size(1920, 1080);
  fullScreen();

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
    if (key == '0') {
      song.close();
      animationOn = false;
      bgColor = 0;
    } else {
      a.f_keyPressed();
    }
  } else {
    switch(key) {
    case '1':
      a = new Lali("songLali.mp3");
      animationOn = true;
      break;
    case '2':
      a = new Monica("songMonica.mp3");
      animationOn = true;
      break;
    case '3':
      a = new Mese("songMese.mp3");
      animationOn = true;
      break;
    case '4':
      a = new Alex("songAlex.mp3");
      animationOn = true;
      break;
    case '5':
      a = new Guillem("songGuillem.mp3");
      animationOn = true;
      break;
    case '6':
      a = new Pol("songPol.mp3");
      animationOn = true;
      break;
    }
  }
}

void controllerChange(int channel, int number, int value) {
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);


  // ATENCIO: SLIDERS, KNOBS I BOTONS ESTAN NUMERATS DE 1 A 9 (EN LA CONTROLADORA VELLA) I DE 1 A 8 (EN LA NOVA).
  // DELS ARRAYS slider[], knob[], buttonX[] NO FEM SERVIR LA POSICIO 0, I AMB LA CONTROLADORA NOVA TAMPOC LA 9.
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
