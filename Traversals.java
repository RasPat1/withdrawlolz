import java.util.ArrayList;

/**
 * Created by RasPat on 6/28/2014.
 *
 * Practice some types of tree traversals
 */

public class Traversals {

    public static void main(String args[]) {
        TreeNode test1 = createTestTree();

//        test1.inOrder();
        test1.preorder();


    }

    public static TreeNode createTestTree() {
        TreeNode root = new TreeNode(6);
        root.left = new TreeNode(5);
        root.left.left = new TreeNode(4);
        root.right = new TreeNode(3);
        root.right.left = new TreeNode(2);

        return root;
    }

}
class TreeNode {
    Object data;
    TreeNode left;
    TreeNode right;

    public TreeNode() {

    }

    public TreeNode(Object data) {
        this.data = data;
    }
    @Override
    public String toString() {
        String out = null;

        if (this.data != null) {
            out = this.data.toString();
        }
        return out;
    }
    // Inorder
    public void inOrder() {
        if (this.left != null) {
            this.left.inOrder();
        }
        System.out.println(this.data);
        if (this.right != null) {
            this.right.inOrder();
        }
    }


    // Preorder Iterative
    public void preorder() {
        // Add root to the stack
        // while the stack is not empty
            // Pop the stack
            // Print the value
            // Push the right and then left Nodes
        Stack s1 = new Stack(this);
        while (!s1.isEmpty()) {
            TreeNode tn = s1.pop();
            System.out.println(tn);
            if (tn.right != null) {
                s1.push(tn.right);
            }
            if (tn.left != null) {
                s1.push(tn.left);
            }
        }
    }
}
class Stack {
    ArrayList<TreeNode> nodes;

    public Stack(TreeNode n) {
        nodes = new ArrayList<TreeNode>();
        this.push(n);
    }

    public TreeNode pop() {
        if (this.isEmpty()) {
            return null;
        }


        return nodes.remove(nodes.size() - 1);
    }
    public void push(TreeNode n) {
        nodes.add(n);
    }
    public boolean isEmpty() {
        if (nodes.size() == 0) {
            return true;
        }
        return false;
    }


}


class StackFail {
    StackNode head;


    public StackNode pop() {
        StackNode oldHead = head;
        this.head = head.next;
        return oldHead;
    }
    public void push(StackNode newHead) {
        newHead.next = this.head;
        this.head = newHead;
    }

}
class StackNode {
    TreeNode data;
    StackNode next;

    public StackNode(TreeNode data) {
        this.data = data;
    }
}