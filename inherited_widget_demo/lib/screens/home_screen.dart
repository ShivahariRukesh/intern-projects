import 'package:inherited_widget_demo/widgets/counter_actions_widget.dart';
import 'package:inherited_widget_demo/widgets/counter_display_widget.dart';
import 'package:inherited_widget_demo/widgets/random_number_generator_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: CounterDisplayWidget()),

        Expanded(child: CounterActionsWidget()),

        Expanded(child: RandomNumberGeneratorWidget()),
      ],
    );
  }
}
