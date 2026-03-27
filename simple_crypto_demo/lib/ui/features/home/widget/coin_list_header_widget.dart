import 'package:flutter/material.dart';

class CoinListHeaderWidget extends StatelessWidget {
  /// A header widget for the home screen
  const CoinListHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: Text(
          'Latest Cryptocurrency Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlueAccent,
          ),
        ),
      ),
    );
  }
}
