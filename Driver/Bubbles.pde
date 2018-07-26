class Bubble extends PVector {
  float radius;
  color col;
  
  Bubble() {
    radius = 10;
    col = color(0, 0, 0);
  }
  
  Bubble(float r, color c) {
    radius = r;
    col = c;
  }
  
  void display() {
    ellipse(300, 300, radius, radius);
    fill(col);
  }
}
