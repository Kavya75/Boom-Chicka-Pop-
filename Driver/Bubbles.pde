class Bubble extends PVector {
  float radius;
  color col;
  
  Bubble() {
    radius = 5;
    col = color(0, 0, 0);
  }
  
  Bubble(float r, color c) {
    radius = r;
    col = c;
  }
}
