import 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart';

class ValueProvider extends ChangeNotifier {
  static List<ValueProvider> _instances = [];

  ValueProvider() {
    _instances.add(this);
  }

  Map<String, double> enteredValueMap = {};
  int valueCount = 0; // Counter variable

  void updateValue(String fieldId, double value) {
    bool sent = false;
    for (var instance in _instances) {
      if(instance.enteredValueMap.containsKey(fieldId)){
        instance.enteredValueMap[fieldId] = value;
        sent =true;
      }
    }
    if (!sent){
      enteredValueMap[fieldId] = value;
      valueCount++;
    }
    // Increment the counter
    notifyListeners();
  }

  void clearCache() {
    enteredValueMap.clear();
    notifyListeners();
  }

  void clearAllInstances() {
    for (var instance in _instances) {
      instance.clearCache();
      valueCount = 0;
    }
    _instances.clear();
    valueCount = 0;
  }

  int getCount() {
    return valueCount; // Return the count of values
  }
  int count(){
    return _instances[0].getCount();
  }
}
