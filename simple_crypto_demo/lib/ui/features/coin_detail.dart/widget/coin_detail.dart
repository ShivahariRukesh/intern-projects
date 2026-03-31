import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_crypto_demo/ui/features/coin_detail.dart/view_model/coin_meta_data_view_model.dart';
import 'package:simple_crypto_demo/utils/ui_state.dart';

class CoinDetail extends StatelessWidget {
  const CoinDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CoinMetaDataViewModel>();

    if (vm.coinMetaDataUiCurrentState.screenState ==
        ScreenState.loading) {
      return Container(
        height: 200,
        width: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: const CircularProgressIndicator(),
      );
    }
    if (vm.coinMetaDataUiCurrentState.screenState ==
        ScreenState.error) {
      return Center(
        child: Text(
          'errorr!!! ${vm.coinMetaDataUiCurrentState.errorMessage}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          spacing: 15,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Coin Symbol'),

                Text(vm.coinSymbol),
              ],
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Coin Name'),

                Text(vm.coinName),
              ],
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Coin Price'),

                Text(vm.price.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
