import 'package:inherited_widget_demo/screens/home_screen.dart';
import 'package:inherited_widget_demo/widgets/state_counter_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(mainApp());
}

Widget mainApp() {
  return StateCounterWidget(
    child: MaterialApp(
      home: Scaffold(
        body: HomeScreen(),
        backgroundColor: Colors.black45,
      ),
    ),
  );
}
