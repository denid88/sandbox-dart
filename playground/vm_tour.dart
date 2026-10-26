import 'dart:io';
import 'dart:isolate';

int counter = 0;

void worker(SendPort replyTo) {
  counter += 100;
  replyTo.send('worker: counter=$counter, name=${Isolate.current.debugName}');
}

Future<void> main() async {
  counter += 1;
  print('main: counter=$counter, name=${Isolate.current.debugName}');
  print('pid=$pid  (run: top -H -p $pid  or  ps -T -p $pid)');

  final port = ReceivePort();
  await Isolate.spawn(worker, port.sendPort, debugName: 'my-worker');
  print(await port.first);

  await Future<void>.delayed(const Duration(seconds: 60));
}