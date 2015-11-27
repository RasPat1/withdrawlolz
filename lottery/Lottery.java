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

  public static Long getTicketCount(Integer blanks, Integer choices, Boolean unique, Boolean sorted) {
    Long ticketCount = 0L;
    if (unique && sorted) {
      ticketCount = getAscendingLottery(blanks, choices);
    } else if (unique && !sorted) {
      ticketCount = getNoDuplicateLottery(blanks, choices);
    } else if (!unique && sorted) {
      ticketCount = getNonDescendingLottery(blanks, choices);
    } else {
      ticketCount = getSimpleLottery(blanks, choices);
    }
    return ticketCount;
  }

  /**
   * Case 1
   * Lottery numbers are stictly ascending.  No duplicates.
  **/
  public static Long getAscendingLottery(Integer blanks, Integer choices) {
    Long total = 0L;

    if (blanks > choices) {
      return 0L;
    } else if (blanks == choices) {
      return 1L;
    }

    if (blanks == 1) {
	return (long) choices;
    }

    for (int i = 0; i < choices; i++) {
      int newFloor = choices - i;
      total += getAscendingLottery(blanks - 1, newFloor - 1);
    }

    return total;
  }

  /**
   * Case 2
   * Lottery ticket is composed of a set of `blanks` numbers with a 
   * range of 1 to `choices` where numbers are in non descending order
  **/
  public static Long getNonDescendingLottery(Integer blanks, Integer choices) {
    Long total = 0L;

    if (blanks == 1) {
      return 0L + choices;
    }

    for (int i = 0; i < choices; i++) {
      int newFloor = choices - i;
      total += getNonDescendingLottery(blanks - 1, newFloor);
    }

    return total;
  }

  /** 
   * Case 3
   * Lottery ticket is composed of a set of `blanks` numbers with a 
   * a range of 1 to `choices` with no duplicate numbers
  **/
  public static Long getNoDuplicateLottery(Integer blanks, Integer choices) {
    Long total = 1L;
    for (int i = 0; i < blanks; i++) {
      total = total * (blanks - i);
    } 
    return total;
  }

  /** 
   * Case 4
   * Lottery ticket is composed of a set of `blanks` numbers with
   * a range of 1 to `choices`
   **/
  public static Long getSimpleLottery(Integer blanks, Integer choices) {
    return (long) Math.pow(choices, blanks);
  }

}


