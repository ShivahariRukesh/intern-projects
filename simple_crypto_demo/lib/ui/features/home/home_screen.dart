import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_crypto_demo/ui/features/coin_detail.dart/view_model/coin_meta_data_view_model.dart';
import 'package:simple_crypto_demo/ui/features/coin_detail.dart/widget/coin_detail.dart';
import 'package:simple_crypto_demo/ui/features/home/view_model/home_view_model.dart';
import 'package:simple_crypto_demo/ui/features/home/widget/coin_error_widget.dart';
import 'package:simple_crypto_demo/ui/features/home/widget/coin_fetch_button_widget.dart';
import 'package:simple_crypto_demo/ui/features/home/widget/coin_idle_view_widget.dart';
import 'package:simple_crypto_demo/ui/features/home/widget/coin_list_header_widget.dart';
import 'package:simple_crypto_demo/ui/features/home/widget/coin_list_view_widget.dart';
import 'package:simple_crypto_demo/ui/features/home/widget/coin_loading_widget.dart';
import 'package:simple_crypto_demo/ui/features/home/widget/coin_search_bar_widget.dart';
import 'package:simple_crypto_demo/utils/ui_state.dart';

/// It is the main home screen widget that displays cryptocurrency data based on state
class HomeScreen extends StatelessWidget {
  /// Displays cryptocurrency data based on state
  /// Parameters:
  /// There is 1 named parameter:
  /// - [key]: An optional parameter that identifies the widget in the widget tree.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    Widget body;
    switch (vm.currentUiState.screenState) {
      case ScreenState.loading:
        body = const CoinLoadingWidget();
        break;
      case ScreenState.error:
        body = CoinErrorWidget(
          message: vm.currentUiState.errorMessage,
        );
        break;
      case ScreenState.success:
        body = CoinListViewWidget(coins: vm.filteredCoins);
        break;
      default:
        body = const CoinIdleViewWidget();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              const CoinListHeaderWidget(),
              CoinSearchBarWidget(
                currentState: vm.currentUiState.screenState,
              ),
            ],
          ),
        ),
        Expanded(child: body),
        const SizedBox(height: 20),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,

            children: [
              CoinFetchButtonWidget(
                currentState: vm.currentUiState.screenState,
              ),
              ElevatedButton(
                onPressed: () =>
                    showCoinDetailDialog(context),
                // OldCryptoService().getCoinMetaData(),
                child: const Text('MetaData'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showCoinDetailDialog(BuildContext context) {
    Provider.of<CoinMetaDataViewModel>(
      context,
      listen: false,
    ).showACoinMetaData();
    showDialog(
      context: context,
      builder: (context) => const CoinDetail(),
    );
  }
}
