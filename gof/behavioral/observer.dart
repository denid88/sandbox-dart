void main() {
  final autoNews = AutoNews();
  final audiNewsChannel = AudiNewsChannel();
  final bmwNewsChannel = BMWNewsChannel();

  autoNews.register(audiNewsChannel);
  autoNews.register(bmwNewsChannel);

  autoNews.setNews('The Last Internal-Combustion-Engine Cars: Window Shop with Car and Driver');
  
  autoNews.unregister(audiNewsChannel);
  
  autoNews.setNews('BMW to End Production of Gas-Powered Cars by 2030');
}

abstract class AutoNewsChannel {
  void inform(String message) {
    print('$runtimeType: $message');
  }
}

class AudiNewsChannel extends AutoNewsChannel {}
class BMWNewsChannel extends AutoNewsChannel {}

class AutoNews {
  String _news = '';
  final List<AutoNewsChannel> _subscribers = [];

  setNews(String text) {
    _news = text;
    _notifyAll();
  }

  void _notifyAll() {
    _subscribers.forEach((subscriber) {
      subscriber.inform(_news);
    });
  }

  void register(AutoNewsChannel subscriber) {
    _subscribers.add(subscriber);
  }

  void unregister(AutoNewsChannel subscriber) {
    _subscribers.remove(subscriber);
  }
}