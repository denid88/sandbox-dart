import 'dart:convert';

const int push = 0; // put the NEXT number from the program onto the stack
const int sum = 1; // put the order sum onto the stack
const int add = 2; // take 2 numbers, put a + b
const int div = 3; // take 2 numbers, put a / b

double run(List<int> program, double orderSum) {
  final stack = <double>[];

  double pop() {
    if (stack.isEmpty) throw StateError('Stack is empty: the program is broken');
    return stack.removeLast();
  }

  void log(String command) => print('  ${command.padRight(10)} stack: $stack');

  var i = 0;
  while (i < program.length) {
    final code = program[i];

    switch (code) {
      case push:
        i++;
        stack.add(program[i].toDouble());
        log('push ${program[i]}');

      case sum:
        stack.add(orderSum);
        log('sum');

      case add:
        final b = pop();
        final a = pop();
        stack.add(a + b);
        log('add');

      case div:
        final b = pop();
        final a = pop();
        stack.add(a / b);
        log('div');

      default:
        throw StateError('Unknown command code: $code');
    }

    i++;
  }

  return pop();
}

void main() {
  const orderSum = 1000.0;

  // Rule 1: discount = 10% of the sum  ->  sum / 10
  const today = [sum, push, 10, div];
  print('Today program as numbers: $today');
  print('Discount: ${run(today, orderSum)}\n');

  // Rule 2: discount = 5% + 50  ->  sum / 20 + 50
  const tomorrow = [sum, push, 20, div, push, 50, add];
  print('Tomorrow program as numbers: $tomorrow');
  print('Discount: ${run(tomorrow, orderSum)}\n');

  // Rule 3: pretend this JSON came from your server.
  // Change it and rerun: the Dart code above stays the same.
  const jsonFromServer = '[1, 0, 4, 3]'; // sum / 4 = 25%
  final fromServer = (jsonDecode(jsonFromServer) as List).cast<int>();
  print('From server: $fromServer');
  print('Discount: ${run(fromServer, orderSum)}');
}