enum OrderType { pizza, drink, dessert, none }

class RequestOrder {
  final List<String> _description;
  final OrderType _type;

  RequestOrder(this._description, this._type);

  List<String> get description => _description;
  OrderType get type => _type;
}

abstract class Handler {
  Handler? _successor;

  void setSuccessor(Handler successor) {
    _successor = successor;
  }

  void handle(RequestOrder request) {
    if (_canHandle(request.type)) {
      _processRequest(request);
    } else if (_successor != null) {
      print('${_getHandlerName()}: Cannot handle ${request.type.name}, forwarding...');
      _successor!.handle(request);
    } else {
      print('${_getHandlerName()}: No one can handle this request.');
    }
  }

  bool _canHandle(OrderType type);
  void _processRequest(RequestOrder request);
  String _getHandlerName();
}

class WaiterHandler extends Handler {
  @override
  bool _canHandle(OrderType type) => type == OrderType.none;

  @override
  void _processRequest(RequestOrder request) {
    if (request.type == OrderType.none) {
      print('Waiter: Welcome! We have pizza, drinks, and desserts. What would you like?');
      return;
    }
    print('Waiter: What would you like to order?');
  }

  @override
  String _getHandlerName() => 'Waiter';
}

class ChefHandler extends Handler {
  @override
  bool _canHandle(OrderType type) =>
      type == OrderType.pizza || type == OrderType.dessert;

  @override
  void _processRequest(RequestOrder request) {
    print('Chef: I will prepare your ${request.type.name}: ${request.description.join(", ")}');
  }

  @override
  String _getHandlerName() => 'Chef';
}

class BartenderHandler extends Handler {
  @override
  bool _canHandle(OrderType type) => type == OrderType.drink;

  @override
  void _processRequest(RequestOrder request) {
    print('Bartender: I will prepare your drink: ${request.description.join(", ")}');
  }

  @override
  String _getHandlerName() => 'Bartender';
}

void main() {
  // Правильний порядок ланцюга
  var waiter = WaiterHandler();
  var chef = ChefHandler();
  var bartender = BartenderHandler();

  // Встановлюємо ланцюг: waiter -> chef -> bartender
  waiter.setSuccessor(chef);
  chef.setSuccessor(bartender);

  var orders = [
    RequestOrder(['Margherita', 'Pepperoni'], OrderType.pizza),
    RequestOrder(['Coke'], OrderType.drink),
    RequestOrder(['Tiramisu'], OrderType.dessert),
    RequestOrder([], OrderType.none),
  ];

  for (var order in orders) {
    print('\n--- New Order: ${order.description} (${order.type.name}) ---');
    waiter.handle(order);
  }
}