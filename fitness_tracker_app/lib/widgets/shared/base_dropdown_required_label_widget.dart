import 'package:flutter/material.dart';

/// A widget that shows warning if no options are selected from dropdown menu.
class BaseDropdownRequiredLabelWidget
    extends StatelessWidget {
  /// A string that holds error text if none of the options is chosen from drop down menu.
  final String? error;
  const BaseDropdownRequiredLabelWidget(
    this.error, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          error!,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
