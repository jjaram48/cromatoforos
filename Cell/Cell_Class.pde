class cell {

  //Globarl Variables
  float x = 0;
  float y = 0;
  float s = 0;

  //Constructor 
  //  (posx, posy, s, 
  cell(float _x, float _y, float _r) {
    x = _x;
    y = _y;
    r = _r;
  }

  //Functions
  void run(float _s) {
    s = _s;
    display();
    //beat();
  }

  void display() {
    fill(0);
    ellipse(x, y, s, s);
  }
}

