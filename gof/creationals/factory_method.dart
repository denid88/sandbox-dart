/// Збоченці на собєсах можуть називати Factory Method - Virtual constructor
/// Віртуальний конструктор
void main() {
  final List<Meal> meals = [];

  final Meal pizza = Oven.makeFood(MealType.pizza);
  final Meal soup = Oven.makeFood(MealType.soup);
  final Meal pancakes = Oven.makeFood(MealType.pancakes);

  meals.add(pizza);
  meals.add(soup);
  meals.add(pancakes);

  meals.forEach((meal) {
    print(meal);
  });
}

enum MealType {pizza, soup, pancakes}

abstract class Meal {
  @override
  String toString() => runtimeType.toString();
}

class Pizza extends Meal {}
class Soup extends Meal {}
class Pancakes extends Meal {}

class Oven {
  static Meal makeFood(MealType type) {
    switch(type) {
      case MealType.pizza:
        return Pizza();
      case MealType.soup:
        return Soup();
      case MealType.pancakes:
        return Pancakes();
    }
  }
}