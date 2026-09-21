/// Facade is a structural design pattern that provides a simplified interface
/// to subsystems, making them easier to use.

class ElectricToasterComponents {
  void on () {
    print('Turning on');
  }

  void off() {
    print('Turning off');
  }

  void heat() {
    print('Heating coils');
  }

  void timer() {
    print('Setting timer');
  }
}

class Toaster {
  final ElectricToasterComponents electricToasterComponents;

  Toaster(this.electricToasterComponents);

  void toast() {
    electricToasterComponents.on();
    electricToasterComponents.heat();
    electricToasterComponents.timer();
    electricToasterComponents.off();
    print('Toasting bread 🍞');
  }
}

class CoffeeMaker {
  void brew() {
    print('Brewing coffee ☕');
  }
}

class InfraRedOven {
  void cook() {
    print('Cooking eggs 🍳');
  }
}

class MorningFacade {
  final Toaster? toaster;
  final CoffeeMaker? coffeeMaker;
  final InfraRedOven? infraRedOven;

  MorningFacade({
    this.toaster,
    this.coffeeMaker,
    this.infraRedOven,
  });

  void prepareBreakfast() {
    toaster?.toast();
    coffeeMaker?.brew();
    infraRedOven?.cook();
  }
}

void main() {
  final electricToasterComponents = ElectricToasterComponents();

  final toaster = Toaster(electricToasterComponents);
  final coffeeMaker = CoffeeMaker();
  final infraRedOven = InfraRedOven();

  final typicalMorning = MorningFacade(
    toaster: toaster,
    coffeeMaker: coffeeMaker,
    infraRedOven: infraRedOven,
  );

  typicalMorning.prepareBreakfast();
}