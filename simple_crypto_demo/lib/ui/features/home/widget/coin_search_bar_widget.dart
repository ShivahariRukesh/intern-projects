import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_crypto_demo/ui/features/home/view_model/home_view_model.dart';

/// It is the search bar widget used to filter or search coins
class CoinSearchBarWidget extends StatelessWidget {
  /// [currentState] Represents the current state of the home screen.
  /// It can be used to enable/disable search functionality based on state.
  final HomeState currentState;

  /// It searches the coins based on the name or symbol
  /// Parameters:
  /// There are 2 named parameters:
  /// - [key]: An optional parameter that identifies the widget in the widget tree.
  /// - [currentState]: A required parameter of type [HomeState].
  const CoinSearchBarWidget({
    super.key,
    required this.currentState,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      child: _searchTextField(context),
    );
  }

  TextField _searchTextField(BuildContext context) {
    return TextField(
      enabled: currentState != HomeState.loading,
      style: const TextStyle(color: Colors.lightBlueAccent),
      decoration: InputDecoration(
        hintText: 'Search coins by name or symbol...',
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (value) => context
          .read<HomeViewModel>()
          .updateSearchQuery(value),
    );
  }
}
