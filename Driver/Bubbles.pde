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
  
  Bubble(float r, color c, int x, int y, int xDir, int yDir) {
    super(x, y);
    radius = r;
    col = c;
    yDirection = xDir; 
    xDirection = yDir;
   
   
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
  void setColor(int one, int two, int three) { 
    col = color(one, two, three);
  }
  
  float getRadius() { 
    return radius;
  }
  void setRadius(int r) {
    radius = r; 
  }
  
  void checkCollision(Bubble otherBub) { 
     if((super.x + radius/2 > otherBub.getX() && super.x < otherBub.getX())
    && (super.y > otherBub.getY() && super.y < otherBub.getY() + radius/2))
      setRadius(0);
    else if(super.x < otherBub.getX() + otherBub.getRadius()/2 && super.x + radius/2 > otherBub.getX()
      &&  (super.y > otherBub.getY() && super.y < otherBub.getY() + radius/2)) 
      setRadius(0);
 
  }
}
