import java.util.Arrays;

/**
 * Created by RasPat on 6/28/2014.
 */
public class TreeToHeap {
    /*
    Convert a given unsorted Tree of integers to an array
    Sort the array
    Then crate a heap from the array
    using a tree for the underlying structure
     */
    public static void main(String args[]) {
        Node n1 = Node.makeTree();
        Node[] n1Arr = n1.convertToArray();
        Node nHeap = n1.makeHeap();
        nHeap.inOrder();

    }

}
class Node implements Comparable<Node>{
    Node left;
    Node right;
    Integer data;

    public Node(Integer data) {
        this.data = data;
    }

    // Returns an unsorted binary Tree
    public static Node makeTree() {
        Node root = new Node(0);
        root.left = new Node(1);
        root.right = new Node(12);
        Node l1 = root.left;
        l1.left = new Node(21);
        l1.right = new Node(-1000);
        Node r1 = root.right;
        r1.left = new Node(-12);
        r1.right = new Node(11);

        return root;
    }
    public Node makeHeap() {
        Node[] arr = this.convertToArray();
        Arrays.sort(arr);
        for (int i = 0; i < arr.length; i++) {
            int lcInd = i * 2 + 1;
            int rcInd = i * 2 + 2;
            if (lcInd < arr.length) {
                arr[i].left = arr[lcInd];
            } else {
                arr[i].left = null;
            }
            if (rcInd < arr.length) {
                arr[i].right = arr[rcInd];
            } else {
                arr[i].right = null;
            }
        }
        // The first element is the root and contains the reference to
        // all other nodes in the tree
        return arr[0];
    }
    public Node[] convertToArray() {
        int treeSize = this.size();
        if (treeSize == 0) {
            return null;
        }
        Node[] result = new Node[treeSize];
        this.addToArray(result, 0);

        return result;
    }

    public int addToArray(Node[] result, int lastIndex) {
        result[lastIndex++] = this;
        if (this.left != null) {
            lastIndex = this.left.addToArray(result, lastIndex);
        }
        if (this.right != null) {
            lastIndex = this.right.addToArray(result, lastIndex);
        }
        return lastIndex;
    }

    public int size() {
        // start at one for counting itself;
        int size = 1;

        if (this.left !=  null) {
            size += this.left.size();
        }
        if (this.right != null) {
            size += this.right.size();
        }
        return size;
    }
    public Boolean testHeap() {
        /*
         * Traverse the heap until every leaf is reached
         * Make sure each element is less then the one after it
         * This is basically depth first search yeah?
         */


        return false;
    }
    public boolean isLeaf() {
        if (this.left == null && this.right == null) {
            return true;
        }
        return false;
    }
    public int compareTo(Node n) {

        if (this.data > n.data) {
            return 1;
        } else if (this.data < n.data) {
            return -1;
        }

        return 0;
    }

    @Override
    public String toString() {
        return this.data.toString();
    }
    public void inOrder() {
        if (this.left != null) {
            this.left.inOrder();
        }
        System.out.print(this.data + ", ");
        if (this.right != null) {
            this.right.inOrder();
        }
    }
}