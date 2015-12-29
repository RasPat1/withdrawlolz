/**
 * Spot it type card game
 *
**/

class Spot {
  public static void  main(String args[]) {
    Long startTime = System.currentTimeMillis();

    Card[] goodDeck = createValidDeck(8);
    Boolean isGoodDeck = testDeck(goodDeck);

    Long endTime = System.currentTimeMillis();

    System.out.println("Deck built in: " + (endTime - startTime));

    if (isGoodDeck) {
      System.out.println("Deck is valid");
    } else {
      System.out.println("Deck is invalid");
    }

    for (int i = 0; i < goodDeck.length; i++) {
      System.out.println(goodDeck[i]);
    }

  }

  public static Card[] createValidDeck(int deckSize) {
    Boolean isGoodDeck = false;
    Card[] deck = null;

    while (!isGoodDeck) {
      deck = createDeck(deckSize);
      isGoodDeck = testDeck(deck);
    }

    return deck;
  }

  public static Card[] createDeck(int deckSize) {

    Card[] deck = new Card[deckSize];
    for (int i = 0; i < deck.length; i++) {
      deck[i] = Card.getRandomCard();
    }

    return deck;
  }

  /**
   * Tests whether a deck of spot it cards is valid.
   * Tests each pair of cards in a deck and ensures
   * only one common image exists for each pair
   *
   **/
  static Boolean testDeck(Card[] deck) {
    Boolean isGoodDeck = true;

    for (int i = 0; i < deck.length - 1; i++) {
      for (int j = i + 1; j < deck.length; j++) {
        Card card1 = deck[i];
        Card card2 = deck[j];
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

