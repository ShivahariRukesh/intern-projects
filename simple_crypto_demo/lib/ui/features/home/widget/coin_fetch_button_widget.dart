import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_crypto_demo/ui/features/home/view_model/home_view_model.dart';
import 'package:simple_crypto_demo/utils/ui_state.dart';

/// It is the button widget used to fetch or refresh coin data
class CoinFetchButtonWidget extends StatelessWidget {
  /// [currentState] Represents the current state of the home screen.
  /// It helps determine the button behavior or UI (e.g., disabled during loading).
  final ScreenState currentState;

  /// A button widget that disables or enables based on the [ScreenState]
  /// Parameters:
  /// There are 2 named parameters:
  /// - [key]: An optional parameter that identifies the widget in the widget tree.
  /// - [currentState]: A required parameter of type ScreenState.
  const CoinFetchButtonWidget({
    super.key,
    required this.currentState,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          currentState == ScreenState.loading
              ? const Color.fromARGB(255, 14, 86, 145)
              : Colors.lightBlue,
        ),
        side: const WidgetStatePropertyAll(
          BorderSide(color: Colors.transparent),
        ),
      ),
      onPressed: () => currentState == ScreenState.loading
          ? null
          : context.read<HomeViewModel>().getCoins(),

      icon: currentState == ScreenState.error
          ? const Icon(Icons.refresh, size: 25)
          : const Icon(Icons.download, size: 25),
      label: currentState == ScreenState.error
          ? const Text(
              'Retry',
              style: TextStyle(color: Colors.black),
            )
          : const Text(
              'Fetch Coins',
              style: TextStyle(color: Colors.black),
            ),
    );
  }
}
