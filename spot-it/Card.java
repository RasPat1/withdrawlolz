import java.util.Random;

class Card {
  CardImage[] images;
  Integer imageCount = 0;

  static Integer defaultSlots = 4;

  public Card() {
    this.images = new CardImage[4];
    this.imageCount = 0;
  }

  public static Card getRandomCard() {
    Card card = new Card();

    for (int i = 0; i < defaultSlots; i++) {
      Boolean added = false;
      while (!added) {
        added = card.addImage(CardImage.getRandomImage());
      }
    }

    return card;
  }

  /**
   * Add an image to the card at the first empty spot
   *
  **/
  public Boolean addImage(CardImage image) {
    Boolean added = false;

    if (containsImage(image)) {
      added = false;
    } else {
      images[imageCount] = image;
      added = true;
      imageCount++;
    }

    return added;
  }

  public Boolean containsImage(CardImage image) {
    Boolean hasImage = false;

    for (int i = 0; i < this.imageCount; i++) {
      if (image.isEqual(this.images[i])) {
        hasImage = true;
      }
    }

    return hasImage;
  }

  public String toString() {
    StringBuffer cardString = new StringBuffer();

    for (int i = 0; i < this.defaultSlots; i++) {
      if (i != 0) {
        cardString.append(" ");
      }

      cardString.append(this.images[i].toString());
    }

    return cardString.toString();
  }

}