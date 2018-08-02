
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
  int randImg;

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

  Bubble(float r, color c, int x, int y, float xDir, float yDir, int imgLength) {
    super(x, y);
    radius = r;
    col = c;
    yDirection = xDir; 
    xDirection = yDir;
    randImg = int(random(imgLength));
  }

  void display() {
    fill(col);
    ellipseMode(CENTER);
    ellipse(super.x, super.y, radius * 2, radius * 2);
    if (getRadius() != 0)
    image(pics[randImg], super.x-radius/4, super.y-radius/4, 25, 35);
  }

  void checkXEdges(int xBoundary) { 
    if (super.x + radius/2 > xBoundary)
      xDirection *= -1;
    else if (super.x - radius/2 <= 0) 
      xDirection *= -1;
  }

  void checkYEdges(int yBoundary) { 
    if (super.y + radius/2 > yBoundary)
      yDirection *= -1;
    else if (super.y - radius/2 <= 0)
      yDirection *= -1;
  }
  
  //Pauses the bubble movement 
  void pause() {
    xDirection = 0;
    yDirection = 0;
  }
  
  //Resumes the bubble movement
  void unPause(float xDirection, float yDirection) {
    this.xDirection = xDirection;
    this.yDirection = yDirection;
  }
  
  void set(int xPos, int yPos) { 
    super.x = xPos;
    super.y = yPos;
  }

  void setX(float xP) { 
    super.x = xP;
  } 

  void setY(float yP) { 
    super.y = yP;
  } 

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

  float distanceFormula(float x1, float x2, float y1, float y2) {
    return sqrt(sq((x1 - x2)) + sq((y1 - y2)));
  }

  boolean checkCollision(Bubble otherBub) {
    float dis = (distanceFormula(super.x, otherBub.getX(), super.y, otherBub.getY()));

    if (otherBub.getRadius() == 0)
      return false;
    else if (dis <= (getRadius() + otherBub.getRadius()))
      return true;
    return false;
  }
}
