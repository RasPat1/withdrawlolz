import static org.junit.Assert.*;
import org.junit.Test;

public class FormatJobsTest {

  @Test
  public void testGiven() {
    String input =
      "Lead Chef, Chipotle, Denver, CO, 10, 15\n" +
      "Stunt Double, Equity, Los Angeles, CA, 15, 25\n" +
      "Manager of Fun, IBM, Albany, NY, 30, 40\n" +
      "Associate Tattoo Artist, Tit 4 Tat, Brooklyn, NY, 250, 275\n" +
      "Assistant to the Regional Manager, IBM, Scranton, PA, 10, 15\n" +
      "Lead Guitarist, Philharmonic, Woodstock, NY, 100, 200";
    String output =
      "All Opportunities\n" +
      "Title: Assistant to the Regional Manager, Organization: IBM, Location: Scranton, PA, Pay: 10-15\n" +
      "Title: Associate Tattoo Artist, Organization: Tit 4 Tat, Location: Brooklyn, NY, Pay: 250-275\n" +
      "Title: Lead Chef, Organization: Chipotle, Location: Denver, CO, Pay: 10-15\n" +
      "Title: Lead Guitarist, Organization: Philharmonic, Location: Woodstock, NY, Pay: 100-200\n" +
      "Title: Manager of Fun, Organization: IBM, Location: Albany, NY, Pay: 30-40\n" +
      "Title: Stunt Double, Organization: Equity, Location: Los Angeles, CA, Pay: 15-25\n";

    assertEquals(output, FormatJobs.format(input));
  }

  @Test
  public void testRowdyStrings() {
    String input =
      "Lead, Chef, Chipotle, Denver, CO, 10, 15\n" + // notice extra comma here
      "Stunt Double, Equity, Los Angeles, CA, 15, 25\n" +
      "Manager of Fun, IBM, Albany, NY, 30, 40\n" +
      "Associate Tattoo Artist, Tit 4 Tat, Brooklyn, NY, 250, 275\n" +
      "Assistant to the Regional Manager, IBM, Scranton, PA, 10, 15\n" +
      "Lead Guitarist, Philharmonic, Woodstock, NY, 100, 200";
    String output =
      "All Opportunities\n" +
      "Title: Assistant to the Regional Manager, Organization: IBM, Location: Scranton, PA, Pay: 10-15\n" +
      "Title: Associate Tattoo Artist, Organization: Tit 4 Tat, Location: Brooklyn, NY, Pay: 250-275\n" +
      // Notice the skipped line entry here
      "Title: Lead Guitarist, Organization: Philharmonic, Location: Woodstock, NY, Pay: 100-200\n" +
      "Title: Manager of Fun, Organization: IBM, Location: Albany, NY, Pay: 30-40\n" +
      "Title: Stunt Double, Organization: Equity, Location: Los Angeles, CA, Pay: 15-25\n";
    assertEquals(output, FormatJobs.format(input));
  }

  @Test
  public void testEmptyStings() {
    String input = "";
    String output = "All Opportunities\n";
    assertEquals(FormatJobs.format(input), output);
  }

}