public class HSBColorDetector {
  private final int hCellLength = 1;
  private final int sbCellLength = 20;
  private final int hCellCount = 360 / hCellLength;
  private final int sbCellCount = 100 / sbCellLength;
  
  private int topK;

  public HSBColorDetector(int topK) {
    this.topK = topK;
  }
  
  public color[] detect(PImage img) {
    int[] pixCounts = new int[hCellCount * sbCellCount * sbCellCount];
    int dimension = img.width * img.height;
    colorMode(HSB, 359, 99, 99);
    img.loadPixels();
    
    // Count pixels.
    for (int i = 0; i < dimension; ++i) {
      color p = img.pixels[i];
      int h = (int)hue(p);
      int s = (int)saturation(p);
      int b = (int)brightness(p);
      //println("" + h + " " + s + " " + b);
      ++pixCounts[cellIndex(h, s, b)];
    }
    colorMode(RGB);
    
    // Find top k elements.
    int[] indices = kMaxIndices(pixCounts);
    color[] colors = new color[topK];
    for (int i = 0; i < topK; ++i) {
      int[] hsb = cellHSB(indices[i]);
      // We use the middle RGB value of a cell.
      colors[i] = color(hsb[0], hsb[1] + random(sbCellLength), hsb[2] + random(sbCellLength));
    }
    return colors;
  }
  
  /**
   * Find indices of the top k values in data (an array of counts of different colors).
   */
  private int[] kMaxIndices(int[] data) {
    int k = topK;
    int[] kValues = new int[k];
    int[] kIndices = new int[k];
    // Apply insertion sort.
    for (int i = 0; i < data.length; ++i) {
      boolean inserted = false;
      for (int j = 0; j < k && !inserted; ++j) {
        if (data[i] > kValues[j]) {
          for (int l = k - 1; l > j; --l) {
            kValues[l] = kValues[l - 1];
            kIndices[l] = kIndices[l - 1];
          }
          kValues[j] = data[i];
          kIndices[j] = i;
          inserted = true;
        }
      }
    }
    return kIndices;
  }
  
  /**
   * Convert RGB value into its corresponding cell index.
   */
  private int cellIndex(int h, int s, int b) {
    return h / hCellLength * sbCellCount * sbCellCount + s / sbCellLength * sbCellCount + b / sbCellLength;
  }
  
  /**
   * Convert a cell index into RBG values.
   * @return A int array of length 3 containing the RGB values sequencially.
   */
  private int[] cellHSB(int index) {
    int h = index / (hCellCount * sbCellCount) * hCellLength;
    int remainder = index % (hCellCount * sbCellCount);
    int s = remainder / sbCellCount * sbCellLength;
    int b = remainder % sbCellCount * sbCellLength;
    return new int[]{h, s, b};
  }

}
