/**
 * Spot it type card game
 *
**/

import java.util.ArrayList;
import java.util.Date;

class Spot {
  public static void  main(String args[]) {
    testingSuite();
  }


  /**
  *  Try generating several different combinations of deckSizes and
  *  imagesPerCard and gathering statistics on how difficult it is
  *  Important metrics: Time taken, Decks generated, Cards Generated
  *
  **/
  public static void testingSuite() {
    System.out.println(new Date());
    ArrayList<Stat> stats = new ArrayList<Stat>();

    testWrapper(6, 4, 1, stats);
    // testWrapper(6, 5, 5, stats);
    // testWrapper(6, 6, 5, stats);
//    testWrapper(7, 4, 5, stats);
    // testWrapper(7, 5, 5, stats);
    // testWrapper(7, 6, 5, stats);
    // testWrapper(7, 7, 5, stats);
    // testWrapper(8, 4, 5, stats);
    // testWrapper(8, 5, 5, stats);
//    testWrapper(8, 6, 5, stats);
    // testWrapper(8, 7, 5, stats);
    // testWrapper(8, 8, 5, stats);
    // testWrapper(9, 4, 5, stats);
    // testWrapper(9, 5, 5, stats);
    // testWrapper(9, 7, 5, stats);
//    testWrapper(9, 9, 5, stats);

    Long totalTimeTaken = 0L;
    Long totalDecksBuilt = 0L;
    Long totalCardsBuilt = 0L;
    for (int i = 0; i < stats.size(); i++) {
      Stat stat = stats.get(i);
      totalTimeTaken += stat.timeTaken;
      totalDecksBuilt += stat.decksBuilt;
      totalCardsBuilt += stat.cardsBuilt;
    }

    System.out.println("totalCardsBuilt:" + totalCardsBuilt);
    System.out.println("totalDecksBuilt:" + totalDecksBuilt);
    System.out.println("totalTimeTaken:" + totalTimeTaken);

  }

  public static void testWrapper(int deckSize, int imagesPerCard,
                                int trials, ArrayList<Stat> stats) {
    Stat stat = new Stat(deckSize, imagesPerCard);

    for (int i = 0; i < trials; i++) {
      Deck goodDeck = createValidDeck(deckSize, imagesPerCard, stat);
    }

    System.out.println(stat);
    stats.add(stat);
  }

  public static Deck createValidDeck(int deckSize, int imagesPerCard,
                                     Stat stat) {
    Boolean isGoodDeck = false;
    Deck deck = null;
    Long bailOutCount = (long) Math.pow(10, 8);

    stat.start();

    while (!isGoodDeck && stat.decksBuilt < bailOutCount) {
      deck = Deck.createRandomDeck(deckSize, imagesPerCard, stat);
      isGoodDeck = testDeck(deck);
      stat.deckBuilt();
    }

    stat.end();
    if (isGoodDeck) {
      stat.successfulTrial();
    }

    System.out.println(deck);

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

