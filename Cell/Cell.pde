//Program based on "Insane in the Chromatophores"

// Declare
cell [] cellcollection = new cell[20];

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer jingle;
AudioMetaData meta;
FFT fft;

float s = 0;   //Transmite los Avgs a los objetos
float r = 20;  //Establece el radio de las cells
float[] spec = new float[513];
float[] avg = new float[3];

void setup() {
  size (800, 600);
  noStroke();

  minim = new Minim(this);
  jingle = minim.loadFile("Sonf.mp3", 1024);
  jingle.loop();
  fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
  fft.linAverages(1);
  meta = jingle.getMetaData();

  // Initialize
  for(int i = 0; i < cellcollection.length; i++){
  cellcollection[i] = new cell(random(0, width), random(0, height), random(2,10));
  }
  /*
  cell1 = new cell(width/4, height/2, 20);
  cell2 = new cell(2 * width/4, height/2, 20);
  cell3 = new cell(3 * width/4, height/2, 20);
  */
}


void analyzer() {
  fft.forward(jingle.mix);  
  for (int i = 0; i < fft.specSize (); i++)
  {
    spec[i] = fft.getBand(i);
  }

  float sum = 0;

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
}

void draw() {
  background(255);
  analyzer();
  
  for(int i = 0; i < cellcollection.length; i++){
  cellcollection[i].run(avg[0]);
  }
  /*
  cell1.run(avg[0]);
  cell2.run(avg[1]*4);
  cell3.run(avg[2]*8);
  */
  //println(fft.specSize(jingle.mix));
  //println(fft.spectrum(jingle.mix));
}

