/**
 * Spot it type card game
 *
**/

class Spot {
  public static void  main(String args[]) {
    createDeck();
  }

  public static void createDeck() {

    Card[] deck = new Card[10];
    for (int i = 0; i < deck.length; i++) {
      deck[i] = Card.getRandomCard();
    }

    for (int i = 0; i < deck.length; i++) {
      System.out.println(deck[i]);
    }

  }

  /**
   * Tests whether a deck of spot it cards is valid.
   * Tests each pair of cards in a deck and ensures
   * only one common image exists for each pair
   *
   **/
  Boolean testDeck(Card[] deck) {
    Boolean isGoodDeck = true;

    for (int i = 0; i < deck.length - 1; i++) {
      for (int j = i; j < deck.length; j++) {
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
  Boolean testPair(Card card1, Card card2) {
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

