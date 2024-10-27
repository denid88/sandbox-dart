///You are given the heads of two sorted linked lists list1 and list2.
///Merge the two lists into one sorted list
///The list should be made by splicing together the nodes of the first two lists.
///Return the head of the merged linked list.

///
/// Definition for singly-linked list.
/// class ListNode {
/// int val;
/// ListNode? next;
/// ListNode([this.val = 0, this.next]);
/// }
///

///Input: list1 = [1,2,4], list2 = [1,3,4]
///Output: [1,1,2,3,4,4]

void main() {
  final List<int> list1 = [1, 2, 3];
  final List<int> list2 = [1, 4, 5];
  final ListNode linkedList1 = createLinkedList(list1);
  final ListNode linkedList2 = createLinkedList(list2);
  final s = Solution();

  var result = s.mergeTwoLists(linkedList1, linkedList2);
  print(result);
}

class Solution {
  ListNode? mergeTwoLists(ListNode? list1, ListNode? list2) {
    ListNode? mergedList;

    if (list1 == null) return list2;
    if (list2 == null) return list1;

    if (list1.val < list2.val) {
      mergedList = list1;
      mergedList.next = mergeTwoLists(list1.next, list2);
    } else {
      mergedList = list2;
      mergedList.next = mergeTwoLists(list1, list2.next);
    }

    return mergedList;
  }
}

class ListNode {
 int val;
 ListNode? next;
 ListNode([this.val = 0, this.next]);

  @override
  String toString() {
    if (next == null) return '$val';
    return '$val -> ${next.toString()}';
  }
}

ListNode createLinkedList(List<int> values) {
  ListNode dummy = ListNode(0);
  ListNode current = dummy;

  for (int value in values) {
    current.next = ListNode(value);
    current = current.next!;
  }

  return dummy.next!;
}