import 'dart:async';

import 'package:rxdart/rxdart.dart';

void main() {
  // 1. PublishSubject — нові підписники отримують тільки нові значення
  final publishSubject = PublishSubject<int>();
  publishSubject.add(1);
  publishSubject.listen((v) => print('PublishSubject: $v'));
  publishSubject.add(2); // print: PublishSubject: 2

  // 2. BehaviorSubject — новий підписник одразу отримує останнє значення
  final behaviorSubject = BehaviorSubject<int>();
  behaviorSubject.add(10);
  behaviorSubject.listen((v) => print('BehaviorSubject: $v')); // print: BehaviorSubject: 10
  behaviorSubject.add(11); // print: BehaviorSubject: 11

  // 3. ReplaySubject — новий підписник отримує всю історію (можна обмежити розмір буфера)
  final replaySubject = ReplaySubject<int>(maxSize: 3);
  replaySubject.add(100);
  replaySubject.add(101);
  replaySubject.add(102);
  replaySubject.listen((v) => print('ReplaySubject: $v')); // print: ReplaySubject: 101, ReplaySubject: 102

  // 5. Звичайний StreamController (single-subscription)
  final streamController = StreamController<int>();
  streamController.add(287);
  streamController.add(288);
  streamController.add(299);
  streamController.stream.listen((v) => print('StreamController: $v'));
  streamController.add(300); // print: StreamController: 300
  streamController.close();

  // 6. Broadcast StreamController (дозволяє кілька підписників)
  final broadcastController = StreamController<int>.broadcast();
  broadcastController.add(398);
  broadcastController.add(399);
  broadcastController.stream.listen((v) => print('Broadcast 1: $v'));
  broadcastController.stream.listen((v) => print('Broadcast 2: $v'));
  broadcastController.add(400); // print: Broadcast 1: 400, Broadcast 2: 400
  broadcastController.close();
}