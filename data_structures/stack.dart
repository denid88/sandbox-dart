/// Task: reversed string
/// input 'Hello World'
/// output 'dlroW olleH'

void main() {
  final String input = 'Hello World';
  final Stack<String> stack = Stack.of(input.split(''));
  print(stack.peek);
}

/// Stack implementation LIFO (Last input - first output)
class Stack<E> {
  Stack() : _storage = <E>[];
  final List<E> _storage;

  E get peek => _storage.last;

  bool get isEmpty => _storage.isEmpty;

  bool get isNotEmpty => _storage.isNotEmpty;

  Stack.of(Iterable<E> elements) : _storage = List<E>.of(elements);

  void push(E value) => _storage.add(value);

  E pop() => _storage.removeLast();

  @override
  String toString() {
    return '--- Top ---\n'
      '${_storage.reversed.join('\n')}'
      '\n-----------';
  }
}