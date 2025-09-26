/// Дія, Транзакція, Action, Command
/// Команда — це поведінковий шаблон проєктування, який перетворює
/// запити на об’єкти, дозволяючи передавати їх як аргументи під час виклику методів,
/// ставити запити в чергу, логувати їх, а також підтримувати скасування
/// операцій.

void main() {
  var chief = Chief();
  var chiefAssistant = ChiefAssistant();
  var oven = Oven();

  var pizzeria = Pizzeria();

  pizzeria.addCommand(PrepareDoughCommand(chiefAssistant));
  pizzeria.addCommand(PrepareToppingCommand(chiefAssistant));
  pizzeria.addCommand(PrepareSauceCommand(chiefAssistant));

  pizzeria.addCommand(PrepareOvenCommand(oven));

  pizzeria.addCommand(MakePizzaBaseCommand(chief));
  pizzeria.addCommand(AppliedSauceCommand(chief));
  pizzeria.addCommand(AddToppingCommand(chief));

  pizzeria.addCommand(CookingPizzaCommand(oven));

  pizzeria.addCommand(BonAppetitCommand(chief));

  pizzeria.cooking();

  print('-----------------------------------');

  // Example 2
  var light = Light();
  var lightSwitch = LightSwitch(light);

  lightSwitch.perform("on");
  lightSwitch.perform("off");
  lightSwitch.perform("off");
  lightSwitch.perform("on");
  lightSwitch.perform("on");
  lightSwitch.perform("off");

  print("\nLight switch history:\n${lightSwitch.history}");
}

abstract class ICommand {
  void execute();
}

////////////////////////////////////////////////////////////////////////////////
class ChiefAssistant {
  void preparePizzaDough() {
    print('ChiefAssistant prepares the pizza dough');
  }

  void prepareTopping() {
    print('ChiefAssistant cuts pizza toppings');
  }

  void prepareSauce() {
    print('ChiefAssistant prepares sauce');
  }
}

////////////////////////////////////////////////////////////////////////////////
class Oven {
  void prepareOven() {
    print('Oven is heating up');
  }
  void cookingPizza() {
    print('Pizza is cooked in oven');
  }
}
////////////////////////////////////////////////////////////////////////////////
class Chief {
  void makePizzaBase() {
    print('Chief rolls out a pizza base');
  }

  void appliedSauce() {
    print('Chief applies sauce to the base of pizza');
  }

  void addToppingToPizza() {
    print('Chief adds toppings to pizza');
  }

  void bonAppetit() {
    print('Chief wishes the client a bot appetit!');
  }
}

////////////////////////////////////////////////////////////////////////////////
class PrepareOvenCommand implements ICommand {
  final Oven _executor;

  PrepareOvenCommand(this._executor);

  @override
  void execute() {
    _executor.prepareOven();
  }
}

class CookingPizzaCommand implements ICommand {
  final Oven _executor;

  CookingPizzaCommand(this._executor);

  @override
  void execute() {
    _executor.cookingPizza();
  }
}

class MakePizzaBaseCommand implements ICommand {
  final Chief _executor;

  MakePizzaBaseCommand(this._executor);

  @override
  void execute() {
    _executor.makePizzaBase();
  }
}

class AppliedSauceCommand implements ICommand {
  final Chief _executor;

  AppliedSauceCommand(this._executor);

  @override
  void execute() {
    _executor.appliedSauce();
  }
}

class AddToppingCommand implements ICommand {
  final Chief _executor;

  AddToppingCommand(this._executor);

  @override
  void execute() {
    _executor.addToppingToPizza();
  }
}

class BonAppetitCommand implements ICommand {
  final Chief _executor;

  BonAppetitCommand(this._executor);

  @override
  void execute() {
    _executor.bonAppetit();
  }
}

////////////////////////////////////////////////////////////////////////////////
class PrepareDoughCommand implements ICommand {
  final ChiefAssistant _executor;

  PrepareDoughCommand(this._executor);

  @override
  void execute() {
    _executor.preparePizzaDough();
  }
}

class PrepareToppingCommand implements ICommand {
  final ChiefAssistant _executor;

  PrepareToppingCommand(this._executor);

  @override
  void execute() {
    _executor.prepareTopping();
  }
}

class PrepareSauceCommand implements ICommand {
  final ChiefAssistant _executor;

  PrepareSauceCommand(this._executor);

  @override
  void execute() {
    _executor.prepareSauce();
  }
}
////////////////////////////////////////////////////////////////////////////////
class Pizzeria {
  var _history = <ICommand>[];

  void addCommand(ICommand command) {
    _history.add(command);
  }

  void cooking() {
    if (_history.isNotEmpty) {
      _history.forEach((h) {
        h.execute();
      });
    } else {
      print('History buffer is empty');
    }
    _history.clear();
  }
}

//----------------------------------------------------------------------------//
abstract class Receiver {
  Set<String> get actions;
}

abstract class Command {
  Receiver receiver;
  late String name;

  Command(this.receiver);

  @override
  String toString() => this.name;

  void execute();
}

class Invoker {
  List<String> history = [];
  void execute(Command cmd) {
    cmd.execute();
    history.add("[${DateTime.now()}] Executed $cmd");
  }

  @override
  String toString() => history.fold("", (events, event) => events + "$event\r\n");
}

class TurnOffCommand extends Command {
  String name = "Turn off";
  TurnOffCommand(Light light): super(light);
  void execute() {
    (receiver as Light).turnOff();
  }
}

class TurnOnCommand extends Command {
  String name = "Turn on";
  TurnOnCommand(Light light): super(light);
  void execute() {
    (receiver as Light).turnOn();
  }
}

class Light implements Receiver {
  void turnOff() => print("Light off!");
  void turnOn() => print("Light on!");
  Set<String> get actions => Set.from(["off", "on"]);
}

class LightSwitch {
  Invoker _switch = Invoker();
  Light light;

  LightSwitch(this.light);

  String get history => _switch.toString();

  void perform(String action) {
    if (!light.actions.contains(action)) {
      return print("Uh...wait, wut?");
    }
    switch(action) {
      case "on": return _switch.execute(TurnOnCommand(light));
      case "off": return _switch.execute(TurnOffCommand(light));
    }
  }
}