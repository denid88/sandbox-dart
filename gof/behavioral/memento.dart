class EditorMemento {
  final String _content;        // збережений текст (приватний, недоступний ззовні)
  final DateTime _createdAt;    // час створення знімка

  // конструктор: приймає вміст, час ставить автоматично
  EditorMemento(this._content) : _createdAt = DateTime.now();

  String get _state => _content;          // приватний геттер — лише Editor читає стан
  DateTime get createdAt => _createdAt;   // публічна метадата для Caretaker/UI
}

class Editor {                  // Originator — володіє станом
  String _content = '';         // поточний текст редактора

  // додає слова: якщо порожньо — просто слово, інакше дописує через пробіл
  void type(String words) => _content = _content.isEmpty ?
  words : '$_content $words';

  String get content => _content;   // публічний доступ до тексту для читання

  // створює знімок поточного стану
  EditorMemento save() => EditorMemento(_content);

  // відновлює стан зі знімка
  void restore(EditorMemento memento) => _content = memento._state;
}

class History {                          // Caretaker — зберігає історію знімків
  final List<EditorMemento> _snapshots = [];   // стек знімків

  void push(EditorMemento m) => _snapshots.add(m);   // кладе знімок на вершину

  // знімає верхній знімок; якщо стек порожній — повертає null
  EditorMemento? pop() => _snapshots.isEmpty ?
  null : _snapshots.removeLast();

  bool get isEmpty => _snapshots.isEmpty;   // перевірка, чи історія порожня
}

void main() {
  final editor = Editor();       // створюємо редактор
  final history = History();      // створюємо сховище історії

  editor.type('Hello');           // _content = "Hello"
  history.push(editor.save());    // зберігаємо знімок №1: "Hello"

  editor.type('beautiful');       // _content = "Hello beautiful"
  history.push(editor.save());    // зберігаємо знімок №2: "Hello beautiful"

  editor.type('world');           // _content = "Hello beautiful world"
  print(editor.content);          // Hello beautiful world

  editor.restore(history.pop()!); // дістаємо знімок №2 і відновлюємо
  print(editor.content);          // Hello beautiful

  editor.restore(history.pop()!); // дістаємо знімок №1 і відновлюємо
  print(editor.content);          // Hello
}