abstract class Widget {
  void build(BuildContext context);
}

class BuildContext {
  final Map<Type, InheritedWidget> _inheritedWidgets;

  BuildContext(this._inheritedWidgets);

  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>() {
    print("Looking for InheritedWidget of type $T");
    return _inheritedWidgets[T] as T?;
  }
}

abstract class InheritedWidget extends Widget {
  final Widget child;

  InheritedWidget({required this.child});

  bool updateShouldNotify(covariant InheritedWidget oldWidget);
}

// CounterInheritedWidget holds the counter state
class CounterInheritedWidget extends InheritedWidget {
  final int counter;

  CounterInheritedWidget({
    required this.counter,
    required Widget child,
  }) : super(child: child);

  @override
  void build(BuildContext context) {
    child.build(context);
  }

  @override
  bool updateShouldNotify(covariant CounterInheritedWidget oldWidget) {
    return counter != oldWidget.counter;
  }
}

// Widget that displays the counter
class DisplayCounter extends Widget {
  @override
  void build(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>();
    print("Counter value: ${inherited?.counter}");
  }
}

// App simulation class to manage state and trigger rebuilds
class App {
  late int _counter;
  late CounterInheritedWidget _tree;
  late BuildContext _context;

  App({int initialCounter = 0}) {
    _counter = initialCounter;
    _tree = _buildTree();
    _context = BuildContext({CounterInheritedWidget: _tree});
  }

  CounterInheritedWidget _buildTree() {
    return CounterInheritedWidget(
      counter: _counter,
      child: DisplayCounter(),
    );
  }

  void run() {
    print("Running app:");
    _tree.build(_context);
  }

  void incrementCounter() {
    _counter++;
    print("\nCounter incremented to $_counter");
    _tree = _buildTree();
    _context = BuildContext({CounterInheritedWidget: _tree});
    _tree.build(_context);
  }
}

// Entry point
void main() {
  final app = App(initialCounter: 5);

  app.run(); // Counter value: 5
  app.incrementCounter(); // Counter value: 6
  app.incrementCounter(); // Counter value: 7
}
