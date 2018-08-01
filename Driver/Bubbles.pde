import processing.sound.*;
import ddf.minim.*;
class Bubble extends PVector {
  float radius;
  color col;
  int xPos;
  int yPos;
  float xDirection;
  float yDirection; 
  String i;
  
  Bubble() {
    radius = 10;
    col = color(0, 0, 0);
    xPos = displayWidth / 2;
    yPos = displayHeight / 2;
  }
  
  Bubble(float r, color c, int x, int y) {
    super(x, y);
    radius = r;
    col = c;
    yDirection = 5; 
    xDirection = 5;
  }
  
  Bubble(float r, color c, int x, int y, float xDir, float yDir) {
    super(x, y);
    radius = r;
    col = c;
    yDirection = xDir; 
    xDirection = yDir;
  }
  
  void display() {
    fill(col);
    ellipse(super.x, super.y, radius, radius);
    if(getRadius() != 0)
      image(img, super.x-radius/4, super.y-radius/4, 25, 35);
  }
  
  void set(int xPos, int yPos) { 
    super.x = xPos;
    super.y = yPos;
  }
  
  void checkXEdges(int xBoundary) { 
    if(super.x + radius/2 > xBoundary)
      xDirection *= -1;
    else if(super.x - radius/2 <= 0) 
      xDirection *= -1;
  }
  
  void checkYEdges(int yBoundary) { 
    if(super.y + radius/2 > yBoundary)
      yDirection *= -1;
    else if(super.y - radius/2 <= 0)
      yDirection *= -1;
  }
  
  void setX(float xP) { super.x = xP; } 
  
  void setY(float yP) { super.y = yP; } 
  
  void setXDir(float xDir) {
    xDirection = xDir;
  }
  
  void setYDir(float yDir) {
    yDirection = yDir;  
  }
  
  void setRadius(float r) {
    radius = r; 
  }
  
  void setColor(int one, int two, int three) { 
    col = color(one, two, three);
  }
  
  float getX() { 
    return int(super.x); 
  }
  
  float getY() {
    return int(super.y); 
  }
  
  float getXDir() { 
    return xDirection;
  }
  
  float getYDir() { 
    return yDirection;
  }
  
  float getRadius() { 
    return radius;
  }
  
  boolean checkCollision(Bubble otherBub) {
    if(getRadius() == 0)
       return false;
     else if((super.x + radius/2 > otherBub.getX() && super.x < otherBub.getX())
    && (super.y > otherBub.getY() && super.y < otherBub.getY() + radius/2)) {
      pop.play();
      return true;
    }
    else if(super.x < otherBub.getX() + otherBub.getRadius()/2 && super.x + radius/2 > otherBub.getX()
      &&  (super.y > otherBub.getY() && super.y < otherBub.getY() + radius/2)) {
      pop.play();
      return true;
     } 
     return false;
  }
}
