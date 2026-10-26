// Component pattern — minimal example.
// One interface for every domain.
abstract interface class Component {
  void update(Entity e);
}

// Entity = shared state + a list of components.
class Entity {
  Entity(this.components);

  int x = 0;
  int velocity = 0;
  final List<Component> components;

  void update() {
    for (final c in components) {
      c.update(this);
    }
  }
}

// Input domain: writes velocity.
class PlayerInput implements Component {
  @override
  void update(Entity e) => e.velocity = 1; // player presses "right"
}

class DemoInput implements Component {
  @override
  void update(Entity e) => e.velocity = -1; // AI walks left
}

// Physics domain: reads velocity, writes x.
class Physics implements Component {
  @override
  void update(Entity e) => e.x += e.velocity;
}

// Graphics domain: reads x.
class Graphics implements Component {
  @override
  void update(Entity e) => print('draw at x=${e.x}');
}

void main() {
  final hero = Entity([PlayerInput(), Physics(), Graphics()]);
  final demo = Entity([DemoInput(), Physics(), Graphics()]); // input swapped
  final bush = Entity([Graphics()]); // graphics only

  print('hero');
  hero.update(); // draw at x=1
  hero.update(); // draw at x=2

  print('demo');
  demo.update(); // draw at x=-1

  print('bush');
  bush.update(); // draw at x=0
}