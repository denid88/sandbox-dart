/// Builder - це породжувальний патерн, який дозволяє будувати складні об'єкти крок за кроком.
/// Він дозволяє використовувати один і той же код будівництва для отримання різних представлень об'єктів.
/// Цей патерн використовується для конструювання складних об'єктів зі складних об'єктів.

void main() {
  print('Basic concept of the Builder pattern');
  final director = Director();
  final builder = ConcreteBuilder();
  director.builder = builder;

  print('Standard basic product:');
  director.buildMinimalViableProduct();
  print(builder.product.parts.join('\n'));

  print('Standard full featured product:');
  director.buildFullFeaturedProduct();
  print(builder.product.parts.join('\n'));

  print('Custom product:');
  builder.producePartA();
  builder.producePartC();
  print(builder.product.parts.join('\n'));

  print('--------------------------------------------------------');

  /// Builder with Director
  final PizzaDirector pizzaDirector = PizzaDirector();
  for (var it in <PizzaBuilder>[MargaritaPizzaBuilder(), SalamiPizzaBuilder()]) {
    pizzaDirector.builder = it;
    pizzaDirector.makePizza();
    print(it.getPizza());
    print('---' * 20);
  }
  /// Builder without Director
  var houseBuilder = HouseBuilder(100);
  houseBuilder
    ..setHouseExterior(HouseExterior.minimal)
    ..setHouseInterior(HouseInterior.loft)
    ..setHouseType(HouseType.wood);
}

/// Basic concept of the Builder pattern -----------------------------------------------------------
class Director {
  Builder? _builder;

  void set builder(Builder builder) {
    this._builder = builder;
  }

  void buildMinimalViableProduct() {
    _builder?.producePartA();
  }

  void buildFullFeaturedProduct() {
    _builder?.producePartA();
    _builder?.producePartB();
    _builder?.producePartC();
  }
}

abstract class Builder {
  Product get product;

  void producePartA();
  void producePartB();
  void producePartC();
}

class ConcreteBuilder implements Builder {
  final Product _product = Product();

  @override
  Product get product => _product;

  @override
  void producePartA() {
    _product.add('PartA1');
  }

  @override
  void producePartB() {
    _product.add('PartB1');
  }

  @override
  void producePartC() {
    _product.add('PartC1');
  }
}

class Product {
  final List<String> _parts = [];

  void add(String part) {
    _parts.add(part);
  }

  List<String> get parts => _parts;
}
/// ------------------------------------------------------------------------------------------------
enum PizzaDoughDepth {thin, thick}
enum PizzaDoughType {wheat, corn, rye}
enum PizzaSauceType {pesto, whiteGarlic, barbeque, tomato}
enum PizzaTopLevelType {mozzarella, salami, bacon, mushrooms, shrimps}

class PizzaBase {
  final PizzaDoughDepth pizzaDoughDepth;
  final PizzaDoughType pizzaDoughType;

  const PizzaBase(this.pizzaDoughType, this.pizzaDoughDepth);

  @override
  String toString() {
    final depthStr = pizzaDoughDepth.toString().split('.')[1];
    final doughTypeStr = pizzaDoughType.toString().split('.')[1];
    return 'dough type: $doughTypeStr & $depthStr \n';
  }
}

class Pizza {
  String name;
  PizzaBase dough;
  PizzaSauceType sauce;
  int cookingTime;
  List<PizzaTopLevelType> topping;

  Pizza({
    this.name = 'Brick',
    this.dough = const PizzaBase(PizzaDoughType.wheat, PizzaDoughDepth.thin),
    this.sauce = PizzaSauceType.barbeque,
    this.cookingTime = 10,
    this.topping = const <PizzaTopLevelType>[
      PizzaTopLevelType.bacon,
      PizzaTopLevelType.mozzarella
    ]
  });

  @override
  String toString() {
    var infoStr = 'Pizza name: $name \n';
    infoStr += dough.toString();
    infoStr += 'sauce type: ${sauce.toString().split('.')[1]}';
    infoStr += 'topping: ';
    infoStr += topping.join(', ');
    infoStr += '\n';
    infoStr += 'cooking time: $cookingTime minutes';
    return infoStr;
  }
}

//Builder abstract class
abstract class PizzaBuilder {
  void prepareDough();
  void addSauce();
  void addTopping();
  Pizza getPizza();
}

class MargaritaPizzaBuilder implements PizzaBuilder {
  late Pizza _pizza;

  MargaritaPizzaBuilder() {
    _pizza = Pizza(name: 'Margarita', cookingTime: 15);
  }

  @override
  void addSauce() {
    _pizza.sauce = PizzaSauceType.tomato;
  }

  @override
  void addTopping() {
    _pizza.topping = const <PizzaTopLevelType>[
      PizzaTopLevelType.bacon,
      PizzaTopLevelType.mozzarella
    ];
  }

  @override
  Pizza getPizza() {
    return _pizza;
  }

  @override
  void prepareDough() {
    _pizza.dough = const PizzaBase(PizzaDoughType.wheat, PizzaDoughDepth.thick);
  }
}

class SalamiPizzaBuilder implements PizzaBuilder {
  late Pizza _pizza;

  SalamiPizzaBuilder() {
    _pizza = Pizza(name: 'Salami', cookingTime: 10);
  }

  @override
  void addSauce() {
    _pizza.sauce = PizzaSauceType.barbeque;
  }

  @override
  void addTopping() {
    _pizza.topping = const <PizzaTopLevelType>[
      PizzaTopLevelType.salami,
      PizzaTopLevelType.mozzarella
    ];
  }

  @override
  Pizza getPizza() {
    return _pizza;
  }

  @override
  void prepareDough() {
    _pizza.dough = const PizzaBase(PizzaDoughType.rye, PizzaDoughDepth.thin);
  }
}

/// Director
class PizzaDirector {
  PizzaBuilder? builder;

  PizzaDirector({this.builder}) : assert(builder != null, 'oO');

  void makePizza() {
    builder?.prepareDough();
    builder?.addSauce();
    builder?.addTopping();
  }
}

/// Example without Director
enum HouseType {brick, foamBlock, frame, wood, unknown}
enum HouseExterior {classic, minimal, shale, unknown}
enum HouseInterior {loft, modern, minimal, hiTech, unknown}

class HouseBuilder {
  int _size = 0;
  HouseType _houseType = HouseType.unknown;
  HouseInterior _houseInterior = HouseInterior.unknown;
  HouseExterior _houseExterior = HouseExterior.unknown;

  HouseType get houseType => _houseType;

  HouseInterior get houseInterior => _houseInterior;

  HouseExterior get houseExterior => _houseExterior;

  void setHouseType(HouseType houseType) => _houseType = houseType;

  void setHouseInterior(HouseInterior houseInterior) => _houseInterior = houseInterior;

  void setHouseExterior(HouseExterior houseExterior) => _houseExterior = houseExterior;

  HouseBuilder(this._size);

  House build() => House(this);

  static HouseBuilder get builder => HouseBuilder(0);
}

class House {
  late int size;
  late HouseType houseType;
  late HouseInterior houseInterior;
  late HouseExterior houseExterior;

  House(HouseBuilder builder) {
    size = builder._size;
    houseType = builder._houseType;
    houseExterior = builder._houseExterior;
    houseInterior = builder._houseInterior;
  }

  @override
  String toString() {
    var infoStr = 'House made from: $houseType size: $size\n';
    infoStr += 'with interior: ${houseInterior.toString().split('.')[1]}\n';
    infoStr += 'with exterior: ${houseExterior.toString().split('.')[1]}\n';
    return infoStr;
  }
}