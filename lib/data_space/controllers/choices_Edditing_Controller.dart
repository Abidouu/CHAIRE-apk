class ChoicesEditingController {
  List<String> _choices;

  ChoicesEditingController({List<String>? initialChoices}) : _choices = initialChoices ?? ['',''];

  List<String> get choices => _choices;

  set choices(List<String> newChoices) {
    _choices = newChoices;
  }

  void dispose() {
    // Add any cleanup code if necessary
  }
}
