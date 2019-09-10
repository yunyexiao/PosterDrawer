public class TextUtils {
  
  /**
   * Add a text on the screen.
   * @param text The text to be shown.
   * @param bounds The bounding rectangle of the text box in the form of (x, y, w, h).
   * @param size The text size.
   * @param fillColor The text color. It should contain 3 or 4 integers representing RGB and opacity (optional) values separately.
   * @param font The text font.
   * @param line Whether the text is in lines or columns.
   */
  public void addText(String text, int[] bounds, int size, color fillColor, String font, boolean line) {
    //textSize(size);
    fill(fillColor);
    textFont(createFont(font, size));
    int x = bounds[0], y = bounds[1], w = bounds[2], h = bounds[3];
    if (line) {
      text(text, x, y, w, h);
    } else {
      // Rearrange the text into columns. 
      int colCharCount = h / size;
      int colCount = (text.length() - 1) / colCharCount + 1;
      for (int i = 0; i < colCount; ++i) {
        int maxIndex = min((i + 1) * colCharCount, text.length());
        String colText = text.substring(i * colCharCount, maxIndex);
        textLeading(size);
        text(colText, x + i * size, y, size + 1, h);
      }
    }
  }
  
  public void addLineText(String text, int[] bounds, int size, color fillColor, String font) {
    addText(text, bounds, size, fillColor, font, true);
  }
  
  public void addColumnText(String text, int[] bounds, int size, color fillColor, String font) {
    addText(text, bounds, size, fillColor, font, false);
  }
  
}
