import 'package:inherited_widget_demo/widgets/state_counter_widget.dart';
import 'package:flutter/material.dart';

class CounterDisplayWidget extends StatelessWidget {
  const CounterDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final countValue = InheritedCounterWidget.of(context);

    return Center(
      child: Container(
        child: Text(
          "This is the counter and the value right now is $countValue",
          style: TextStyle(color: Colors.white38),
        ),
      ),
    );
  }
}
