import java.util.ArrayList;
import java.util.Random;

class Deck {
  Card[] cards;
  Integer deckSize;
  Integer imagesPerCard;
  Integer cardsInDeck = 0;

  static Random random = new Random();

  public Deck(int deckSize, int imagesPerCard) {
    cards = new Card[deckSize];
    this.deckSize = deckSize;
    this.imagesPerCard = imagesPerCard;
  }

  public static Deck createRandomDeck(int deckSize, int imagesPerCard, Stat stat) {
    Deck deck = new Deck(deckSize, imagesPerCard);
    Card card = null;

    for (int i = 0; i < deckSize; i++) {
      card = Card.getRandomCard(imagesPerCard);
      deck.addCard(card);
      stat.cardBuilt();
    }

    return deck;
  }

  /**
  *  Make a valid deck by only adding valid cards
  *
  **/
  public static Deck createValidDeck(int deckSize, int imagesPerCard, Stat stat) {
    stat.start();
    stat.deckBuilt();

    Deck deck = new Deck(deckSize, imagesPerCard);
    Card testCard = getSeedCard(imagesPerCard);
    deck.addCard(testCard);

    Long cardBailOutCount = (long) (4*Math.pow(10, 9)); // arbitrary
    Long deckBailOutCount = (long) Math.pow(10, 3);

    while (deck.cardsInDeck < deckSize && stat.decksBuilt < deckBailOutCount) {
      testCard = getNextCard(testCard);
      stat.cardBuilt();

      if (deck.canBeAdded(testCard)) {
        deck.addCard(testCard);
        System.out.println("Cards in deck:" + deck.cardsInDeck);
        System.out.println(deck);
      }

      // Start over if we've searched a lot of cards and have yet to find one that works
      if (stat.cardsBuilt >= (cardBailOutCount * stat.decksBuilt)) {
        System.out.println("Cards in deck:" + deck.cardsInDeck);
        deck.removeRandomCard();
        stat.deckBuilt();
      }
    }

    if (testDeck(deck)) {
      stat.successfulTrial();
      System.out.println(deck);
    }

    stat.end();
    return deck;
  }

  /**
  *  Make a valid deck be randomly adding cards
  *
  **/
  public static Deck createValidRandomDeck(int deckSize, int imagesPerCard, Stat stat) {
    Boolean isGoodDeck = false;
    Deck deck = null;
    Long bailOutCount = (long) Math.pow(10, 8);

    stat.start();

    while (!isGoodDeck && stat.decksBuilt < bailOutCount) {
      deck = Deck.createRandomDeck(deckSize, imagesPerCard, stat);
      isGoodDeck = Deck.testDeck(deck);
      stat.deckBuilt();
    }

    stat.end();
    if (isGoodDeck) {
      stat.successfulTrial();
    }

    System.out.println(deck);

    return deck;
  }

  public Boolean canBeAdded(Card card) {
    Boolean canBeAdded = true;

    for (int i = 0; i < cardsInDeck; i++) {
      canBeAdded = canBeAdded && Card.testPair(cards[i], card);
    }

    return canBeAdded;
  }

  public Boolean addCard(Card card) {
    Boolean added = false;

    if (card.imagesPerCard != imagesPerCard) {
      added = false; // cannot have cards with different # of images per card
    } else {
      cards[cardsInDeck] = card;
      cardsInDeck++;
      added = true;
    }

    return added;
  }

  public Boolean removeRandomCard() {
    Boolean removed;

    if (cardsInDeck == 0) {
      removed = false;
    } else {
      int randomIndex = random.nextInt(cardsInDeck);
      Card card = cards[cardsInDeck - 1];
      cards[cardsInDeck - 1] = null;
      cardsInDeck--;
      cards[randomIndex] = card;
      removed = true;
    }

    return removed;
  }

  public Card getCard(int cardIndex) {
    return cards[cardIndex];
  }

  /**
  *  Imply an ordering to the cards.  Start with a seed card and then get teh next card.
  *  If the cards are well ordered and you start with the first card you will end up trying every card.
  *
  **/
  public static Card getNextCard(Card startCard) {
    int[] imageIndexes = startCard.extractIndexes();
    int max = CardImage.getCardImageCount();
    int imagesPerCard = startCard.imagesPerCard;

    Card nextCard = null;

    while (nextCard == null) {
      int[] nextImageIndexes = increment(imageIndexes, imagesPerCard - 1, max - 1);
      nextCard = Card.getCard(nextImageIndexes, imagesPerCard);
    }

    return nextCard;
  }

  public static Card getSeedCard(int imagesPerCard) {
    int[] imageIndexes = new int[imagesPerCard];

    // populate imageIndexes value with defaults: [0,1,2,3]
    for (int i = 0; i < imageIndexes.length; i++) {
      imageIndexes[i] = i;
    }

    return Card.getCard(imageIndexes, imagesPerCard);
  }

  public static Card[] makeAllCards(int imagesPerCard) {

    int max = CardImage.getCardImageCount();
    int[] imageIndexes = new int[imagesPerCard];
    ArrayList<Card> cards = new ArrayList<Card>();

    // populate imageIndexes value with defaults: [0,1,2,3]
    for (int i = 0; i < imageIndexes.length; i++) {
      imageIndexes[i] = i;
    }

    int count = 0;
    int index = imageIndexes.length - 1;

    while (imageIndexes != null) {
      cards.add(Card.getCard(imageIndexes, imagesPerCard));
      imageIndexes = increment(imageIndexes, imagesPerCard - 1, max - 1);
    }
    Card[] allCards = new Card[cards.size()];
    return cards.toArray(allCards);
  }

  public static int[] increment(int[] start, int pos, int max) {
    if (pos == -1) {
      for (int i = 0; i < start.length; i++) {
        start[i] = 0;
      }
      return start;
    }

    if (start[pos] == max) {
      start[pos] = 0;
      start = increment(start, pos - 1, max - 1);
    } else {
      start[pos]++;
    }

    return start;
  }


  /**
   * Tests whether a deck of spot it cards is valid.
   * Tests each pair of cards in a deck and ensures
   * only one common image exists for each pair
   *
   **/
  public static Boolean testDeck(Deck deck) {
    Boolean isGoodDeck = true;
    if (deck.cardsInDeck != deck.deckSize) {
      return false;
    }


    for (int i = 0; i < deck.deckSize - 1; i++) {
      for (int j = i + 1; j < deck.deckSize; j++) {
        Card card1 = deck.getCard(i);
        Card card2 = deck.getCard(j);
        isGoodDeck = isGoodDeck && Card.testPair(card1, card2);
        if (!isGoodDeck) {
          return false;
        }
      }
    }

    return isGoodDeck;
  }

  /**
  * Test for increment and next card.  Inspect manually.
  *
  **/
  public static void testNextCard(int imagesPerCard) {
    Card seedCard = getSeedCard(imagesPerCard);
    Card nextCard = null;

    for (int i = 0; i < 20; i++) {
      nextCard = getNextCard(seedCard);
      System.out.println(nextCard);
      seedCard = nextCard;
    }

  }

  public String toString() {
    StringBuffer deckString = new StringBuffer();

    for (int i = 0; i < cardsInDeck; i++) {
      deckString.append("C" + i + ":" + this.getCard(i) + "\n");
    }

    return deckString.toString();
  }

  public static String arrayToString(int[] array) {
    String s = "";

    for (int i = 0; i < array.length; i++) {
      s += array[i] + " ";
    }

    return s;
  }
}