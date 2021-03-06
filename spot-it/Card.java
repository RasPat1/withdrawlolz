import java.util.Random;

class Card {
  CardImage[] images;
  Integer imageCount = 0;
  Integer imagesPerCard;


  public Card(int imagesPerCard) {
    this.images = new CardImage[imagesPerCard];
    this.imageCount = 0;
    this.imagesPerCard = imagesPerCard;
  }


  public static Card getCard(int[] images, int imagesPerCard) {
    Card card = new Card(imagesPerCard);
    Boolean success = true;

    for (int i = 0; i < imagesPerCard; i++) {
      success = success && card.addImage(CardImage.getCardImage(images[i]));
    }

    return success ? card : null;
  }


  public static Card getRandomCard(int imagesPerCard) {
    Card card = new Card(imagesPerCard);

    for (int i = 0; i < imagesPerCard; i++) {
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

  public int[] extractIndexes() {
    int[] imageIndexes = new int[images.length];

    for (int i = 0; i < images.length; i++) {
      imageIndexes[i] = images[i].index;
    }

    return imageIndexes;
  }

  /**
   * Returns true if one and only one image is in common between
   * the pair of cards
   *
   **/
  static Boolean testPair(Card card1, Card card2) {
    int matchCount = 0;

    for (int i = 0; i < card1.images.length; i++) {
      for (int j = 0; j < card2.images.length; j++) {
        if (card1.images[i].isEqual(card2.images[j])) {
          matchCount++;
        }
      }
    }

    return matchCount == 1;
  }

  public String toString() {
    StringBuffer cardString = new StringBuffer();

    for (int i = 0; i < this.images.length; i++) {
      if (i != 0) {
        cardString.append(" ");
      }

      cardString.append(this.images[i].toString());
    }

    return cardString.toString();
  }

}