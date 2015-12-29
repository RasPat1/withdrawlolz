class Deck {
  Card[] cards;
  Integer deckSize;

  public Deck(int deckSize) {
    cards = new Card[deckSize];
    this.deckSize = deckSize;
  }

  public static Deck createRandomDeck(int deckSize) {
    Deck deck = new Deck(deckSize);

    for (int i = 0; i < deckSize; i++) {
      deck.cards[i] = Card.getRandomCard();
    }

    return deck;
  }

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