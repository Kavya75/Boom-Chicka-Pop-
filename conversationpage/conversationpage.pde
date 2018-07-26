BufferedReader reader;
String line; 
String[] listOfFileNames = {"convo1.txt"};
void setup() {
  
  size(800, 600);
  int num = int(random(0,1));
  openFile(listOfFileNames[num]);
}

void draw() {
  background(0);
  ellipse(width/4, height/4, 50, 50); 
  ellipse(width/4*3, height/4, 50, 50);
  stroke(255);
  textSize(32); 
  textAlign(CENTER);
  
  
  if(line != null) { 
     text(line, width/4, height/2);
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
