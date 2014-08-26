//Program based on "Insane in the Chromatophores"

// Declare
float s = 0;   //Transmite los Avgs a los objetos
float r = 20;  //Establece el radio de las cells

int cellNumber = 200;

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
  
for (int i = 0; i < cellcollection.length; i++) {
    cellcollection[i] = new cell(random(0, width), random(0, height), random(2, 2), random(0, 7), random(0.001, 0.01));
  };
  
// Uncomment to see the whole spectrum arranged
//int xp = 0;
//  for (int i = 0; i < cellcollection.length; i++) {
//    xp += width/cellNumber;
//    cellcollection[i] = new cell(xp, height/2, random(2, 2), random(0, 7), random(0.001, 0.01));
//  }

}


void analyzer() {
  fft.forward(jingle.mix);  
  for (int i = 0; i < fft.specSize (); i++)
  {
    spec[i] = fft.getBand(i);
  }

  float sum = 0;

  for (int j = 0; j < cellNumber-1; ++j) {
    for (int i = j* (fft.specSize ()/cellNumber); i < ((j+1) * fft.specSize ()/cellNumber); i++) {
      sum = abs(sum + spec[i]);
      avg[j] = sum;
    };
  };
}

void draw() {
  background(255);
  analyzer();

  for (int i = 0; i < cellcollection.length; i++) {
    cellcollection[i].run(avg[i]);
  }
};

