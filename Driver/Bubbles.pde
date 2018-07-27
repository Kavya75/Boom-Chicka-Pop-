class Bubble extends PVector {
  float radius;
  color col;
  int xPos;
  int yPos;
  
  Bubble() {
    radius = 10;
    col = color(0, 0, 0);
    xPos = displayWidth / 2;
    yPos = displayHeight / 2;
  }
  
  Bubble(float r, color c, int x, int y) {
    radius = r;
    col = c;
    xPos = x;
    yPos = y;
  }
  
  void display() {
    fill(col);
    ellipse(xPos, yPos, radius, radius);
    
  }

}
