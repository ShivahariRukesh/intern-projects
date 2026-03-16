import 'package:inherited_widget_demo/widgets/state_counter_widget.dart';
import 'package:flutter/material.dart';

class CounterActionsWidget extends StatefulWidget {
  CounterActionsWidget({super.key});

  @override
  State<CounterActionsWidget> createState() =>
      _CounterActionsWidgetState();
}

class _CounterActionsWidgetState
    extends State<CounterActionsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("Changed counter action dependency");
  }

  @override
  void didUpdateWidget(
    covariant CounterActionsWidget oldWidget,
  ) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    debugPrint("updated counter action widget ");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: () =>
                InheritedCounterWidget.decreaseCounter(
                  context,
                ),
            child: Text("Decrease by 1"),
          ),
          TextButton(
            onPressed: () =>
                InheritedCounterWidget.increaseCounter(
                  context,
                ),

            child: Text("Increase by 1"),
          ),
        ],
      ),
    );
  }
}
