import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int count;

  CounterProvider(this.count);
  void incrementCounter() {
    count++;
    notifyListeners();
  }

  void resetCounter() {
    count = 0;
    notifyListeners();
  }
}
