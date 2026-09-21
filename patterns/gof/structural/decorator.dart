/// Pattern Decorator

void main() {
  final phone = Phone();
  final cameraPhone = CameraDecorator(phone);
  final smartPhone = CameraDecorator(InternetDecorator(GamingDecorator(phone)));

  phone.call();
  cameraPhone.call();
  smartPhone.call();
}

abstract interface class IPhone {
  void call();
  late String name;
}

class Phone implements IPhone {
  @override
  void call() {
    print('$name: call provide only audio call');
  }

  @override
  late String name = 'Phone';
}

abstract interface class PhoneDecorator implements IPhone {
  final IPhone phone;

  PhoneDecorator(this.phone);

  @override
  void call() {
    phone.call();
  }
}

/// Concrete decorator: adds camera functionality
class CameraDecorator extends PhoneDecorator {
  CameraDecorator(IPhone phone) : super(phone);

  @override
  void call() {
    super.call();
    print('Now you can make video calls');
  }

  @override
  String name = 'CameraPhone';
}

/// Concrete decorator: adds internet functionality
class InternetDecorator extends PhoneDecorator {
  InternetDecorator(IPhone phone) : super(phone);

  @override
  void call() {
    super.call();
    print('Now you can browse the internet');
  }

  @override
  String name = 'InternetPhone';
}

/// Concrete decorator: adds gaming functionality
class GamingDecorator extends PhoneDecorator {
  GamingDecorator(IPhone phone) : super(phone);

  @override
  void call() {
    super.call();
    print('Now you can play mobile games');
  }

  @override
  String name = 'GamingPhone';
}



