/// Flyweight

void main() {
  final autoFactory = AutoFactory();

  final auto1 = autoFactory.getAuto('BMW');
  final auto2 = autoFactory.getAuto('Audi');
  final auto3 = autoFactory.getAuto('BMW');

  print(auto1.model);
  print(auto2.model);
  print(auto3.model);

  print(autoFactory.getAutoCount());
}

class Auto {
  final String model;

  Auto(this.model);
}

class AutoFactory {
  final Map<String, Auto> _autos = {};

  Auto getAuto(String model) {
    return _autos.putIfAbsent(model, () => Auto(model));
  }

  int getAutoCount() {
    return _autos.length;
  }
}