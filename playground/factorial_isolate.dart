import 'dart:isolate';

void main() async {
  final receivePort = ReceivePort();

  // Створюємо ізолят
  final isolate = await Isolate.spawn(heavyTaskEntryPoint, receivePort.sendPort);

  // Отримуємо SendPort із ізолята
  final sendPort = await receivePort.first as SendPort;

  // Створюємо ReceivePort для отримання результату
  final responsePort = ReceivePort();

  // Надсилаємо дані в ізолят (число для обчислення факторіалу)
  const number = 50; // Велике число для демонстрації
  sendPort.send([number, responsePort.sendPort]);

  print("Обчислення факторіалу $number у фоновому ізоляті...");

  // Чекаємо результат
  final result = await responsePort.first;

  print("Результат із ізолята: $result");
  // Закриваємо порти та ізолят
  responsePort.close();
  receivePort.close();
  isolate.kill(priority: Isolate.immediate);
}

/// Точка входу ізолята — виконує важку обчислювальну операцію
void heavyTaskEntryPoint(SendPort mainSendPort) {
  final port = ReceivePort();
  mainSendPort.send(port.sendPort);

  port.listen((message) {
    final int number = message[0];
    final SendPort replyPort = message[1];

    final result = factorial(number);

    replyPort.send("Факторіал $number = $result");
  });
}

/// Важка функція — рекурсивне обчислення факторіалу
int factorial(int n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}