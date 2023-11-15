/**
 * Created by RasPat on 6/28/2014.
 * Practice BSTs
 */

public class BSTNode {
    Integer data;
    BSTNode left;
    BSTNode right;

    public BSTNode(Integer data) {
        this.data = data;
    }
    // insert
    public void insert(Integer n) {

        if (this.data >= n) {
            if (this.left == null) {
                this.left = new BSTNode(n);
            } else {
                this.left.insert(n);
            }
        } else {
            if (this.right == null) {
                this.right = new BSTNode(n);
            } else {
                this.right.insert(n);
            }
        }
    }
    // delete
    public BSTNode delete(Integer Value) {
        return null;
    }


    // search
    public BSTNode search(Integer value) {
        if (this.data == value) {
            return this;
        } else if (this.data > value) {
           if (this.left == null) {
               return  null;
           } else {
               return this.left.search(value);
           }
       } else {
           if (this.right == null) {
                return  null;
           } else {
                return this.right.search(value);
            }
       }
    }


    // Other Problems

    // Find the lowest common ancestor of two nodes
    // Given a BST and two values that are known to exist in teh tree
    // Find the nearest ancestor that both share

    public BSTNode lowestAncestor(Integer v1, Integer v2) {
        // If the current node is not between v1 and v2
        if ((v1 <= this.data && v2 >= this.data) ||
                (v1 >= this.data && v2 <= this.data)) {
            return this;
            // only need to compare with one of them since
        } else if (v1 >= this.data && this.right != null) {
            return this.right.lowestAncestor(v1, v2);
        } else if(v1 <= this.data && this.left != null) {
            return this.left.lowestAncestor(v1, v2);
        }

        return null;
    }

    public BSTNode lowestAncestor2(Integer v1, Integer v2) {
        // If the current node is not between v1 and v2

        if (v1 > this.data && v2 > this.data) {
            if (this.right != null) {
                return this.right.lowestAncestor2(v1, v2);
            } else {
                return null;
            }
        } else if (v1 < this.data && v2 < this.data && this.left != null) {
            if (this.left != null) {
                return this.left.lowestAncestor2(v1, v2);
            } else {
                return null;
            }

        }
        return this;
    }
    public BSTNode lowestAncestorIter(Integer v1, Integer v2) {
        BSTNode root = this;
        while (root != null) {
            if (v1 > root.data && v2 > root.data) {
                if (root.right != null) {
                    root = root.right;
                } else {
                    return null;
                }
            } else if (v1 < root.data && v2 < root.data) {
                if (root.left != null) {
                    root = root.left;
                } else {
                    return null;
                }
            } else {
                return root;
            }
        }
        return null;
    }


    //    public void inOrder() {
//        this.inOrder(true);
//        System.out.println();
//    }
    public void inOrder() {
        if (this.left != null) {
            this.left.inOrder();
        }

        if (this != null) {
            System.out.print(this);
            System.out.print(" ");
        }

        if (this.right != null) {
            this.right.inOrder();
        }
        System.out.println("");
    }
    public void preOrder() {
        if (this != null) {
            System.out.println(this.data);
        }
        if (this.left != null) {
            this.left.preOrder();
        }
        if (this.right != null) {
            this.right.preOrder();
        }
    }
    // Should spit out in sorted order
    @Override
    public String toString() {
        return this.data.toString();
    }

    public static void main(String args[]) {
        BSTNode bad = makeBadTree();
        BSTNode good = testTree();

//           Test Ordering sysytem;
//        bad.inOrder();
//        good.inOrder();


        // Test Searching
//        System.out.println(bad.search(1));
//        System.out.println(bad.search(-1));
//        System.out.println(bad.search(9));
//        System.out.println(good.search(0));
//        System.out.println(good.search(1));
//        System.out.println(good.search(0));

        //Test lowest Ancestor
        Integer[] ancestorVals = {20, 22, 8, 4, 12, 10, 14};
        BSTNode ancestorTest = makeTree(ancestorVals);
//        ancestorTest.preOrder();
        BSTNode lowestAnc = ancestorTest.lowestAncestorIter(8, 4);
        System.out.print(lowestAnc);
    }
    public static BSTNode makeTree(Integer[] vals) {
        if (vals.length == 0) {
            return null;
        }
        BSTNode out = new BSTNode(vals[0]);
        for (int i = 1; i < vals.length; i++) {
            out.insert(vals[i]);
        }
        return out;
    }
    public static BSTNode makeBadTree() {
        Integer[] badList = {1,2,3,4,5,6,7,8,9,10};
        return makeTree(badList);
    }
    public static BSTNode testTree() {
        Integer[] normalishList = {1, 20, 13, -4, 50, 6, 7, 0, 0, 1};
        return makeTree(normalishList);
    }
}