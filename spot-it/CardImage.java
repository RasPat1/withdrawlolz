import java.util.Random;

class CardImage {
  Integer id;
  String data;

  static Integer imageCount = 0;
  static String[] imageTypes =
  {
    "cheese", "tree", "camera",
    "clock", "candle", "hotel",
    "peanut", "hand", "bookcase",
    "canoe", "vase", "bicycle",
    "bell", "paper", "potato",
    "mouse", "towel", "river",
    "computer", "trampoline", "chair"
  };
  static Random random = new Random();

  public CardImage(String data) {
    imageCount++;
    this.id = imageCount;
    this.data = data;
  }

  public static CardImage getCardImage(int imageIndex) {
    return new CardImage(imageTypes[imageIndex]);
  }

  public static int getCardImageCount() {
    return imageTypes.length;
  }

  public String toString() {
    return data;
  }

  public static CardImage getRandomImage() {
    int randomInt = random.nextInt(imageTypes.length);
    return new CardImage(imageTypes[randomInt]);
  }

  /**
   * Two cardImages are equal if tehy have the same data
   *
   **/
  Boolean isEqual(CardImage otherImage) {
    return otherImage.data.equals(this.data);
  }

}