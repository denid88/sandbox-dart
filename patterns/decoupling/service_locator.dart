// Service: the contract
abstract interface class Analytics {
  void logEvent(String name);
}

// Provider: a concrete implementation
class FirebaseAnalyticsService implements Analytics {
  @override
  void logEvent(String name) => print('[firebase] $name');
}

// Locator: stores and returns the service
abstract final class Locator {
  static late Analytics _analytics;

  static Analytics get analytics => _analytics;
  static void provide(Analytics service) => _analytics = service;
}

void main() {
  Locator.provide(FirebaseAnalyticsService()); // registration from outside
  Locator.analytics.logEvent('app_open');      // usage anywhere
}