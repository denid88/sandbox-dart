import 'dart:async';

class DoubleBuffer<T> {
  T _current;
  T _next;

  DoubleBuffer(this._current, this._next);

  T get value => _current;
  T get draft => _next;

  void swap() {
    final temp = _current;
    _current = _next;
    _next = temp;
  }
}

class EventBatcher {
  final Future<void> Function(List<Map<String, Object?>>) _send;

  List<Map<String, Object?>> _current = []; // being flushed
  List<Map<String, Object?>> _next = [];    // accepting new events
  Timer? _timer;

  EventBatcher(this._send) {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => flush());
  }

  void track(String name, [Map<String, Object?> props = const {}]) {
    _next.add({'event': name, 'ts': DateTime.now().toIso8601String(), ...props});
  }

  Future<void> flush() async {
    if (_next.isEmpty) return;

    final temp = _current;
    _current = _next;
    _next = temp..clear();

    await _send(_current);
  }

  void dispose() => _timer?.cancel();
}

void main() {
  final batcher = EventBatcher((events) async {
    print('Sending ${events.length} events:');
    for (var event in events) {
      print(event);
    }
  });

  batcher.track('event1', {'key1': 'value1'});
  batcher.track('event2', {'key2': 'value2'});
  batcher.flush();

  batcher.track('event3', {'key3': 'value3'});
}




