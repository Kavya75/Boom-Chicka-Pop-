class Bubble extends PVector {
  float radius;
  color col;
  int xPos;
  int yPos;
  
  Bubble() {
    radius = 10;
    col = color(0, 0, 0);
  }
  
  Bubble(float r, color c) {
    radius = r;
    col = c;
  }
  
  void display() {
    fill(col);
    ellipse(300, 300, radius, radius);
    
  }

}
