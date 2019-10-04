// A (poster) cell means a chunk in the poster.
int numCell = 6;
int cellWidth, cellHeight;

// Background image path.
String imagePath = "food3.jpg";
// The background image.
ImageBackground imageBg;

// The number of colors to extract from the image.
int topK = 10;
// Top k colors.
color[] topKColors;

// Logo part.
Logo logo;
String logoPath = "logo.jpeg";
int logoHeight = 38; // 10mm ~= 38px
int[] logoCenter = {308, 38};

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
  int[] scBounds = {283, 75, cellWidth, (int) (1.8 * cellHeight)};
  textUtils.addColumnText("  巧克力的丝滑，与浓浓的草莓相结合", scBounds, 18, textColorByBrightness(scBounds), "Microsoft Yahei UI");
  // slogan line text 
  int[] slBounds = {19, 380, 75, 75};
  textUtils.addLineText("千年文化传承，千年坎坷磨琢，中华美食，色香味美。", slBounds, 12, textColorByBrightness(slBounds), "FZChaoCuHei-M10");
  
  // bottom column text
  int[] bcBounds = {132, 472, 75, 140};
  color bcColor = textColorByBrightness(bottom.getColor(), topKColors[0], 60, 0.5);
  textUtils.addColumnText(" 古道西风瘦马小桥流水人家", bcBounds, 16, bcColor, "FZChaoCuHei-M10");
  stroke(bcColor);
  strokeWeight(1);
  line(123, 472, 123, 590);
  stroke(bcColor);
  strokeWeight(1);
  line(170, 472, 170, 590);
  // bottom left text
  color bottomTextColor = textColorByBrightness(bottom.getColor(), topKColors[0], 60, 0.3);
  int[] bltBounds = {19, 472, 95, 49};
  textUtils.addLineText("千年文化传承，千年坎坷磨琢，中华美食，色香味美。", bltBounds, 10, bottomTextColor, "Microsoft Yahei UI");
  stroke(bottomTextColor);
  strokeWeight(1);
  line(19, 529, 113, 529);
  int[] blbBounds = {19, 540, 95, 49};
  textUtils.addLineText("风吹柳花满店香，吴姬压酒劝客尝！", blbBounds, 10, bottomTextColor, "Microsoft Yahei UI");
  // bottom right text
  stroke(bottomTextColor);
  strokeWeight(1);
  line(189, 535, 321, 535);
  int[] brtBounds = {189, 472, 132, 60};
  textUtils.addLineText("某街是合肥市与包河区两级政府合力打造的安徽省最大、最有特色的美食街区。整个街区分为室内特色餐饮集中区和室外开发式名小吃档口区。合肥某街特征集美食街区宣传标语，要求作品主题突出、寓意深刻，能体现某街作为美食街区的性质；作品简单易记，具有鲜明特色。", brtBounds, 10, bottomTextColor, "Microsoft Yahei UI");
  int[] brbBounds = {189, 540, 132, 38};
  textUtils.addLineText("封入罐中的是新鲜与健康。\n              --大陆罐幢食品公司", brbBounds, 10, bottomTextColor, "Microsoft Yahei UI");
  
  // top left text
  int[] tlBounds = {19, 19, 246, 50};
  textUtils.addLineText("I love life more than truth. Dessert is my favorite.", tlBounds, 18, textColorByBrightness(tlBounds), "Monotype Corsiva");
  
  delay(500);
}

color textColorByBrightness(int[] bounds) {
  color mainColor = textColorHelper.detect(get(bounds[0], bounds[1], bounds[2], bounds[3]))[0];
  colorMode(HSB);
  int brightness = (int) brightness(mainColor);
  colorMode(RGB);
  if (brightness > 60) {
    return color(0, 0, 0);
  } else {
    return color(255, 255, 255);
  }
}

color textColorByBrightness(color mainColor) {
  return textColorByBrightness(mainColor, 60);
}

color textColorByBrightness(color backColor, color mainColor, int threshold, float ratio) {
  int backB = (int) brightness(backColor);
  int h = (int) hue(mainColor);
  int s = (int) saturation(mainColor);
  int b = (int) brightness(mainColor);
  if(backB > threshold) {
    b *= (1 - ratio);
  } else {
    b *= (1 + ratio);
  }
  colorMode(HSB);
  color c = color(h, s, b);
  colorMode(RGB);
  return c;
}

color textColorByBrightness(color mainColor, int threshold) {
  int h = (int) hue(mainColor);
  int s = (int) saturation(mainColor);
  int b = (int) brightness(mainColor);
  if(b > threshold) {
    b *= (1 - 0.6);
  } else {
    b *= (1 + 0.6);
  }
  colorMode(HSB);
  color c = color(h, s, b);
  colorMode(RGB);
  return c;
}

// This function is not used anywhere.
// Just ignore it.
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
