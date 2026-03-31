import 'package:simple_crypto_demo/data/model/coin_model.dart';
import 'package:simple_crypto_demo/data/service/old_crypto_service.dart';
import 'package:simple_crypto_demo/utils/result.dart';

class OldCryptoRepository {
  Future<Result<CoinModel>> getCoinMetaData() async {
    return await OldCryptoService().getCoinMetaData();
  }
}
