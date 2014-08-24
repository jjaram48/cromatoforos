class cell {

  //Globarl Variables
  float x = 0;
  float y = 0;
  float s = 0;
  float c;
  float f;
  
  color[] cromatoforos = {
  //Blues & Greens
  #A8CFBD, 
  #63B4A3, 
  #508A8C, 
  #ACF4CE, 
  #B2E2CA, 
  #7AD0C5, 
  #62FDFF, 
  #42FDEA, 
//Pinks & Purples
  #F8356F,
  #FF7EA6,
  #F95D68,
  #F7414E,
  #D88380,
  #DEA7AC,
  #E97091,
  #99285E
};

color[] palette = cromatoforos;

  //Constructor 
  //  (posx, posy, s, 
  cell(float _x, float _y, float _r, float _c, float _f) {
    x = _x;
    y = _y;
    r = _r;
    c = _c;
    f = _f;
  }

  //Functions
  void run(float _s) {
    s = _s * f;
    display();
    //beat();
  }

  void display() {
    fill(palette[int(c)]);
    ellipse(x, y, s+20, s+20);
  }
}

