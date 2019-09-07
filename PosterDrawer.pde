// A (poster) cell means a chunk in the poster.
int numCell = 6;
int cellWidth, cellHeight;

// Background image path.
String imagePath = "wash.jpg";
// The background image.
ImageBackground imageBg;

// The number of colors to extract from the image.
int topK = 5;
// Top k colors.
color[] topKColors;

// Logo part.
Logo logo;
String logoPath = "logo.jpeg";
int logoHeight = 38; // 10mm ~= 38px
int[] logoCenter = {283, 30};

// Bottom layer.
BottomLayer bottom;
// Index of the color for bottom layer. Here we choose the 4th one for better accuracy.
int bottomColorIndex = 3;
// The ratio between the height of bottom layer and the poster.
float bottomRatio = 0.25;

// Text part.
TextUtils textUtils = new TextUtils();
ThemeColorDetector textColorHelper = new ThemeColorDetector(1);
// Text background color threshold.
int textBgColorThreshold = 120;
String fontName = "";


void setup() {
  // width * height ~= 90mm * 160mm ~= 340px * 604px, here we change it to be divided by 6.
  size(342, 606);
  cellWidth = width / numCell;
  cellHeight = height / numCell;
  
  // List all available font names in your computer.
  //printArray(PFont.list());

  imageBg = new ImageBackground(imagePath, width, height * (numCell - 1) / numCell);
  
  ThemeColorDetector detector = new ThemeColorDetector(topK);
  topKColors = detector.detect(imageBg.getImage());
  
  logo = new Logo(logoPath, logoHeight, logoCenter);
  
  bottom = new BottomLayer(topKColors[bottomColorIndex], bottomRatio);
}

void draw() {  
  imageBg.render();
  logo.render();
  bottom.render();
  
  // slogan column text
  int[] scBounds = {cellWidth / 2, height / 2, cellWidth, (int) (1.5 * cellHeight)};
  textUtils.addColumnText("竖版标语文字", scBounds, 24, textColor(scBounds), fontName);
  // slogan line text 
  int[] slBounds = {cellWidth * 3 / 2, cellHeight * 3 / 2, width / 2, height / 2};
  textUtils.addLineText("标语文字横版", slBounds, 24, textColor(slBounds), fontName);
  // bottom column text
  int[] bcBounds = {94, height - bottom.getHeight(), width / 2 - 94, bottom.getHeight()};
  textUtils.addColumnText("竖版底部文字", bcBounds, 20, textColor(bcBounds), fontName);
  // bottom left text
  int[] blBounds = {0, height - bottom.getHeight(), 94, bottom.getHeight()};
  textUtils.addLineText("底部左文字", blBounds, 18, textColor(blBounds), fontName);
  // bottom right text
  int[] brBounds = {width / 2, height - bottom.getHeight(), width / 2, bottom.getHeight()};
  textUtils.addLineText("底部右文字", brBounds, 18, textColor(brBounds), fontName);
  // top left text
  int[] tlBounds = {51, 30, 113, 38};
  textUtils.addLineText("上部左文字", tlBounds, 20, textColor(tlBounds), fontName);
  
  delay(500);
}

color textColor(int[] bounds) {
  color mainColor = textColorHelper.detect(get(bounds[0], bounds[1], bounds[2], bounds[3]))[0];
  int red = (int)red(mainColor);
  int green = (int)green(mainColor);
  int blue = (int)blue(mainColor);
  if ( red > textBgColorThreshold || green > textBgColorThreshold || blue > textBgColorThreshold) {
    return color(0, 0, 0);
  } else {
    return color(255, 255, 255);
  }
}

void testColorDetector() {
  PImage img = loadImage("tea.jpeg");
  ThemeColorDetector d = new ThemeColorDetector(topK);
  color[] colors = d.detect(img);
  for (color c: colors) {
    fill(c);
    rect(0, 0, 200, 200);
    delay(3000);
  }
}
