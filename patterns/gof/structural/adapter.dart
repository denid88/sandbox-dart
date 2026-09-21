/// Adapter pattern

void main() {
  final originalOven = OriginalOven(350);
  final adapter = OvenAdapter(originalOven);

  printTemperature(adapter);
  adapter.setCelsiusTemperature(180);
  printTemperature(adapter);

  final xmlHandler = XMLHandler();
  final adapterJSONHandler = AdapterJSONHandler(xmlHandler);
  print(adapterJSONHandler.getJSON());
}

const double fahrenheitZero = 32;
const double celsiusToFahreinheit = 9.0 / 5;
const double fahrenheitToCelsius = 5.0 / 9;

abstract class IOven {
  double getTemperature();
  void setTemperature(double t);
}

abstract class ICelsiusOven {
  double getCelsiusTemperature();
  void setCelsiusTemperature(double t);
  double getOriginalTemperature();
}

class OriginalOven implements IOven {
  late double temperature;

  OriginalOven(this.temperature) {
    assert(temperature >= fahrenheitZero, "This isn't a refrigerator");
  }

  @override
  double getTemperature() {
    return temperature;
  }

  @override
  void setTemperature(double t) {
    assert(temperature >= fahrenheitZero, 'Does the oven freeze?..');
    temperature = t;
  }
}

class OvenAdapter implements ICelsiusOven {
  late IOven originalOven;
  double temperature = 0;

  OvenAdapter(this.originalOven) {
    temperature = _initTemperature();
  }

  double _initTemperature() =>
      (fahrenheitToCelsius * (originalOven.getTemperature() - fahrenheitZero));

  @override
  double getCelsiusTemperature() => temperature;

  @override
  double getOriginalTemperature() => originalOven.getTemperature();

  @override
  void setCelsiusTemperature(double t) {
    assert(t >= 0, 'Oo');
    originalOven.setTemperature(celsiusToFahreinheit * t + fahrenheitZero);
    temperature = t;
  }
}

void printTemperature(ICelsiusOven oven) {
  print('Original temperature ${oven.getOriginalTemperature()} F');
  print('Celsius temperature ${oven.getCelsiusTemperature()} C');
}

/// one more simple example
abstract class IXMLHandler {
  String getXML();
}

abstract class IJSONHandler {
  String getJSON();
}

class XMLHandler implements IXMLHandler {
  @override
  String getXML() => 'xml string';
}

class AdapterJSONHandler implements IJSONHandler {
  late IXMLHandler iXMLHandler;

  AdapterJSONHandler(this.iXMLHandler);

  @override
  String getJSON() {
    return '{"json": ${iXMLHandler.getXML()}}';
  }
}