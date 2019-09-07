/**
 * A detector to detect top k frequent colors in an image. 
 */
public class ThemeColorDetector {
  // A (color) cell means an interval of the R or G or B value of a color.
  private final int cellLength = 64;
  private final int cellCount = 256 / cellLength;
  private int topK;
  
  public ThemeColorDetector() {
    this(1);
  }
  
  /**
   * @param topK The number of colors to be extracted from the image.
   */
  public ThemeColorDetector(int topK) {
    this.topK = topK;
  }

  /**
   * Detect the top k frequent colors in the image.
   * @param img The PImage object to be processed.
   * @return An array of the top k frequent colors in a descending order.
   */
  public color[] detect(PImage img) {
    int[] pixCounts = new int[cellCount * cellCount * cellCount];
    int dimension = img.width * img.height;
    img.loadPixels();
    
    // Count pixels.
    for (int i = 0; i < dimension; ++i) {
      color p = img.pixels[i];
      int r = (int)red(p);
      int g = (int)green(p);
      int b = (int)blue(p);
      ++pixCounts[cellIndex(r, g, b)];
    }
    
    // Find top k elements.
    int[] indices = kMaxIndices(pixCounts);
    color[] colors = new color[topK];
    int diff = cellLength / 2 - 1;
    for (int i = 0; i < topK; ++i) {
      int[] rgb = cellRGB(indices[i]);
      // We use the middle RGB value of a cell.
      colors[i] = color(rgb[0] + diff, rgb[1] + diff, rgb[2] + diff);
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
  private int cellIndex(int r, int g, int b) {
    return r / cellLength * cellCount * cellCount + g / cellLength * cellCount + b / cellLength;
  }
  
  /**
   * Convert a cell index into RBG values.
   * @return A int array of length 3 containing the RGB values sequencially.
   */
  private int[] cellRGB(int index) {
    int r = index / (cellCount * cellCount) * cellLength;
    int remainder = index % (cellCount * cellCount);
    int g = remainder / cellCount * cellLength;
    int b = remainder % cellCount * cellLength;
    return new int[]{r, g, b};
  }

}
