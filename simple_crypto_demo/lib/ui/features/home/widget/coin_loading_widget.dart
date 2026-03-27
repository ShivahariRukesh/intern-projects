import 'package:flutter/material.dart';

class CoinLoadingWidget extends StatelessWidget {
  /// It is displayed when the request of retrieving coin details is happening and results not yet declared.
  /// It identifies process is ongoing.
  const CoinLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 10),
      ),
    );
  }
}
