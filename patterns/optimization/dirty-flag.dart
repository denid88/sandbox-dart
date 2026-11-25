class Product {
  const Product(this.name, this.price);
  final String name;
  final double price;
}

class ProductList {
  final List<Product> _items = [];
  String _query = '';

  // Derived data + flag
  List<Product> _visibleCache = const [];
  bool _dirty = true; // nothing computed yet

  // Every mutation goes through these methods and marks the cache dirty
  void add(Product p) {
    _items.add(p);
    _dirty = true;
  }

  void remove(Product p) {
    if (_items.remove(p)) _dirty = true;
  }

  set query(String q) {
    if (q == _query) return;
    _query = q;
    _dirty = true;
  }

  // Lazy recompute only when someone reads the result
  List<Product> get visible {
    if (_dirty) {
      _visibleCache = List.unmodifiable(_compute());
      _dirty = false;
    }
    return _visibleCache;
  }

  List<Product> _compute() {
    print('recompute');
    final q = _query.toLowerCase();
    return _items.where((p) => p.name.toLowerCase().contains(q)).toList()
      ..sort((a, b) => a.price.compareTo(b.price));
  }
}

void main() {
  final list = ProductList()
    ..add(const Product('Apple', 3))
    ..add(const Product('Banana', 1))
    ..add(const Product('Avocado', 5))
    ..query = 'a';           // 4 changes, 0 recomputes

  print(list.visible.length); // recompute -> 3
  print(list.visible.length); // from cache, no recompute
}