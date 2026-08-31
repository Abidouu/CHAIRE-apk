class DoubleEditingController {
  double _value;

  DoubleEditingController({double initialValue = 0.0}) : _value = initialValue;

  double get value => _value;

  set value(double newValue) {
    _value = newValue;
  }

  void dispose() {
    // Add any cleanup code if necessary
  }
}
