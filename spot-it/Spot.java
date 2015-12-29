/**
 * Spot it type card game
 *
**/

class Spot {
  public static void  main(String args[]) {
    Stat stat = new Stat(6, 5);
    Deck goodDeck = createValidDeck(6, 5, stat);

    System.out.println(stat);
    System.out.println(goodDeck);
  }


  /**
  *  Try generating several different combinations of deckSizes and
  *  imagesPerCard and gathering statistics on how difficult it is
  *  Important metrics: "Time taken, Decks generated, Cards Generated"
  *
  **/
  public static void testingSuite() {
    // Stat stat = new Stat(deckSize, imagesPerCard);
    // stat.start();
    // Deck goodDeck = createValidDeck(deckSize, imagesPerCard, stat);
    // stat.end();
  }

  public static Deck createValidDeck(int deckSize, int imagesPerCard, Stat stat) {
    Boolean isGoodDeck = false;
    Deck deck = null;

    stat.start();

    while (!isGoodDeck) {
      deck = Deck.createRandomDeck(deckSize, imagesPerCard, stat);
      isGoodDeck = testDeck(deck);
      stat.deckBuilt();
    }

    stat.end();

    return deck;
  }

  /**
   * Tests whether a deck of spot it cards is valid.
   * Tests each pair of cards in a deck and ensures
   * only one common image exists for each pair
   *
   **/
  static Boolean testDeck(Deck deck) {
    Boolean isGoodDeck = true;

    for (int i = 0; i < deck.deckSize - 1; i++) {
      for (int j = i + 1; j < deck.deckSize; j++) {
        Card card1 = deck.getCard(i);
        Card card2 = deck.getCard(j);
        isGoodDeck = isGoodDeck && testPair(card1, card2);
        if (!isGoodDeck) {
          return false;
        }
      }
    }

    return isGoodDeck;
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
}

