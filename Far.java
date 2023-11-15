import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by RasPat on 7/13/2014.
 */
public class Far {
    int maxPower;
    static long[] CONVERSION;
    static String[] NAMES;
    static HashMap<Integer, String> dict;
    static {
        dict = new HashMap<Integer, String>();
        CONVERSION = new long[]{
                1000000,  // NS TO MS
                1000,     // MS_TO_SEC
                60,       // SEC_TO_MIN
                60,       // MIN_TO_HOUR
                24        // MIN_TO_DAY
        };
        NAMES = new String[]{
                "NanoSeconds",
                "MS",
                "Seconds",
                "Minutes",
                "Hours"
        };
        dict.put(0, "Ones");
        dict.put(1, "Tens");
        dict.put(2, "Hundreds");
        dict.put(3, "Thousands");
        dict.put(4, "Ten thousands");
        dict.put(5, "Hundred thousand");
        dict.put(6, "Millions");
        dict.put(7, "Tens of Millions");
        dict.put(8, "Hundred Millions");
        dict.put(9, "One billion");
        dict.put(10, "Ten billion");
        dict.put(11, "Hundred billions");
        dict.put(12, "Trillions");
        dict.put(13, "Ten Trillion");
        dict.put(14, "Hundred Trillion");
    }

    public Far(int maxPower) {
        this.maxPower = maxPower;
    }

    public static void main(String[] args) {
        int highestPower = 15;
        for (int i = 0; i < highestPower; i++) {
            Far f1 = new Far(i);
            f1.time();
        }

    }

    public void time() {
        long start = System.nanoTime();
        int sum = 0;
        long max = (long)Math.pow(10, maxPower);

        for (long i = 0; i < max; i++) {
            sum = work(i, sum);
        }
        long end = System.nanoTime();
        printTimes(end - start);
    }

    public void printTimes(long totalTime) {
        System.out.println(Far.dict.get(this.maxPower) + ":  ");

        HashMap<String, Long> time = new HashMap<String, Long>();
        for (int i = Far.NAMES.length - 1; i >= 0; i--) {
            long scale = 1;
            for (int j = i; j > 0; j--) {
                scale *= Far.CONVERSION[j - 1];
            }
            long timeInUnits = (long)(totalTime / scale);
            if (timeInUnits > 0) {
                time.put(Far.NAMES[i], timeInUnits);
            }

            // only really want the two largest results if we can get them
            if (time.size() == 2) {
                break;
            }
        }

        for (Map.Entry<String, Long> pair: time.entrySet()) {
            Long duration = pair.getValue();
            if (duration > 0) {
                String unit = pair.getKey();
                System.out.println(duration + " " + unit);
            }
        }
    }
    // THis function just does some arbitrary amount of work
    public static int work(long i, int sum) {
        String a = "a";
        a += "c";
        a += "b";
        sum += i;
        sum += i * i;
        sum += sum;
        return sum;
    }
}
