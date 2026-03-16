import 'package:flutter/material.dart';

class StateCounterWidget extends StatefulWidget {
  final child;
  const StateCounterWidget({
    super.key,
    required this.child,
  });

  @override
  State<StateCounterWidget> createState() =>
      _StateCounterWidgetState();
}

class _StateCounterWidgetState
    extends State<StateCounterWidget> {
  int count = 0;

  void increaseByOne() {
    setState(() {
      count++;
    });
  }

  void decreaseByOne() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedCounterWidget(
      count: count,
      child: widget.child,
      stateWidget: this,
    );
  }
}

class InheritedCounterWidget extends InheritedWidget {
  final int count;
  final _StateCounterWidgetState stateWidget;

  InheritedCounterWidget({
    super.key,
    required this.count,
    required super.child,
    required this.stateWidget,
  });

  @override
  bool updateShouldNotify(
    covariant InheritedCounterWidget oldWidget,
  ) {
    return count != oldWidget.count;
  }

  static of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<
          InheritedCounterWidget
        >()!
        .count;
  }

  static increaseCounter(BuildContext context) {
    context
        .dependOnInheritedWidgetOfExactType<
          InheritedCounterWidget
        >()!
        .stateWidget
        .increaseByOne();
  }

  static decreaseCounter(BuildContext context) {
    context
        .dependOnInheritedWidgetOfExactType<
          InheritedCounterWidget
        >()!
        .stateWidget
        .decreaseByOne();
  }
}
