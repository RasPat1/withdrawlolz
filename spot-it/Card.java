import java.util.Random;

class Card {
  Integer id;
  CardImage[] images;

  static Integer deckSize = 0;
  static Integer defaultSlots = 4;

  public Card() {
    deckSize++;
    this.id = deckSize;
    this.images = new CardImage[4];
  }

  public static Card getRandomCard() {
    Card card = new Card();

    for (int i = 0; i < defaultSlots; i++) {
      card.addImage(CardImage.getRandomImage());
    }

    return card;
  }

  /**
   * Add an image to the card at the first empty spot
   *
  **/
  public void addImage(CardImage image) {
    for (int i = 0; i < images.length; i++) {
      if (images[i] == null) {
        images[i] = image;
        break;
      }
    }
  }

  public String toString() {
    StringBuffer cardString = new StringBuffer();
    cardString.append("C" + this.id + ":");

    for (int i = 0; i < this.defaultSlots; i++) {
      if (i != 0) {
        cardString.append(" ");
      }

      cardString.append(this.images[i].toString());
    }

    return cardString.toString();
  }

}