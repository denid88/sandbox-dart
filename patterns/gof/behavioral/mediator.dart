/// Intermediary, Controller, Mediator, Посередник
/// Посередник — це поведінковий патерн проєктування, що дає змогу
/// зменшити зв’язаність великої кількості класів між собою, завдяки переміщенню
/// цих зв’язків до одного класу-посередника.

abstract interface class ControlTower {
  void requestLanding(Aircraft aircraft);
  void notifyLanded(Aircraft aircraft);
}

class Aircraft {
  final String flightNumber;
  final ControlTower tower;

  Aircraft(this.flightNumber, this.tower);

  void land() => tower.requestLanding(this);

  void confirmLanding() {
    print('$flightNumber: touching down');
    tower.notifyLanded(this);
  }

  void hold() => print('$flightNumber: holding pattern, waiting');
}

class AirportTower implements ControlTower {
  final List<Aircraft> _landingQueue = [];
  bool _runwayBusy = false;

  @override
  void requestLanding(Aircraft aircraft) {
    if (_runwayBusy) {
      _landingQueue.add(aircraft);
      aircraft.hold();
    } else {
      _runwayBusy = true;
      aircraft.confirmLanding();
    }
  }

  @override
  void notifyLanded(Aircraft aircraft) {
    print('Tower: runway is free');
    _runwayBusy = false;

    if (_landingQueue.isNotEmpty) {
      requestLanding(_landingQueue.removeAt(0));
    }
  }
}

void main() {
  final tower = AirportTower();

  final boeing = Aircraft('Boeing-737', tower);
  final airbus = Aircraft('Airbus-A320', tower);
  final yak = Aircraft('Yak-40', tower);

  boeing.land();
  airbus.land();
  yak.land();
}