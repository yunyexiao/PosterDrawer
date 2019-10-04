public class ImageBackground {
  private PImage img;
  private int x, y;
  private int w; // image display width
  private int h; // image display height

  public ImageBackground(String imagePath, int maxWidth, int maxHeight) {
    img = loadImage(imagePath);
    x = 0;
    w = maxWidth;
    h = (int) (img.height * 1.0 / img.width * w);
    y = min(0, maxHeight - h);
  }
  
  public void render() {
    // The process of drawing background.
    imageMode(CORNER);
    image(img, x, y, w, h);
  }
  
  public PImage getImage() {
    return img;
  }
  
  public int getDisplayWidth() {
    return w;
  }
  
  public int getDisplayHeight() {
    return h;
  }

}
