import 'package:flutter/widgets.dart';

class CoinModel {
  final String name;
  final String symbol;
  final double price;
  // final String marketCap;
  // final String totalSupply;
  // final String volume;
  // final String percentageChangeInADay;

  // CoinModel({
  //   required this.name,
  //   required this.symbol,
  //   required this.price,
  //   required this.marketCap,
  //   required this.percentageChangeInADay,
  //   required this.totalSupply,
  //   required this.volume,
  // });

  CoinModel({
    required this.name,
    required this.symbol,
    required this.price,
  });

  factory CoinModel.fromJson(
    Map<String, dynamic>? jsonData,
  ) {
    String? requiredKey = jsonData?.keys.toList()[0];
    String? id;

    id = requiredKey.toString();

    debugPrint('Inside constructor $id');
    return CoinModel(
      name: jsonData?['name'] ?? jsonData?[id]?['name'],
      symbol: jsonData?['symbol'] ?? jsonData?[id]?['slug'],
      price: jsonData?['quote']?[0]?['price'] ?? 99969,
    );
  }

  @override
  String toString() {
    return 'Name: $name, Symbol: $symbol, Price: $price';
  }
}
