void main() {
  final Car car = Car(CarType.passenger);
  print(car);
  final Car lorry = car.cloneLorry();
  print(lorry);
  final Car minivan = car.cloneMinivan();
  print(minivan);
}

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