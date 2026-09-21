/// Why I should use Singleton?
/// 1. When you need to control concurrent access to a shared resource.
/// 2. When you need to reduce the number of instances of a class.
/// 3. When you need to reduce the number of global variables.
/// 4. When you need to reduce the number of instances of a class.
/// 5. When you need to reduce the number of global variables.

void main() {
  final Singleton singleton1 = Singleton.instance;
  final Singleton singleton2 = Singleton.instance;

  print(singleton1 == singleton2); // Should return true because it's the same instance
}

/// Singleton implementation
class Singleton {
  static Singleton? _instance;

  Singleton._();

  static Singleton get instance => _instance ??= Singleton._();
}