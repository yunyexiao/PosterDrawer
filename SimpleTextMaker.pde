public class SimpleTextMaker {
  
  /**
   * Add a text on the screen.
   * @param text The text to be shown.
   * @param x The x position to put text.
   * @param y The y position to put text.
   * @param size The text size.
   * @param fillColor The text color. It should contain 3 or 4 integers representing RGB and opacity (optional) values separately.
   */
  public void addText(String text, int x, int y, int size, int[] fillColor) {
    //textSize(size);
    if (fillColor.length == 3) {
      fill(fillColor[0], fillColor[1], fillColor[2]);
    } else if (fillColor.length == 4) {
      fill(fillColor[0], fillColor[1], fillColor[2], fillColor[3]);
    }
    int numFonts = PFont.list().length;
    PFont font = createFont(PFont.list()[(int)(random(numFonts))], size);
    textFont(font);
    text(text, x, y);
  }
  
}
