import '../data_structures/stack.dart';

void main() {
  printNamesIteratively(family);
}

void printNamesIteratively(Rabbit rabbit) {
  /// created new stack
  final stack = Stack<Rabbit>();
  stack.push(rabbit);

  while (stack.isNotEmpty) {
    Rabbit current = stack.pop();
    print(current.name);

    final babies = current.babies;
    if (babies == null) continue;

    for (final baby in babies.reversed) {
      stack.push(baby);
    }
  }
}

/// Simple
void countToTenRecursively([int i = 1]) {
  // 1
  if (i > 10) return;
  print('$i Mississippi');
  // 2
  countToTenRecursively(i + 1);
}

/// Examples
void printName(Rabbit rabbit) {
  // 1
  print(rabbit.name);
  // 2
  final babies = rabbit.babies;
  if (babies == null) return;
  // 3
  for (final baby in babies) {
    printName(baby);
  }
}


class Rabbit {
  Rabbit(this.name, {this.babies});
  final String name;
  final List<Rabbit>? babies;
}

final family = Rabbit(
  'Mommy',
  babies: [
    Rabbit(
      'Hoppy',
      babies: [
        Rabbit('Bunny'),
        Rabbit('Honey'),
        Rabbit('Sunny'),
      ],
    ),
    Rabbit(
      'Moppy',
      babies: [
        Rabbit('Doozy'),
        Rabbit('Woozy'),
      ],
    ),
    Rabbit(
      'Floppy',
      babies: [
        Rabbit('Nosey'),
        Rabbit('Mosey'),
        Rabbit('Toesy'),
        Rabbit('Rosey'),
      ],
    ),
  ],
);
