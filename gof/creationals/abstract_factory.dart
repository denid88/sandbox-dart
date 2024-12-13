void main() {
  final Cafe cafe = Cafe(FoodFactory(FoodType.ukrainian));
  cafe.makeSetMeal();
}

enum FoodType {ukrainian, american, japanese}

abstract class SetMeal {}

class UkrainianSetMeal implements SetMeal {
  @override
  String toString() {
    return
      'Set Meal "Ukrainian Freedom" 🇺🇦\n'
      'First Course: Borscht with garlic doughnuts + one shot of gorilka\n'
      'Second Course: Dumplings with potatoes or cottage cheese, baked pork'
      ' with vegetables\n'
      'Dessert: Cottage cheese pancakes with jam or honey\n'
      'Drinks: Fruit drink or uzvar';
  }
}

class AmericanSetMeal implements SetMeal {
  @override
  String toString() {
    return
      'Set Meal "American Dream" 🇺🇸\n'
      'Main Course: Grilled steak with mashed potatoes and'
      ' steamed vegetables\n'
      'Dessert: Apple pie with vanilla ice cream\n'
      'Drinks: Tea or coffee, water, possibly juice.';
  }
}
class JapaneseSetMeal implements SetMeal {
  @override
  String toString() {
    return
      'Set Meal "Japanese Restraint" 🇯🇵\n'
      'Main Course: A Bento set, which might include rice, fish or meat,'
      ' pickles, and vegetables\n'
      'Dessert: Mochi (rice cakes)\n'
      'Drinks: Green tea, water';
  }
}

class Cafe {
  final FoodFactory _foodAbstractFactory;

  Cafe(this._foodAbstractFactory);

  void makeSetMeal() {
    final traditionalSetMeal = _foodAbstractFactory.makeSetMeal();
    print(traditionalSetMeal);
  }
}

abstract class FoodFactory {
  factory FoodFactory (FoodType foodType) {
    switch(foodType) {
      case FoodType.ukrainian:
        return UkrainianFoodFactory();
      case FoodType.american:
        return AmericanFoodFactory();
      case FoodType.japanese:
        return JapaneseFoodFactory();
    }
  }
  SetMeal makeSetMeal();
}

class UkrainianFoodFactory implements FoodFactory {
  @override
  SetMeal makeSetMeal() => UkrainianSetMeal();
}

class AmericanFoodFactory implements FoodFactory {
  @override
  SetMeal makeSetMeal() => AmericanSetMeal();
}

class JapaneseFoodFactory implements FoodFactory {
  @override
  SetMeal makeSetMeal() => JapaneseSetMeal();
}