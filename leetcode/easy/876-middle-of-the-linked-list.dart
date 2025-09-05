//Given the head of a singly linked list, return the middle node of the linked list.
//
// If there are two middle nodes, return the second middle node.
// Input: head = [1,2,3,4,5]
// Output: [3,4,5]
// Explanation: The middle node of the list is node 3.

class ListNode {
  int val;
  ListNode? next;

  ListNode(this.val, [this.next]);
}

class Solution {
  ListNode? middleNode(ListNode? head) {
    ListNode? middle = head;
    ListNode? end = head;

    while (end != null && end.next != null) {
      middle = middle?.next;
      end = end.next?.next;
    }

    return middle;
  }
}

void main() {
  // example: 1 -> 2 -> 3 -> 4 -> 5
  var node5 = ListNode(5);
  var node4 = ListNode(4, node5);
  var node3 = ListNode(3, node4);
  var node2 = ListNode(2, node3);
  var node1 = ListNode(1, node2);

  var solution = Solution();
  var middle = solution.middleNode(node1);
  print(middle?.val); // 3
}