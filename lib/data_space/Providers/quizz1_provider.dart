import 'package:flutter/foundation.dart';


class TextProvider extends ChangeNotifier {
  static List<TextProvider> _instances = [];

  TextProvider() {
    _instances.add(this);
  }

  Map<String, String> enteredTextMap = {};
  int textFieldCount = 0; // Counter variable

  void updateText(String fieldId, String text) {
    bool sent = false;
    for (var instance in _instances) {
        if (instance.enteredTextMap.containsKey(fieldId)) {
          instance.enteredTextMap[fieldId] = text;
          sent =true;
        }
      }
    if (!sent){
      enteredTextMap[fieldId] = text;
      textFieldCount++;
    }
     // Increment the counter
    notifyListeners();
  }

  void clearCache() {
    enteredTextMap.clear();
    notifyListeners();
  }

  void clearAllInstances() {
    for (var instance in _instances) {
      instance.clearCache();
    }
    _instances.clear();
  }

  int getCount() {
    return textFieldCount; // Return the count of text fields
  }
}
