import 'package:simple_crypto_demo/data/model/coin_model.dart';
import 'package:simple_crypto_demo/data/service/crypto_service.dart';
import 'package:simple_crypto_demo/utils/result.dart';

class CryptoRepository {
  final CryptoService _service;
  CryptoRepository({required service}) : _service = service;

  Future<Result<List<CoinModel>>> getCoinsData() async {
    return await _service.fetchAllCoinData();
  }
}
