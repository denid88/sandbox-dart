void main() {
  // final Car car = Car(CarType.passenger);
  // print(car);
  // final Car lorry = car.cloneLorry();
  // print(lorry);
  // final Car minivan = car.cloneMinivan();
  // print(minivan);

  final fastGhosts = Spawner(Ghost(15, 10));
  final slowGhosts = Spawner(Ghost(40, 2));
  final demons = Spawner(Demon(7));

  print(fastGhosts.spawn()); // Ghost(hp: 15, speed: 10)
  print(slowGhosts.spawn()); // Ghost(hp: 40, speed: 2)
  print(demons.spawn());     // Demon(rage: 7)
}

abstract class Monster {
  Monster clone();
}

class Ghost extends Monster {
  Ghost(this.health, this.speed);

  final int health;
  final int speed;

  // Covariant return type: Dart дозволяє звузити тип у override
  @override
  Ghost clone() => Ghost(health, speed);

  @override
  String toString() => 'Ghost(hp: $health, speed: $speed)';
}

class Demon extends Monster {
  Demon(this.rage);
  final int rage;

  @override
  Demon clone() => Demon(rage);

  @override
  String toString() => 'Demon(rage: $rage)';
}

/// Один спавнер на всі види монстрів
class Spawner {
  Spawner(this._prototype);
  final Monster _prototype;

  Monster spawn() => _prototype.clone();
}


////////////////////////////////////////////////////////////////////////////////
abstract interface class ICarPrototype {
  Car clonePassenger();
  Car cloneLorry();
  Car cloneMinivan();
}

enum CarType {passenger, lorry, minivan}

class Car implements ICarPrototype {
  final CarType type;

  const Car(this.type);

  factory Car._clone(CarType type) => Car(type);

  @override
  Car cloneLorry() => Car._clone(CarType.lorry);

  @override
  Car cloneMinivan() => Car._clone(CarType.minivan);

  @override
  Car clonePassenger() => Car._clone(CarType.passenger);

  @override
  String toString() => 'There is car, which has ${type.name} type';
}