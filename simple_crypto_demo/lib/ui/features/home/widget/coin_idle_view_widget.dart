import 'package:flutter/material.dart';

class CoinIdleViewWidget extends StatelessWidget {
  /// It is displayed during the initial load of an app
  const CoinIdleViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 40,
        children: [
          Text(
            'Click Button Below To Retrieve',
            style: TextStyle(fontSize: 24),
          ),
          Icon(Icons.arrow_downward, size: 40),
        ],
      ),
    );
  }
}
