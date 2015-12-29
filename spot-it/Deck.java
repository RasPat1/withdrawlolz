class Deck {
  Card[] cards;
  Integer deckSize;
  Integer imagesPerCard;

  public Deck(int deckSize, int imagesPerCard) {
    cards = new Card[deckSize];
    this.deckSize = deckSize;
    this.imagesPerCard = imagesPerCard;
  }

  public static Deck createRandomDeck(int deckSize, int imagesPerCard) {
    Deck deck = new Deck(deckSize, imagesPerCard);

    for (int i = 0; i < deckSize; i++) {
      deck.cards[i] = Card.getRandomCard(imagesPerCard);
    }

    return deck;
  }

  // public Boolean addCard(Card card) {
  //   if (card.imagesPerCard != imagesPerCard) {
  //     return false; // cannot have cards with different # of images per card
  //   }

  //   Boolean added = false;

  //   for (int i = 0; i < cards.length; i++) {
  //     if (cards[i] == null) {
  //       cards[i] = card;
  //       added = true;
  //     }
  //   }

  //   return added;
  // }

  public Card getCard(int cardIndex) {
    return cards[cardIndex];
  }

  public String toString() {
    StringBuffer deckString = new StringBuffer();

    for (int i = 0; i < deckSize; i++) {
      deckString.append("C" + i + ":" + this.getCard(i) + "\n");
    }

    return deckString.toString();
  }
}