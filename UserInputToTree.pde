String[] tempSt;
Unit u = new Unit("");
int timer = 0;
  int startTim = 0;

String sentence1 = "creativity is the coolest thing.";

String sentence2 = "creativity is not the coolest thing.";


//her's a comment
String inputWord;

PFont f;

// Variable to store text currently being typed
String typing = "";

// Variable to store saved text when return is hit
String saved = "";
String currentWord = "";

void setup() {
  simulateKeyPressed(sentence1);
  simulateKeyPressed(sentence2);
  simulateKeyPressed("creativity I love it.");

  size(1500,900);
  f = createFont("Arial",16,true);

  u.addChild("creativity");
//  u.addChild("could");
}

void draw() {
//  if(mousePressed == true){
  
  
//}
  background(255);
  int indent = 25; 
  // Set the font and fill for text
  textFont(f);
  fill(0);
  
  // Display everything
  text("Click in this applet and type. \nHit return to save what you typed. ", indent, 40);
//  text(typing,indent,90);
text("Your current definition:", indent, 90);
  text(typing, indent, 130);

//  text("currentWord: "+currentWord,indent,130);
//////  text("Your current definition: "+currentWord,indent,130);
//
//  
//  text("u.currentNode.self: "+u.currentNode.self,indent,170);
//  text("children:",indent, 210);
//  text("type length: "+typing.length(), indent, 240);
//  text("save length: "+saved.length(), indent, 270);

  Unit X;
  for (int i = 0; i<u.currentNode.children.size();i++){
    X = (Unit) u.currentNode.children.get(i);
    text(X.self,indent,250+40*i);
  }
    


  pushMatrix();
  translate(100, height/2);
  u.display();
  popMatrix();
  
}

//void keyPressed() {
  void simulateKeyPressed(String sentenceIn){

  for (int i = 0; i < sentenceIn.length(); i++){
//  while (millis() - startTim < 2000){}
//  startTim = millis();
  // If the return key is pressed, save the String and clear it

//  if (key == '\n') {
//   u.reset();
//   typing = "";
//   saved = "";
//   currentWord = "";
//  }
//  if (key == CODED){}else
  if (sentenceIn.charAt(i) == '.' ) {
    currentWord = saved;
    u.integrateWord(currentWord);
    u.reset();
   typing = "";
   saved = "";
   currentWord = "";
    
  } 
  if (sentenceIn.charAt(i) == ' '){
    currentWord = saved;
    typing = typing+' ';
    inputWord = typing;
    u.integrateWord(currentWord);
    timer = millis();

    saved = "";
  } else if (key == '\b'){
    if (saved.length()>=1){
//      saved = "";
//      
//    }else {
    typing = typing.substring(0, typing.length()-1);
    saved = saved.substring(0, saved.length()-1);
    }
  }
  else if (sentenceIn.charAt(i) != '.') {
    if (sentenceIn.charAt(i)==CODED){}else{
    // Otherwise, concatenate the String
    // Each character typed by the user is added to the end of the String variable.
    typing = typing + sentenceIn.charAt(i);
    saved = saved + sentenceIn.charAt(i); 
    }
  }
  
}
  }

class Unit {
  String self; ArrayList children; Unit currentNode;
  float rand = random(0,2*PI);
  Unit (String self_in){
    self = self_in;
    children = new ArrayList();
    currentNode = this;
  }
  void addChild(String child_self) {
    children.add(new Unit(child_self));

  }
  void display() {
    
    text(self, 0, 0);  
    int numSiblings = children.size();
    translate(textWidth(self),0);
    rotate(sin(this.rand+.005*millis())*(PI/256)*(10000/(millis()-timer))+(-PI/4));//+1/(millis()*.0001)
    rotate((PI/4)/(numSiblings));
    for (int i = 0; i< numSiblings; i++){
      Unit C = (Unit) children.get(i);          
      pushMatrix();
       line(0,0,100,0);
       translate(100,0);
       C.display();
      popMatrix();
      rotate((PI/2)/(numSiblings));
    }  
  }

  void integrateWord(String inputWord){
////    if(currentNode.self.equals("")){
//      translate(50,50);}
    // Find out how many children the current unit has (numSiblings).  
    int numSiblings = currentNode.children.size();
    // If there are no children, then the input word becomes a child of the current node.
    if (numSiblings==0) {
      currentNode.addChild(inputWord);
      // We added a child to the current node and now that child becomes the relevant node.      
      currentNode = (Unit) currentNode.children.get(0);      
    }
    // If there is already a child or a number of children, compare the input with them.
    else{
      int matchDetected = 0;
      Unit X;
      
      
      for (int i = 0; i<currentNode.children.size();i++){
        X = (Unit) currentNode.children.get(i);
      
          if (inputWord.equals(X.self)) {        

          currentNode = (Unit) currentNode.children.get(i);
          matchDetected = 1;
        }
        else if (i==(numSiblings-1) & matchDetected==0) {
          currentNode.addChild(inputWord); 
          text("passed this", 20,20);         
//          currentNode = (Unit) children.get(i+1);
        }
      }
    }
  }

  void reset(){
    currentNode = this;
  }
  
}
void mousePressed(){
  
}
