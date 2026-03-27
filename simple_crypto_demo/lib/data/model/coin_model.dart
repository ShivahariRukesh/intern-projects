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
    Map<String, dynamic> jsonData,
  ) {
    return CoinModel(
      name: jsonData['name'],
      symbol: jsonData['symbol'],
      price: jsonData['quote'][0]['price'],
    );
  }

  @override
  String toString() {
    return 'Name: $name, Symbol: $symbol, Price: $price';
  }
}
