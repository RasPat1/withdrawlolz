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

    // testWrapper(6, 4, 5, stats);
    // testWrapper(6, 5, 5, stats);
    // testWrapper(6, 6, 5, stats);
   // testWrapper(7, 4, 5, stats);
    // testWrapper(7, 5, 5, stats);
    // testWrapper(7, 6, 5, stats);
    // testWrapper(7, 7, 5, stats);
    // testWrapper(8, 4, 5, stats);
    // testWrapper(8, 5, 5, stats);
   // testWrapper(8, 6, 5, stats);
    // testWrapper(8, 7, 5, stats);
    // testWrapper(8, 8, 5, stats);
    // testWrapper(9, 4, 5, stats);
    // testWrapper(9, 5, 5, stats);
    // testWrapper(9, 7, 5, stats);
   // testWrapper(9, 9, 5, stats);
    testWrapper(25, 8, 1, stats); // Lol

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
      Deck goodDeck = Deck.createValidDeck(deckSize, imagesPerCard, stat);
    }

    System.out.println(stat);
    stats.add(stat);
  }

}

