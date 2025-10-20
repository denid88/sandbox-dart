import 'dart:isolate';

void main() async {
  print("[MAIN] Запуск програми...");

  // Порт для отримання повідомлень із ізолята
  final receivePort = ReceivePort();

  print("[MAIN] Створюю ізолят...");
  await Isolate.spawn(entryPoint, receivePort.sendPort);

  // Отримуємо SendPort із ізолята (щоб мати можливість з ним спілкуватися)
  final sendPort = await receivePort.first as SendPort;
  print("[MAIN] Отримано SendPort від ізолята.");

  // Створюємо ReceivePort для отримання відповіді
  final responsePort = ReceivePort();

  final message = "Привіт із головного ізолята!";
  print("[MAIN] Надсилаю повідомлення в ізолят: $message");

  // Надсилаємо дані в ізолят: [дані, порт для відповіді]
  sendPort.send([message, responsePort.sendPort]);

  // Очікуємо на результат із ізолята
  final messageFromIsolate = await responsePort.first;

  print("[MAIN] Отримано результат із ізолята: $messageFromIsolate");
  print("[MAIN] Завершення роботи.");
}

/// Точка входу ізолята
void entryPoint(SendPort mainSendPort) {
  print("[ISOLATE] Ізолят створено. Ініціалізація...");

  // Створюємо ReceivePort для прийому повідомлень від головного ізолята
  final port = ReceivePort();

  // Відправляємо головному ізоляту наш SendPort
  mainSendPort.send(port.sendPort);
  print("[ISOLATE] Відправлено SendPort головному ізоляту.");

  // Слухаємо повідомлення від головного ізолята
  port.listen((message) {
    final data = message[0]; // Дані
    final SendPort replyPort = message[1]; // Порт для відповіді

    print("[ISOLATE] Отримано повідомлення: '$data'");
    print("[ISOLATE] Обробка даних...");

    // Емуляція якоїсь обробки
    final result = '$data - оброблено ізолятом';

    print("[ISOLATE] Обробка завершена. Результат: '$result'");

    // Відправляємо результат назад у головний ізолят
    replyPort.send("Результат ізолята: $result");

    print("[ISOLATE] Результат відправлено назад головному ізоляту.");
  });
}
