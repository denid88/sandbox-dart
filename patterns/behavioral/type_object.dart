class Breed {
  final String name;
  final int startingHealth;
  final String attack;

  const Breed({
    required this.name,
    required this.startingHealth,
    required this.attack,
  });
}

class Monster {
  final Breed breed;
  int health; // instance-specific state

  Monster(this.breed) : health = breed.startingHealth;

  String get attack => breed.attack; // delegate shared data to the type
}

void main() {
  const dragon = Breed(name: 'Dragon', startingHealth: 230, attack: 'Дихає вогнем!');
  const troll  = Breed(name: 'Troll',  startingHealth: 48,  attack: 'Б\'є дубиною!');

  final monsters = [Monster(dragon), Monster(dragon), Monster(troll)];
  monsters[2].health -= 10; // only this troll is wounded

  for (final m in monsters) {
    print('${m.breed.name}: ${m.health} hp — ${m.attack}');
  }
}