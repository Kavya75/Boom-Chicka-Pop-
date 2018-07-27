class Bubble extends PVector {
  float radius;
  color col;
  int xPos;
  int yPos;
  int yDirection; 
  int xDirection;
  
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
  
  void display() {
    fill(col);
    ellipse(super.x, super.y, radius, radius);
    
  }
  
  void set(int xPos, int yPos) { 
    super.x = xPos;
    super.y = yPos;
  }
  
  void checkXEdges(int xBoundary) { 
  
    if(super.x + radius/2 > xBoundary)
      xDirection = -5;
    else if(super.x - radius/2 <= 0) 
      xDirection = 5;
  }
  void checkYEdges(int yBoundary) { 
    
    if(super.y + radius/2 > yBoundary)
      yDirection = -5;
    else if(super.y - radius/2 <= 0)
      yDirection = 5;
  
  }
  
  void setX(int xP) { super.x = xP; } 
  
  void setY(int yP) { super.y = yP; } 
  
  
  int getX() { 
    return int(super.x); 
  }
  
  int getY() {
    return int(super.y); 
  }
  
  int getXDir() { 
    return xDirection;
  }
  
  int getYDir() { 
    return yDirection;
  }
  
}
