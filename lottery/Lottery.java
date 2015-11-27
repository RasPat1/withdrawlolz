/**
 * https://community.topcoder.com/stat?c=problem_statement&pm=1659
 *
**/
class Lottery {
  public static void main(String args[]) {
    Long ticketCount = getTicketCount(10, 10, false, false);
    Long ticketCountND = getTicketCount(10, 10, false, true);
    Long indigo = getTicketCount(8, 93, false, true);
    Long blue = getTicketCount(8, 100, true, true);

    System.out.println(ticketCount);
    System.out.println(ticketCountND);
    System.out.println(indigo);
    System.out.println(blue);
  }

  public static Long getTicketCount(Integer numberCount, Integer maxNumber, Boolean unique, Boolean nonDescending) {
    Long ticketCount = 0L;
    if (unique && nonDescending) {
      ticketCount = getAscendingLottery(numberCount, maxNumber);
    } else if (unique && !nonDescending) {
      ticketCount = getNoDuplicateLottery(numberCount, maxNumber);
    } else if (!unique && nonDescending) {
      ticketCount = getNonDescendingLottery(numberCount, maxNumber);
    } else {
      ticketCount = getSimpleLottery(numberCount, maxNumber);
    }
    return ticketCount;
  }

  /**
   * Case 1
   * Lottery numbers are stictly ascending.  No duplicates.
  **/
  public static Long getAscendingLottery(Integer numberCount, Integer maxNumber) {
    Long total = 0L;

    if (numberCount > maxNumber) {
      return 0L;
    } else if (numberCount == maxNumber) {
      return 1L;
    }

    if (numberCount == 1) {
	return (long) maxNumber;
    }

    for (int i = 0; i < maxNumber; i++) {
      int newFloor = maxNumber - i;
      total += getAscendingLottery(numberCount - 1, newFloor - 1);
    }

    return total;
  }

  /**
   * Case 2
   * Lottery ticket is composed of a set of `numberCount` numbers with a 
   * range of 1 to `maxNumber` where numbers are in non descending order
  **/
  public static Long getNonDescendingLottery(Integer numberCount, Integer maxNumber) {
    Long total = 0L;

    if (numberCount == 1) {
      return 0L + maxNumber;
    }

    for (int i = 0; i < maxNumber; i++) {
      int newFloor = maxNumber - i;
      total += getNonDescendingLottery(numberCount - 1, newFloor);
    }

    return total;
  }

  /** 
   * Case 3
   * Lottery ticket is composed of a set of `numberCount` numbers with a 
   * a range of 1 to `maxNumber` with no duplicate numbers
  **/
  public static Long getNoDuplicateLottery(Integer numberCount, Integer maxNumber) {
    Long total = 1L;
    for (int i = 0; i < numberCount; i++) {
      total = total * (numberCount - i);
    } 
    return total;
  }

  /** 
   * Case 4
   * Lottery ticket is composed of a set of `numberCount` numbers with
   * a range of 1 to `maxNumber`
   **/
  public static Long getSimpleLottery(Integer numberCount, Integer maxNumber) {
    return (long) Math.pow(maxNumber, numberCount);
  }

}


