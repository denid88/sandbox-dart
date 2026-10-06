class AudioEngine {
  void play(String sound) => print('🔊 $sound');
}

class Effects {
  void show(String effect) => print('✨ $effect');
}

abstract class Superpower {
  void playSound(String sound) => AudioEngine().play(sound);
  void showEffect(String effect) => Effects().show(effect);

  void activate();
}

class Jump extends Superpower {
  @override
  void activate() {
    playSound('jump');
    showEffect('dust');
  }
}

class Fireball extends Superpower {
  @override
  void activate() {
    playSound('fire');
    showEffect('flame');
  }
}

void main() {
  final powers = [Jump(), Fireball()];
  for (final p in powers) {
    p.activate();
  }
}