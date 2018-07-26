BufferedReader reader;
String line; 

void setup() {
  
  size(800, 600);
  openFile("practice.txt");
}

void draw() {
  background(0);
  ellipse(width/4, height/4, 50, 50); 
  ellipse(width/4*3, height/4, 50, 50);
  stroke(255);
  textSize(32); 
  textAlign(LEFT);
  
  
  if(line != null) { 
     text(line, width/3, 50);
     delay(800);
   }
   
  try { 
     line = reader.readLine();
  } catch(IOException e) { 
      e.printStackTrace();
      line = null;
  }
 
   
}

void openFile(String fileName) {
  reader = createReader(fileName);
  
}

//void readInput() {}
