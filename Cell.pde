//Program based on "Insane in the Chromatophores"

// Declare
float s = 0;   //Transmite los Avgs a los objetos
float r = 20;  //Establece el radio de las cells

int cellNumber = 90;

float[] spec = new float[513];
float[] avg = new float[cellNumber];

cell [] cellcollection = new cell[cellNumber];

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer jingle;
AudioMetaData meta;
FFT fft;



void setup() {
  size (1400, 800);
  noStroke();

  minim = new Minim(this);
  jingle = minim.loadFile("Sonf.mp3", 1024);
  jingle.loop();
  fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
  fft.linAverages(1);
  meta = jingle.getMetaData();

  // Initialize
  for(int i = 0; i < cellcollection.length; i++){
  cellcollection[i] = new cell(random(0, width), random(0, height), random(2,10), random(0,7), random(0.001,0.5));
  }

}


void analyzer() {
  fft.forward(jingle.mix);  
  for (int i = 0; i < fft.specSize (); i++)
  {
    spec[i] = fft.getBand(i);
  }

  float sum = 0;

  for (int j = (fft.specSize ()/cellNumber); j < (2 * fft.specSize ()/3); j++) {
    sum = abs(sum + spec[j]);
    avg[0] = sum;
  }
  
  /*
  for (int i = 0; i < fft.specSize ()/3; i++) {
    sum = abs(sum + spec[i]);
    avg[0] = sum;
  }
  
  sum = 0;
  for (int i = (fft.specSize ()/3); i < (2 * fft.specSize ()/3); i++) {
    sum = abs(sum + spec[i]);
    avg[1] = sum;
  }
  
  sum = 0;
  for (int i = 2 * fft.specSize ()/3; i < fft.specSize (); i++) {
    sum = abs(sum + spec[i]);
    avg[2] = sum;
  }
  //*/
}

void draw() {
  background(255);
  analyzer();
  
  for(int i = 0; i < cellcollection.length; i++){
  cellcollection[i].run(avg[0]);
  }
}

