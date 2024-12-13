import 'dart:io';

/// Bridge is a structural design pattern that lets you split a large class
/// or a set of closely related classes into two separate hierarchies—abstraction
/// and implementation—which can be developed independently of each other.

void main() {
  final classicOven = ClassicOvenImplementor(0);
  final electricalOven = ElectricalOvenImplementor(0);
  final infraRedOven = InfraRedOvenImplementor(0);

  final oven = Oven(classicOven);

  final pizza = Pizza('Margherita', 15, 200);

  oven.cookingPizza(pizza);

  oven.changeImplementor(electricalOven);

  final pizza2 = Pizza('Pepperoni', 20, 250);

  oven.cookingPizza(pizza2);

  oven.changeImplementor(infraRedOven);

  final pizza3 = Pizza('Hawaiian', 25, 300);

  oven.cookingPizza(pizza3);
}

class Pizza {
  final String name;
  final int cookingTime;
  final double cookingTemperature;
  bool _isCooked = false;

  Pizza(this.name, this.cookingTime, this.cookingTemperature);

  void cook() => _isCooked = true;

  bool get isCooked => _isCooked;
}

abstract class IOvenImplementor {
  void warmUp(double temperature);
  void coolDown(double temperature);
  void cookPizza(Pizza pizza);
  double getTemperature();
  String getOvenType();
}

class ClassicOvenImplementor implements IOvenImplementor {
  double temperature = 0;
  final ovenType = 'ClassicOven';

  ClassicOvenImplementor(this.temperature) {
    assert(temperature >= 0, 'This isn\'t a refrigerator');
  }

  @override
  void cookPizza(Pizza pizza) => pizza.cook();

  @override
  void warmUp(double temperature) {
    assert(temperature >= 0, 'This isn\'t a refrigerator');
    sleep(Duration(
        milliseconds: ((temperature - this.temperature) * 30).toInt()));
    print('Temperature warm up from ${this.temperature} to $temperature');
    this.temperature = temperature;
  }

  @override
  void coolDown(double temperature) {
    assert(temperature >= 0, 'This isn\'t a refrigerator');
    sleep(Duration(
        milliseconds: ((this.temperature - temperature) * 25).toInt()));
    print('Temperature cool down from ${this.temperature} to $temperature');
    this.temperature = temperature;
  }

  @override
  String getOvenType() => ovenType;

  @override
  double getTemperature() => temperature;
}

class InfraRedOvenImplementor implements IOvenImplementor {
  double temperature = 0;
  final ovenType = 'InfraRedOven';

  InfraRedOvenImplementor(this.temperature) {
    assert(temperature >= 0, 'This isn\'t a refrigerator');
  }

  @override
  void cookPizza(Pizza pizza) => pizza.cook();

  @override
  void warmUp(double temperature) {
    assert(temperature >= 0, 'This isn\'t a refrigerator');
    sleep(
        Duration(milliseconds: ((temperature - this.temperature) * 5).toInt()));
    print('Temperature warm up from ${this.temperature} to $temperature');
    this.temperature = temperature;
  }

  @override
  void coolDown(double temperature) {
    assert(temperature >= 0, 'This isn\'t a refrigerator');
    sleep(
        Duration(milliseconds: ((this.temperature - temperature) * 5).toInt()));
    print('Temperature cool down from ${this.temperature} to $temperature');
    this.temperature = temperature;
  }

  @override
  String getOvenType() => ovenType;

  @override
  double getTemperature() => temperature;
}

class ElectricalOvenImplementor implements IOvenImplementor {
  double temperature = 0;
  final ovenType = 'ElectricalOven';

  ElectricalOvenImplementor(this.temperature) {
    assert(temperature >= 0, 'This isn\'t a refrigerator');
  }

  @override
  void cookPizza(Pizza pizza) => pizza.cook();

  @override
  void warmUp(double temperature) {
    assert(temperature >= 0, 'This isn\'t a refrigerator');
    sleep(Duration(
        milliseconds: ((temperature - this.temperature) * 15).toInt()));
    print('Temperature warm up from ${this.temperature} to $temperature');
    this.temperature = temperature;
  }

  @override
  void coolDown(double temperature) {
    assert(temperature >= 0, 'This isn\'t a refrigerator');
    sleep(Duration(
        milliseconds: ((this.temperature - temperature) * 10).toInt()));
    print('Temperature cool down from ${this.temperature} to $temperature');
    this.temperature = temperature;
  }

  @override
  String getOvenType() => ovenType;

  @override
  double getTemperature() => temperature;
}

class Oven {
  IOvenImplementor _oven;

  Oven(this._oven);

  void _prepareOven(double temperature) {
    if (_oven.getTemperature() > temperature) {
      _oven.coolDown(temperature);
    } else if (_oven.getTemperature() < temperature) {
      _oven.warmUp(temperature);
    } else {
      print('Working temperature');
    }
  }

  void cookingPizza(Pizza pizza) {
    _prepareOven(pizza.cookingTemperature);
    print(
        'Cooking ${pizza.name} pizza for ${pizza.cookingTime} minutes at ${pizza.cookingTemperature} C');
    _oven.cookPizza(pizza);
    if (pizza.isCooked) {
      print('Pizza is done!');
    } else {
      print('O_o ... something went wrong');
    }
    print('____________________________________');
  }

  void changeImplementor(IOvenImplementor implementor) {
    print('Implementor changed from ${_oven.getOvenType()}');
    print('to ${implementor.getOvenType()}');

    _oven = implementor;
  }

  double getTemperature() => _oven.getTemperature();

  String getImplementorType() => _oven.getOvenType();
}

/// One more example
/// ----------------------------------------------------------------------------
abstract class Loudspeaker {
  void announce(String message);
}

class LoudspeakerWithMuzak implements Loudspeaker {
  @override
  void announce(String message) => print("<soothing muzak playing> $message");
}

class LoudspeakerWithAlarm implements Loudspeaker {
  @override
  void announce(String message) => print("<BOO-OP BOO-OP> $message <BOO-OP>");
}

abstract class Factory {
  Loudspeaker loudspeaker = LoudspeakerWithMuzak();
  void announce(String message) => loudspeaker.announce(message);
}

class CoffeeRoaster extends Factory {
  int _temp = 200;
  bool get isTooHot => _temp >= 225;

  void turnGasValve() {
    loudspeaker.announce("Increasing gas!");
    _temp += 25;
    loudspeaker.announce("Temperature is now at $_temp");
  }
}
