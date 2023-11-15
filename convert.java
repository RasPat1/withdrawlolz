/**
 * Created by RasPat on 6/30/2014.
 */
public class convert {
    public static void main(String args[]) {
        System.out.println(convertToString("1234"));
    }
    public static int convertToString(String s) {
        int sum = 0;
        for (int i = s.length() - 1; i >=0; i--) {
            char c = s.charAt(i);
            int placeWeight = s.length() - 1 - i;
            if (c == '-') {
                sum *= -1;
                break;
            }
            int d = c - 48; // implicit type conversion
            System.out.println(d);

            sum += Math.pow(10, placeWeight) * d;
        }
        return sum;
    }

}
