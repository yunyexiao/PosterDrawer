// Use another file named BackgroundMaker.pde and StaticColorBackgroundMaker.pde.
BackgroundMaker bgMaker = new StaticColorBackgroundMaker();

void setup() {
  size(500, 700);
}

void draw() {
  bgMaker.drawBackground();
 //picture loading 
  PImage img = loadImage("/home/cirno/download/pikachu.jpg");
  image(img, 250, 450, 200, 200);
  //use class from another file named SimpleTextMaker.pde.
  SimpleTextMaker textMaker = new SimpleTextMaker();
  textMaker.addText("Pikachu!!!\nPikachu!!!", 100, 200, 20, new int[]{0, 0, 0});
  
  delay(500);
}
