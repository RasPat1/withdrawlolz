import java.util.Random;

class CardImage {
  Integer id;
  String data;

  static Integer imageCount = 0;
  static String[] imageTypes =
  {
  //   "cheese", "tree", "camera",
  //   "clock", "candle", "hotel",
  //   "peanut", "hand", "bookcase",
  //   "canoe", "vase", "bicycle",
  //   "bell", "paper", "potato",
  //   "mouse", "towel", "river",
  //   "computer", "trampoline", "chair"
  "1", "2", "3", "4", "5", "6", "7", "8", "9",
  "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
  "20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
  "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
  "40", "41", "42", "43", "44", "45", "46", "47", "48", "49",
  "50", "51", "52", "53", "54", "55", "56", "57"
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