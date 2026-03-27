import 'package:flutter/material.dart';

/// It is the widget used to display an error message when coin data fetching fails
class CoinErrorWidget extends StatelessWidget {
  /// [message] The error message to be displayed on the screen.
  final String message;

  /// Display an error message when something wrong goes while fetching coin details
  ///
  /// Parameters:
  /// There are 2 named parameters:
  /// - [key]: An optional parameter that identifies the widget in the widget tree.
  /// - [message]: A required string parameter representing the error message.
  const CoinErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(
        message,
        style: const TextStyle(
          color: Color.fromARGB(255, 169, 24, 16),
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
