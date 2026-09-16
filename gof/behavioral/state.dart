void main() {
  // final p = AudioPlayer();
  // p.clickPlay(); // Ready -> Playing
  // p.clickLock(); // Playing -> Locked
  // p.clickPlay(); // ignored
  // p.clickLock(); // Locked -> Playing (isPlaying == true)
  // p.clickNext(); // fast forward, not next song

  final t = Turnstile();
  t.push(); // blocked
  t.coin(); // unlock
  t.coin(); // return coin
  t.push(); // pass
  t.push(); // blocked
}

abstract class PlayerState {
  PlayerState(this.player);
  final AudioPlayer player;

  void clickLock();
  void clickPlay();
  void clickNext();
}

class LockedState extends PlayerState {
  LockedState(super.player);

  @override
  void clickLock() {
    // Unlocking restores whichever state we were in before locking.
    player.changeState(
      player.isPlaying ? PlayingState(player) : ReadyState(player),
    );
  }

  @override
  void clickPlay() {} // Locked: ignore input.

  @override
  void clickNext() {}
}

class ReadyState extends PlayerState {
  ReadyState(super.player);

  @override
  void clickLock() => player.changeState(LockedState(player));

  @override
  void clickPlay() {
    player.startPlayback();
    player.changeState(PlayingState(player)); // State triggers transition itself.
  }

  @override
  void clickNext() => player.nextSong();
}

class PlayingState extends PlayerState {
  PlayingState(super.player);

  @override
  void clickLock() => player.changeState(LockedState(player));

  @override
  void clickPlay() {
    player.stopPlayback();
    player.changeState(ReadyState(player));
  }

  @override
  void clickNext() => player.fastForward(const Duration(seconds: 5));
}

// Context: owns the current state and delegates every state-dependent call to it.
class AudioPlayer {
  AudioPlayer() {
    _state = ReadyState(this);
  }

  late PlayerState _state;
  bool isPlaying = false;

  void changeState(PlayerState state) => _state = state;

  // Public API stays stable — behaviour changes with the active state.
  void clickLock() => _state.clickLock();
  void clickPlay() => _state.clickPlay();
  void clickNext() => _state.clickNext();

  // Services that states call back into.
  void startPlayback() => isPlaying = true;
  void stopPlayback() => isPlaying = false;
  void nextSong() => print('next');
  void fastForward(Duration d) => print('ff ${d.inSeconds}s');
}

///////////////////////////////////////////////////////////////////////////////
abstract class TurnstileState {
  void coin(Turnstile t);
  void push(Turnstile t);
}

class Locked implements TurnstileState {
  @override
  void coin(Turnstile t) {
    print('unlock');
    t.state = Unlocked(); // transition
  }

  @override
  void push(Turnstile t) => print('blocked');
}

class Unlocked implements TurnstileState {
  @override
  void coin(Turnstile t) => print('return coin');

  @override
  void push(Turnstile t) {
    print('pass');
    t.state = Locked(); // transition
  }
}

class Turnstile {
  TurnstileState state = Locked();

  void coin() => state.coin(this);
  void push() => state.push(this);
}