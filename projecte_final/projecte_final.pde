import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;

Animacio a;

void setup(){
 //size(1000,800);
 fullScreen();
  
 initAudio();
}

void draw(){
  
}

void initAudio(){
  minim = new Minim(this);
}

void keyPressed(){
  switch(key){
    case '1':
    a = new Lali("songLali.mp3");
    break;
    
    
  }
}
