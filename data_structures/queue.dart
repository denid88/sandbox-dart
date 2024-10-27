/// Queue implementation FIFO first-in, first-out collection

void main() {
  final QueueList<int> queueList = QueueList();
  queueList.enqueue(1);
  queueList.enqueue(2);
  queueList.enqueue(3);
  print(queueList);
  queueList.dequeue();
  print(queueList);
}

abstract class Queue<E> {
  bool enqueue(E element);
  E? dequeue();
  bool get isEmpty;
  E? get peek;
}

class QueueList<E> implements Queue<E> {
  final _list = <E>[];

  @override
  bool enqueue(E element) {
    _list.add(element);
    return true;
  }

  @override
  E? dequeue() => (isEmpty) ? null : _list.removeAt(0);

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  E? get peek => (isEmpty) ? null : _list.first;

  @override
  String toString() {
    return _list.toString();
  }
}