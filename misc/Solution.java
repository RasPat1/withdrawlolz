import java.util.*;
public class Solution {
    static final String operators = "+-*/";

    public static void main(String[] args) {
      Map<String, Integer> tests = new HashMap<String, Integer>();
      tests.put("1+1", 2);
      tests.put("1+20*3 / 3", 21);

      for (String formula : tests.keySet()) {
        Integer answer = calculate(formula);
        if (answer != tests.get(formula)) {
          System.out.println(formula + " evaluated to " + answer + " not " +
            tests.get(formula));
        }
      }
    }

    public int calculate(String s) {
        s = s.replaceAll("\\s", "");
        TreeNode root = parse(s);
        String reducedValue = root.reduce().value;
        return (int)Long.parseLong(reducedValue);
    }

    public TreeNode parse(String s) {
        TreeNode root = null;
        TreeNode newNode;

        int start = 0;
        for (int i = 0; i < s.length(); i++) {
            newNode = null;
            if (operators.indexOf(s.charAt(i)) != -1) {
                newNode = new TreeNode(s.substring(start, i+1));
            } else if (i == (s.length() - 1) || operators.indexOf(s.charAt(i + 1)) != -1) {
                newNode = new TreeNode(s.substring(start, i+1));
            }

            if (newNode != null) {
                if (root == null) {
                    root = newNode;
                } else {
                    root = root.insert(newNode);
                }
                start = i+1;
            }

        }

        return root;
    }

    private class TreeNode {
        TreeNode left;
        TreeNode right;
        String value;

        public TreeNode(TreeNode left, TreeNode right, String value) {
            this.left = left;
            this.right = right;
            this.value = value;
        }

        public TreeNode(String value) {
            this.left = null;
            this.right = null;
            this.value = value;
        }

        // Go as far to the right as possible and enter the node where appropriate
        // appopriate means if it's a number it shoudl be the new rightmost leaf
        // if it's an operator reorganize the tree so that the lower priority operator becomes the left subtree
        // and it becomes the right subtree of an operator with the same priority
        // 2 * 3 + 5
        // parse first char
        //     2
        //
        // Now add a *
        //     *
        //    2
        //
        // Now add a 3
        //     *
        //    2 3
        //
        // Now add a +
        //      +
        //     *
        //    2 3
        //
        // Reduces one side after adding the highest priority guy so tree stays balanced in more cases
        //     +
        //    6
        //
        // now add a 5
        //     +
        //    6 5
        //
        // reducing this tree leads to
        //     11
        public TreeNode insert(TreeNode newNode) {
            if (newNode.isHigherPriority(this)) {
                newNode.left = this.reduce();
                return newNode;
            } else if (this.right == null) {
                this.right = newNode;
            } else {
                this.right = this.right.insert(newNode);
            }

            return this;
        }

        public Boolean isOperatorNode() {
            return operators.indexOf(this.value.charAt(0)) != -1;
        }

        // If both are even "this" Node wins
        public Boolean isHigherPriority(TreeNode otherNode) {
            if (otherNode.getPriority() > this.getPriority()) {
                return false;
            }

            return true;
        }

        public int getPriority() {
            switch (value) {
                case "+":   return 2;
                case "-":   return 2;

                case "*":   return 1;
                case "/":   return 1;

                default:    return 0;
            }
        }

        public TreeNode reduce() {
            // Can't be reduced
            if (left == null && right == null) {
                return this;
            }

            Long leftVal = Long.parseLong(left.reduce().value);
            Long rightVal = Long.parseLong(right.reduce().value);
            Long newVal = 0L;

            switch (value) {
                case "+":   newVal = leftVal + rightVal;
                            break;
                case "-":   newVal = leftVal - rightVal;
                            break;
                case "*":   newVal = leftVal * rightVal;
                            break;
                case "/":   newVal = leftVal / rightVal;
                            break;
                default:    newVal = Long.parseLong(value);
                            break;
            }

            return new TreeNode(newVal.toString());
        }
        public String toString() {
            String result = "";
            if (left != null) {
                result += left.toString();
            }
            result = result + " " + value + " ";
            if (right != null) {
                result += right.toString();
            }
            return result;
        }
    }
}