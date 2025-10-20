import 'dart:async';

// Future<void> main() async {
//   final controller = StreamController<int>.broadcast();
//   late final StreamSubscription subscription;
//
//   controller.add(1);
//   controller.add(2);
//   controller.add(3);
//
//   subscription = controller.stream.listen((value) => print("Listener 2: $value"));
//
//   controller.add(4);
//
//   await Future.delayed(Duration.zero);
//   controller.close();
//   subscription.cancel();
// }

// Future<void> main() async {
//   final controller = StreamController<int>.broadcast();
//   late final StreamSubscription subscription;
//
//   controller.stream.listen((value) => print("Listener 1: $value"));
//
//   controller.add(1);
//   controller.add(2);
//   controller.add(3);
//
//   subscription = controller.stream.listen((value) => print("Listener 2: $value"));
//
//   controller.add(4);
//
//   await Future.delayed(Duration.zero);
//   controller.close();
//   subscription.cancel();
// }