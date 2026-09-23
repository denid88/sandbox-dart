void main() => GameLoop(BallGame()).run();

/// What the loop drives. The loop knows nothing about AI, physics or drawing.
abstract interface class Game {
  void processInput();
  void update(Duration step); // always the same fixed step
  void render(double alpha); // 0..1: how far we are into the next step
}

final class GameLoop {
  GameLoop(
    this._game, {
    this.updateStep = const Duration(microseconds: 16667), // ~60 updates/s
    this.frameBudget = const Duration(microseconds: 16667), // cap ~60 FPS
    this.maxUpdatesPerFrame = 5,
  });

  final Game _game;
  final Duration updateStep;
  final Duration frameBudget;
  final int maxUpdatesPerFrame;

  final Stopwatch _clock = Stopwatch();
  Duration _previous = Duration.zero;
  Duration _lag = Duration.zero;
  bool _running = false;

  Future<void> run() async {
    _running = true;
    _clock.start();
    while (_running) {
      final frameStart = _clock.elapsed;
      _tick(frameStart);

      final spent = _clock.elapsed - frameStart;
      await Future<void>.delayed(
        spent < frameBudget ? frameBudget - spent : Duration.zero,
      );
    }
  }

  void stop() => _running = false;

  void _tick(Duration now) {
    _lag += now - _previous;
    _previous = now;

    _game.processInput();

    var updates = 0;
    while (_lag >= updateStep && updates < maxUpdatesPerFrame) {
      _game.update(updateStep);
      _lag -= updateStep;
      updates++;
    }

    if (updates == maxUpdatesPerFrame) _lag = Duration.zero;

    _game.render(_lag.inMicroseconds / updateStep.inMicroseconds);
  }
}

final class BallGame implements Game {
  static const double speed = 200;

  double _prevX = 0;
  double _x = 0;

  @override
  void processInput() {}

  @override
  void update(Duration step) {
    _prevX = _x;
    _x += speed * step.inMicroseconds / Duration.microsecondsPerSecond;
  }

  @override
  void render(double alpha) {
    final drawX = _prevX + (_x - _prevX) * alpha;
    print('ball at ${drawX.toStringAsFixed(1)}');
  }
}