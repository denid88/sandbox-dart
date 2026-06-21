/// Ітератор — це поведінковий патерн проектування, що дає змогу послідовно
/// обходити елементи складових об’єктів, не розкриваючи їхньої внутрішньої
/// організації.

/// Build in
/// Dart має вбудовані Iterator<T> та Iterable<T>. Будь-який клас, що реалізує
/// Iterable, працює з for-in
class AppleItem {
  final int number;

  const AppleItem(this.number);
}

abstract class AppleIterator<E> {
  E moveNext();
  bool hasNext();
}

class AppleSliceIterator implements AppleIterator<AppleItem> {
  List<AppleItem> _apple;
  int _index;

  AppleSliceIterator(List<AppleItem> apple) : _apple = apple, _index = 0;

  @override
  AppleItem moveNext() {
    if (hasNext()) {
      return _apple[_index++];
    }
    throw StateError('No more items');
  }

  @override
  bool hasNext() {
    return _index < _apple.length;
  }
}

class AppleAggregate {
  List<AppleItem> _apple;

  AppleAggregate(this._apple);

  AppleIterator<AppleItem> createIterator() {
    return AppleSliceIterator(_apple);
  }
}

////////////////////////////////////////////////////////////////////////////////

/// Custom collection — encapsulates internal storage
class TaskList extends Iterable<String> {
  final List<String> _tasks = [];

  void add(String task) => _tasks.add(task);

  @override
  Iterator<String> get iterator => _TaskIterator(_tasks);
}

/// Concrete iterator — knows traversal logic, hides structure
class _TaskIterator implements Iterator<String> {
  final List<String> _tasks;
  int _index = -1;

  _TaskIterator(this._tasks);

  @override
  String get current => _tasks[_index];

  @override
  bool moveNext() {
    if (_index + 1 < _tasks.length) {
      _index++;
      return true;
    }
    return false;
  }
}

////////////////////////////////////////////////////////////////////////////////

class NumberRange extends Iterable<int> {
  final int start;
  final int end;

  NumberRange(this.start, this.end);

  @override
  Iterator<int> get iterator => _generate().iterator;

  // Lazy generation — yields one value at a time
  Iterable<int> _generate() sync* {
    for (int i = start; i < end; i++) {
      yield i;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
Iterable<int> fibonacci() sync* {
  int a = 0, b = 1;
  while (true) {
    yield a;
    final next = a + b;
    a = b;
    b = next;
  }
}

void main() {
  /// Example 1
  final apples = AppleAggregate([
    AppleItem(1),
    AppleItem(2),
    AppleItem(3),
  ]);
  final iterator = apples.createIterator();
  while (iterator.hasNext()) {
    final apple = iterator.moveNext();
    print('Apple number: ${apple.number}');
  }

  /// Example 2
  final tasks = TaskList()
    ..add('Breathing exercise')
    ..add('Journal entry');

  for (final t in tasks) {
    print(t); // works because TaskList is Iterable
  }
  /// Example 3
  print(NumberRange(1, 5).toList()); // [1, 2, 3, 4]

  /// Example 4
  print(fibonacci().take(8).toList());

  /// Example N
  /// for (final element in list)
  final list = List.from([1, 2]);
  final it = list.iterator;
  while (it.moveNext()) {
    print(it.current);
  }
}