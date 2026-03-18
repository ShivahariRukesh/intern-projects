import 'package:expense_tracker/widgets/counter_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('Inside home screen');

    return const SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.black),
        child: CounterWidget(),
      ),
    );
  }
}
