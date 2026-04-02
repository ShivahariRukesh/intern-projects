import 'package:simple_crypto_demo/data/model/coin_model.dart';
import 'package:simple_crypto_demo/data/repository/old_crypto_repository.dart';
import 'package:simple_crypto_demo/ui/core/shared/base_view_model.dart';

class CoinMetaDataViewModel extends BaseViewModel {
  final OldCryptoRepository repo = OldCryptoRepository();

  String coinSymbol = 'SHC';
  String coinName = 'ShivHareCoin';
  double price = 10000000;

  Future<void> showACoinMetaData() async {
    await executeFuture<CoinModel>(
      future: () => repo.getCoinMetaData(),

      onSuccess: (data) {
        coinName = data.name;
        coinSymbol = data.symbol;
        price = data.price;
      },
    );
  }
}
