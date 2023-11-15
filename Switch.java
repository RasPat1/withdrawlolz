import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

/**
 * Created by RasPat on 7/6/2014.
 */
public class Switch {

    public static void main(String[] args) throws IOException{
        String path = "E:\\Users\\RasPat\\dev\\GCJ\\";
        String fileName = "A-small-practice.in";

        File f = new File(path + fileName);
        Scanner in = new Scanner(f);

        int testCount = in.nextInt();
        int deviceCount = in.nextInt();
        int switchLength = in.nextInt();

        System.out.println(testCount);
        System.out.println(deviceCount);
        System.out.println(switchLength);

        while (in.hasNext()) {
            int[]
            int[] house = new int[deviceCount];
            for (int i = 0; i < deviceCount; i++) {

            }
        }
    }


}
