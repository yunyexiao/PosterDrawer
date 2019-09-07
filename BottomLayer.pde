public class BottomLayer {
  private color c;
  private int x, y; // The top-left corner of the layer.
  private int w;
  private int h;

  public BottomLayer(color c, float bottomRatio) {
    // The process of drawing bottom layer.
    this.c = c;
    w = width;
    h = (int) (height * bottomRatio);
    x = 0;
    y = height - h;
  }
  
  public void render() {
    fill(c);
    noStroke();
    rect(x, y, w, h);
  }
  
  public color getColor() {
    return c;
  }
  
  public int getX() {
    return x;
  }
  
  public int getY() {
    return y;
  }
  
  public int getWidth() {
    return w;
  }
  
  public int getHeight() {
    return h;
  }
  
}
