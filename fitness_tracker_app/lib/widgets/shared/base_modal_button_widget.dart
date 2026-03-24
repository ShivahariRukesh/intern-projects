import 'package:flutter/material.dart';

/// A customizable modal button widget.
class BaseModalButtonWidget extends StatelessWidget {
  /// A function that handles business logic related to the input fields submission.
  ///
  /// No parameters
  ///
  /// Returns void
  final void Function() onSubmit;

  ///[onSubmit] A positional parameter which is a function.
  const BaseModalButtonWidget(this.onSubmit, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onSubmit,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Submit',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
