public class Logo {
  private PImage logoImg;
  private int x, y; // (x, y) of the center point of the logo.
  private int w, h;

  public Logo(String filePath, int h, int[] centerPoint) {
    PImage img = loadImage(filePath);
    logoImg = img;
    x = centerPoint[0];
    y = centerPoint[1];
    w = (int) (img.width * 1.0 / img.height * h);
    this.h = h;
  }
  
  public void render() {
    // The process of drawing logo.
    imageMode(CENTER);
    image(logoImg, x, y, w, h);
  }
  
  public PImage getImage() {
    return logoImg;
  }
  
  public int getCenterX() {
    return x;
  }
  
  public int getCenterY() {
    return y;
  }
  
  public int getWidth() {
    return w;
  }
  
  public int getHeight() {
    return h;
  }
  
}
