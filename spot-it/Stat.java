class Stat {
  Integer deckSize;
  Integer imagesPerCard;

  Long decksBuilt;
  Long cardsBuilt;
  Long timeTaken;

  Long timeStart;
  Long timeEnd;

  Integer trials = 0;
  Integer successfulTrials = 0;

  public Stat(int deckSize, int imagesPerCard) {
    decksBuilt = 0L;
    cardsBuilt = 0L;
    timeTaken = 0L;

    this.deckSize = deckSize;
    this.imagesPerCard = imagesPerCard;
  }

  public String getStats() {
    StringBuffer statString = new StringBuffer();

    statString.append("deckSize:" + deckSize + "\n");
    statString.append("imagesPerCard:" + imagesPerCard + "\n");
    statString.append("timeTaken:" + timeTaken/trials + "\n");
    statString.append("decksBuilt:" + decksBuilt/trials + "\n");
    statString.append("cardsBuilt:" + cardsBuilt/trials + "\n");
    statString.append("trials:" + trials + "\n");
    statString.append("successfulTrials:" + successfulTrials + "\n");

    // Time per Deck
    // Time per Card
    // Time per Image

    return statString.toString();
  }

  public void deckBuilt() {
    decksBuilt++;
  }

  public void cardBuilt() {
    cardsBuilt++;
  }

  public void start() {
    timeStart = System.currentTimeMillis();
    trials++;
  }

  public void end() {
    timeEnd = System.currentTimeMillis();
    timeTaken += (timeEnd - timeStart);
  }

  public void successfulTrial() {
    successfulTrials++;
  }

  public String toString() {
    return getStats();
  }
}