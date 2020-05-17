import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.lang.RuntimeException;

public class FormatJobs {
  final static String LIST_TITLE = "All Opportunities";
  final static int DATA_SIZE = 6;

  public static String format(String input) throws InvalidDataSizeException {
    StringBuilder result = new StringBuilder(LIST_TITLE + "\n");
    String[] jobStrings = input.split("\n");
    List<Job> jobs = new ArrayList<Job>();

    for (String jobString : jobStrings) {
      try {
        jobs.add(getJobFromData(jobString));
      } catch (InvalidDataSizeException e) {
        // Log the exception with whatever error handling framework we use
      }
    }

    Collections.sort(jobs);

    for (Job job : jobs) {
      result.append(job.toString() + "\n");
    }

    return result.toString();
  }

  /**
   * Split the comma separated values and store in a proper data structure
   * Cause we're in production and we do other interesting stuff with this
   */
  public static Job getJobFromData(String input) {
    String[] data = input.split(", ");
    if (data.length != DATA_SIZE) {
      throw new InvalidDataSizeException();
    }

    String title = data[0];
    String org = data[1];
    String city = data[2];
    String stateAbbrev = data[3];
    String minPay = data[4];
    String maxPay = data[5];

    return new Job(title, org, city, stateAbbrev, minPay, maxPay);
  }
}

class Job implements Comparable<Job> {
  String title;
  String organization;
  String location;
  Integer[] pay;

  final static String SEPARATOR = ", ";
  final static String PAY_SEPARATOR = "-";

  public Job(String title, String org, String city, String stateAbbrev, String minPay, String maxPay) {
    this.title = title;
    this.organization = org;
    this.location = city + SEPARATOR + stateAbbrev;
    this.pay = new Integer[2];
    this.pay[0] = Integer.valueOf(minPay);
    this.pay[1] = Integer.valueOf(maxPay);
  }

  @Override
  public int compareTo(Job job) {
    return this.title.compareTo(job.title);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("Title: ");
    sb.append(title);
    sb.append(SEPARATOR);

    sb.append("Organization: ");
    sb.append(organization);
    sb.append(SEPARATOR);

    sb.append("Location: ");
    sb.append(location);
    sb.append(SEPARATOR);

    sb.append("Pay: ");
    sb.append(pay[0]);
    sb.append(PAY_SEPARATOR);
    sb.append(pay[1]);

    return sb.toString();
  }
}
class InvalidDataSizeException extends RuntimeException {

}