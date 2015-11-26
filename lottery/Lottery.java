// Lottery game

// What is the total number of possilbe lottery tickets with a est of given conttraints
// constraints
  // How many numbers per ticket
  // What is the range of these numbers
  // optional Constraints
  	// All numbers are unique
  	// All numbers are in non-descending order
class Lottery {
  public static void main(String args[]) {
    Long ticketCount = getTicketCount(10, 10, true, true);

    System.out.println(ticketCount);
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

  public static Long getAscendingLottery(Integer numberCount, Integer maxNumber) {
    return 1L;
  }

  public static Long getNoDuplicateLottery(Integer numberCount, Integer maxNumber) {
    return 1L;
  }

  public static Long getNonDescendingLottery(Integer numberCount, Integer maxNumber) {
    return 1L;
  }

  public static Long getSimpleLottery(Integer numberCount, Integer maxNumber) {
    return 1L;
  }

}


