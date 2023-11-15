/**
 * Created by RasPat on 6/28/2014.
 *
 */
public class ListFlat {

   public static void main(String[] args) {
       DLNode head = new DLNode(1);
       DLNode tail =
          head.link(new DLNode(4)).
          link(new DLNode(3)).
          link(new DLNode(5));
// 1 -> 4 -> 3 -> 5
//_2->10_ 3
       head.child = new DLNode(2);
       head.child.link(new DLNode(10));
       head.next.linkChild(new DLNode(3));

       DLList notFlat = new DLList(head, tail);
       System.out.println(notFlat);

       DLList flat = notFlat.flatten();
       System.out.println(flat);
   }


}
class DLNode {
    Object data;
    DLNode next;
    DLNode prev;
    DLNode child;
    public DLNode(Object data) {
        this.data = data;
    }
    public DLNode link(DLNode n1) {
        this.next = n1;
        n1.prev = this;
        return n1;
    }
    public DLNode linkChild(DLNode n1) {
        this.child = n1;
        return n1;
    }
    @Override
    public String toString() {
        return this.data.toString();
    }
}
class DLList {
    DLNode head;
    DLNode tail;
    public DLList(DLNode head, DLNode tail) {
        this.head = head;
        this.tail = tail;
    }
    /*
This function takes in a doubly linked list in which each DLNode
may have a pointer to a child DLNode and "flattens" that list
@Params
head: Pointer to the head of the list
tail: Pointer to the tail of that same list
@Returns: a pointer to the head of the list
 */
    public DLList flatten() {
        // Process
        // Start iterating at the head.  If the head has a child
        // move that child to the end of the list and advance the tail pointer
        // Start at beginning of the first level
        // While not at the end of first level
        // If current DLNode ahs a child
        // Append that child to the end the list
        // advance the tail pointer
        // Go to next DLNode
        DLNode head = this.head;
        DLNode tail = this.tail;
        while (head.next != null) {
            if (head.child != null) {
                this.append(head.child);
            }
            head = head.next;
        }
        // The local head has been consumed and is now pointing to the tail
        // Use Original head
        DLList flatList = new DLList(this.head, tail);
        return flatList;
    }
    public DLNode append(DLNode n) {
        this.tail.link(n);
        // Find end
        while (this.tail.next != null) {
            this.tail =  this.tail.next;
        }
        return n;
    }

    @Override
    public String toString() {
        DLNode head = this.head;
        StringBuffer out = new StringBuffer();
        while (head != null) {
            out.append(head);
            if (head.next != null) {
                out.append("->");
            }

            if (head.child != null) {
                out.append("_>");
                DLList tmp = new DLList(head.child, null);
                out.append(tmp);
                out.append("<_");
            }
            head = head.next;
        }
        return out.toString();
    }
}