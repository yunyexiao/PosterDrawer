public class ImageBackground {
  private PImage img;
  private int w; // image display width
  private int h; // image display height

  public ImageBackground(String imagePath, int maxWidth, int maxHeight) {
    img = loadImage(imagePath);
    w = maxWidth;
    h = min((int) (img.height * 1.0 / img.width * w), maxHeight);
  }
  
  public void render() {
    // The process of drawing background.
    imageMode(CORNER);
    image(img, 0, 0, w, h);
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
