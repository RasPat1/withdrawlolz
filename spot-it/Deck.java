import java.util.ArrayList;

class Deck {
  Card[] cards;
  Integer deckSize;
  Integer imagesPerCard;
  Integer cardsInDeck = 0;

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
    Card testCard = null;
    Long cardBailOutCount = (long) Math.pow(10, 7); // arbitrary
    Long deckBailOutCount = (long) Math.pow(10, 1);


    while (deck.cardsInDeck < deckSize && stat.decksBuilt < deckBailOutCount) {
      testCard = Card.getRandomCard(imagesPerCard);
      stat.cardBuilt();

      if (deck.canBeAdded(testCard)) {
        deck.addCard(testCard);
      }

      // Start over if we've searched a lot of cards and have yet to find one that works
      if (stat.cardsBuilt >= (cardBailOutCount * stat.decksBuilt)) {
        deck = new Deck(deckSize, imagesPerCard);
      }
    }

    if (testDeck(deck)) {
      stat.successfulTrial();
    }

    stat.end();
    return deck;
  }

  public static Deck createValidRandomDeck(int deckSize, int imagesPerCard,
                                     Stat stat) {
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

  public Card getCard(int cardIndex) {
    return cards[cardIndex];
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
      imageIndexes = increment(imageIndexes, imagesPerCard - 1, max);
    }
    Card[] allCards = new Card[cards.size()];
    return cards.toArray(allCards);
  }

  public static int[] increment(int[] start, int pos, int max) {
    if (pos == -1) {
      return null;
    }

    if (start[pos] == max) {
      start[pos] = 0;
      start = increment(start, pos - 1, max);
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
  static Boolean testDeck(Deck deck) {
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

  public String toString() {
    StringBuffer deckString = new StringBuffer();

    for (int i = 0; i < deckSize; i++) {
      deckString.append("C" + i + ":" + this.getCard(i) + "\n");
    }

    return deckString.toString();
  }
}