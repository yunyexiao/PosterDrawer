/**
 * A background maker which provides a static-color background.
 */
public class StaticColorBackgroundMaker implements BackgroundMaker {
  
  public StaticColorBackgroundMaker() {
    // TODO: constructor stub
  }
  
  @Override
  public void drawBackground() {
    background(102, 204, 255);
  }
}
