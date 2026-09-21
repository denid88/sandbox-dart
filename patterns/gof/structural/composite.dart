/// Composite Design Pattern

void main() {
  var dough = CompoundProduct('Dough');
  dough.addProduct(Product('flour', 3));
  dough.addProduct(Product('egg', 23));
  dough.addProduct(Product('salt', 1));
  dough.addProduct(Product('sugar', 2));

  var sauce = Product('Barbeque', 12);
  var topping = CompoundProduct('Topping');
  topping.addProduct(Product('dorblue', 14));
  topping.addProduct(Product('parmesan', 12));
  topping.addProduct(Product('mozzarella', 94));
  topping.addProduct(Product('maasdam', 77));

  var pizza = Pizza('4 Cheese');
  pizza.addProduct(dough);
  pizza.addProduct(sauce);
  pizza.addProduct(topping);

  pizza.cost();
}

abstract class IProduct {
  int cost();
  String name();
}

class Product implements IProduct {
  final String _name;
  final int _cost;

  Product(this._name, this._cost);

  @override
  int cost() => _cost;

  @override
  String name() => _name;
}

class CompoundProduct implements IProduct {
  final String _name;
  var productList = <IProduct>[];

  CompoundProduct(this._name);

  @override
  int cost() {
    var costProducts = 0;
    productList.forEach((it) {
      costProducts += it.cost();
    });
    return costProducts;
  }

  @override
  String name() => _name;

  void addProduct(IProduct product) {
    productList.add(product);
  }

  void removeProduct(IProduct product) {
    productList.remove(product);
  }
}

class Pizza extends CompoundProduct {
  Pizza(String name) : super(name);

  int cost() {
    var costProducts = 0;
    productList.forEach((it) {
      var currentCost = it.cost();
      print('Cost ${it.name()} = $currentCost parrots');
      costProducts += it.cost();
    });
    print('Cost ${name()} =  $costProducts parrots');
    return costProducts;
  }
}