import 'package:flutter/material.dart';
import 'package:simple_crypto_demo/data/model/coin_model.dart';

/// It is the list view widget used to display a list of coins
class CoinListViewWidget extends StatelessWidget {
  /// [coins] A list of CoinModel objects representing the coins to be displayed.
  final List<CoinModel> coins;

  /// A list view widget that holds the details of coins
  ///
  /// Parameters:
  /// There are 2 named parameters:
  /// - [key]: An optional parameter that identifies the widget in the widget tree.
  /// - [coins]: A required parameter of type List<[CoinModel]>.
  const CoinListViewWidget({
    super.key,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: coins.length,
      itemBuilder: (context, index) {
        final coin = coins[index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _circleAvatarWidget(coin),
                const SizedBox(width: 12),
                Expanded(child: _coinDetailRow(coin)),
              ],
            ),
          ),
        );
      },
    );
  }

  Row _coinDetailRow(CoinModel coin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            coin.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '\$${coin.price.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
      ],
    );
  }

  CircleAvatar _circleAvatarWidget(CoinModel coin) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.blue.shade100,
      child: Text(
        coin.symbol.substring(
          0,
          handleSymbolLength(coin.symbol.length, 4),
        ),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  int handleSymbolLength(
    int coinSymbolLength,
    int maximumLength,
  ) {
    return coinSymbolLength % maximumLength == 0
        ? maximumLength
        : coinSymbolLength % maximumLength;
  }
}
