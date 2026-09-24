// Update Method pattern — runnable demo.
int _frame = 0;

void log(String msg, {int indent = 0}) {
  final pad = '  ' * indent;
  print('[frame ${_frame.toString().padLeft(2)}] $pad$msg');
}

abstract class Entity {
  Entity(this.name);

  final String name;
  double x = 0;
  bool isDead = false; // deferred removal flag

  void update(World world, double dt);

  @override
  String toString() => name;
}

class Skeleton extends Entity {
  Skeleton() : super('Skeleton');

  static const _speed = 100.0; // units per second
  static const _range = 100.0;
  bool _patrollingLeft = false;

  @override
  void update(World world, double dt) {
    final dir = _patrollingLeft ? -1 : 1;
    x += dir * _speed * dt;

    if (x >= _range) {
      x = _range - (x - _range); // bounce back on overshoot
      _patrollingLeft = true;
    } else if (x <= 0) {
      x = -x;
      _patrollingLeft = false;
    }

    final arrow = _patrollingLeft ? '<-' : '->';
    log('Skeleton.update  x=${x.toStringAsFixed(0).padLeft(3)} $arrow',
        indent: 2);
  }
}

class Statue extends Entity {
  Statue(String name, this._delay) : super(name);

  final int _delay;
  int _frames = 0;

  @override
  void update(World world, double dt) {
    _frames++;
    if (_frames == _delay) {
      _frames = 0;
      log('$name.update    ⚡ shoot lightning', indent: 2);
      world.spawn(LightningBolt(from: name));
    } else {
      log('$name.update    charging ${_frames}/$_delay', indent: 2);
    }
  }
}

class LightningBolt extends Entity {
  LightningBolt({required String from}) : super('Bolt($from)');

  double _ttl = 0.2; // seconds to live

  @override
  void update(World world, double dt) {
    _ttl -= dt;
    if (_ttl <= 0) {
      isDead = true;
      log('$name.update  fizzles out → marked dead', indent: 2);
    } else {
      log('$name.update  flying, ttl=${_ttl.toStringAsFixed(1)}s',
          indent: 2);
    }
  }
}

class World {
  final List<Entity> _entities = [];
  final List<Entity> _pending = []; // spawned during this frame

  void add(Entity e) {
    _entities.add(e);
    log('World.add($e)');
  }

  /// Called from inside update(): queue, do not touch the list we iterate.
  void spawn(Entity e) {
    _pending.add(e);
    log('World.spawn($e) → queued until end of frame', indent: 3);
  }

  void tick(double dt) {
    _frame++;
    log('World.tick(dt=$dt) — updating ${_entities.length} entities: '
        '$_entities');

    // 1. Update every live entity in list order.
    for (final e in _entities) {
      if (e.isDead) continue;
      e.update(this, dt);
    }

    // 2. Remove corpses after the walk (never during).
    final dead = _entities.where((e) => e.isDead).toList();
    if (dead.isNotEmpty) {
      _entities.removeWhere((e) => e.isDead);
      log('World.tick     removed $dead', indent: 1);
    }

    // 3. Flush spawned entities; they get their first update next frame.
    if (_pending.isNotEmpty) {
      _entities.addAll(_pending);
      log('World.tick     added $_pending', indent: 1);
      _pending.clear();
    }
  }
}

void main() {
  const dt = 0.1; // seconds per frame
  const frames = 14;

  final world = World()
    ..add(Skeleton())
    ..add(Statue('StatueL', 4))
    ..add(Statue('StatueR', 6));

  print('--- game loop start ---');
  for (var i = 0; i < frames; i++) {
    world.tick(dt);
    print('');
  }
  print('--- game loop end ---');
}