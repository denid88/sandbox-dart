/// Kodeco______________________________________________________________________
void main() {
  final list = LinkedList<int>();
  // list.push(4);
  // list.push(3);
  // list.push(2);
  // list.push(1);
  list.push(5);
  list.push(4);
  list.push(3);
  list.push(3);
  list.push(1);

  // final middleNode = findTheMiddleNode(list);
  // print('middle: $middleNode');
  // final reversed = revert(list);
  // print(reversed);
  final clearedList = removeAllOccurrences(list, 3);
  print(clearedList);
}
/// Remove all Occurrences
Node<int>? removeAllOccurrences(LinkedList<int> list, int target) {
  Node<int>? head = list.head;
  Node<int>? current = list.head;

  while (current != null && current.next != null) {
    if (current.next!.value == target) {
      current.next = current.next!.next;
    } else {
      current = current.next;
    }
  }

  return head;
}

/// Revert linked list
Node<int>? revert(LinkedList<int> list) {
  Node<int>? cur = list.head;
  Node<int>? prev;

  while(cur != null) {
    var next = cur.next;
    cur.next = prev;
    prev = cur;
    cur = next;
  }

  return prev;
}

/// Find the middle node
int? findTheMiddleNode(LinkedList list) {
  if (list.head == null) return null;

  var current = list.head;

  int start = 0;
  int end = list.length - 1;

  while (start < end) {
    current = current?.next;
    start++;
    end--;
  }

  return list.nodeAt(start)?.value;
}

class LinkedList<E> extends Iterable<E> {
  Node<E>? head;
  Node<E>? tail;

  @override
  bool get isEmpty => head == null;

  E? findTheMiddle() {
    if (head == null) return null;
    return null;
  }

  void push(E value) {
    head = Node(value: value, next: head);
    tail ??= head;
  }

  void append(E value) {
    if (isEmpty) {
      push(value);
      return;
    }
    tail!.next = Node(value: value);
    tail = tail!.next;
  }

  Node<E>? nodeAt(int index) {
    var currentNode = head;
    var currentIndex = 0;

    while(currentNode != null && currentIndex < index) {
      currentNode = currentNode.next;
      currentIndex++;
    }
    return currentNode;
  }

  Node<E> insertAfter(Node<E> node, E value) {
    if (tail == node) {
      append(value);
      return tail!;
    }

    node.next = Node(value: value, next: node.next);
    return node.next!;
  }

  E? pop() {
    final value = head?.value;
    head = head?.next;
    if (isEmpty) {
      tail = null;
    }
    return value;
  }

  E? removeLast() {
    if (head?.next == null) return pop();

    var current = head;
    while (current!.next != tail) {
      current = current.next;
    }

    final value = tail?.value;
    tail = current;
    tail?.next = null;
    return value;
  }

  E? removeAfter(Node<E> node) {
    final value = node.next?.value;
    if (node.next == tail) {
      tail = node;
    }
    node.next = node.next?.next;
    return value;
  }

  @override
  String toString() {
    if (isEmpty) return 'Empty list';
    return head.toString();
  }

  @override
  Iterator<E> get iterator => _LinkedListIterator(this);
}

class _LinkedListIterator<E> implements Iterator<E> {
  _LinkedListIterator(LinkedList<E> list) : _list = list;
  final LinkedList<E> _list;

  Node<E>? _currentNode;

  @override
  E get current => _currentNode!.value;

  bool _firstPass = true;

  @override
  bool moveNext() {
    if (_list.isEmpty) return false;

    if (_firstPass) {
      _currentNode = _list.head;
      _firstPass = false;
    } else {
      _currentNode = _currentNode?.next;
    }

    return _currentNode != null;
  }
}


class Node<T> {
  Node({required this.value, this.next});
  T value;
  Node<T>? next;

  @override
  String toString() {
    StringBuffer buffer = StringBuffer();
    Node<T>? currentNode = this;
    while (true) {
      buffer.write(currentNode?.value);
      currentNode = currentNode?.next;
      if (currentNode == null) break;
      buffer.write(' -> ');
    }
    return buffer.toString();
  }

}



/// ____________________________________________________________________________

// void main() {
//   final List<String> listNames = ['Denys', 'Ivan', 'John'];
//   final LinkedList<String> linkedList = LinkedList.fromList(listNames);
//   linkedList.insertAfter('Ivan', 'Kaban');
//   print(linkedList);
// }
//
// class Node<T> {
//   late T value;
//   late Node<T>? next;
//
//   Node({
//     required this.value,
//     this.next,
//   });
//
//   @override
//   String toString() {
//     StringBuffer buffer = StringBuffer();
//     Node<T>? currentNode = this;
//     while (true) {
//       buffer.write(currentNode?.value);
//       currentNode = currentNode?.next;
//       if (currentNode == null) break;
//       buffer.write(' -> ');
//     }
//     return buffer.toString();
//   }
// }
//
// class LinkedList<T> {
//   Node<T>? head;
//   Node<T>? tail;
//
//   bool get isEmpty => head == null;
//
//   static fromList<T>(List<T> list) {
//     final LinkedList<T> linkedList = LinkedList();
//     for (final T element in list) {
//       linkedList.add(element);
//     }
//     return linkedList;
//   }
//
//   void add(T value) {
//     final Node<T> newNode = Node(value: value);
//
//     if (isEmpty) {
//       head = newNode;
//       return;
//     }
//
//     Node? current = head;
//     while (current?.next != null) {
//       current = current!.next;
//     }
//
//     current!.next = newNode;
//   }
//
//   void insertAfter(T target, T value) {
//     final newNode = Node(value: value);
//     if (head == null) {
//       head = newNode;
//       return;
//     }
//
//     Node<T>? current = head;
//
//     while (current != null) {
//       if (current.value == target) {
//         newNode.next = current.next;
//         current.next = newNode;
//         return;
//       }
//
//       current = current.next;
//     }
//   }
//
//   Node<T>? nodeAtIndex(int index) {
//     if (index < 0 || head == null) {
//       return null;
//     }
//
//     Node<T>? current = head;
//     int currentIndex = 0;
//
//     while (current != null && currentIndex < index) {
//       current = current.next;
//       currentIndex++;
//     }
//
//     return current;
//   }
//
//   void removeLast() {
//     if (head == null) return;
//
//     if (head?.next == null) {
//       head = null;
//       return;
//     }
//
//     Node<T>? current = head;
//
//     while (current?.next?.next != null) {
//       current = current!.next;
//     }
//
//     current!.next = null;
//   }
//
//   void removeAtIndex(int index) {
//     if (index < 0 || head == null) {
//       return;
//     }
//
//     if (index == 0) {
//       head = head!.next; // Если индекс 0, удаляем головной узел
//       return;
//     }
//
//     Node<T>? current = head;
//     Node<T>? previous;
//     int currentIndex = 0;
//
//     while (current != null && currentIndex < index) {
//       previous = current;
//       current = current.next;
//       currentIndex++;
//     }
//
//     if (current != null) {
//       previous!.next = current.next;
//     }
//   }
//
//   // Вывод содержимого списка
//   void printList() {
//     Node<T>? current = head;
//     while (current != null) {
//       print(current.value);
//       current = current.next;
//     }
//   }
//
//   @override
//   String toString() {
//     if (isEmpty) return 'Empty list';
//     return head.toString();
//   }
// }