import 'dart:collection';

class Audio {
  final _queue = Queue<String>();
  
  void playSound(String id) => _queue.add(id);

  void update() {
    while (_queue.isNotEmpty) {
      print('▶ ${_queue.removeFirst()}');
    }
  }
}

void main() {
  final audio = Audio();
  audio.playSound('coin');
  audio.playSound('jump');
  print('UI продовжує роботу'); // printed BEFORE sounds
  audio.update();
}