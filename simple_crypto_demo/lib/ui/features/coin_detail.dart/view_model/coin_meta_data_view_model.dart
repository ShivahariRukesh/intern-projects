import 'package:flutter/material.dart';
import 'package:simple_crypto_demo/data/model/coin_model.dart';
import 'package:simple_crypto_demo/data/repository/old_crypto_repository.dart';
import 'package:simple_crypto_demo/utils/result.dart';
import 'package:simple_crypto_demo/utils/ui_state.dart';

class CoinMetaDataViewModel extends ChangeNotifier {
  final OldCryptoRepository repo = OldCryptoRepository();

  final UiState _coinMetaDataUiCurrentState = UiState(
    screenState: ScreenState.idle,
    errorMessage: '',
  );

  String coinSymbol = 'SHC';
  String coinName = 'ShivHareCoin';
  double price = 10000000;

  UiState get coinMetaDataUiCurrentState =>
      _coinMetaDataUiCurrentState;

  void showACoinMetaData() async {
    _coinMetaDataUiCurrentState.screenState =
        ScreenState.loading;
    notifyListeners();

    final data = await repo.getCoinMetaData();
    debugPrint('Inside view model $data');

    switch (data) {
      case Success<CoinModel>(:final CoinModel data):
        coinName = data.name;
        coinSymbol = data.symbol;
        price = data.price;

        _coinMetaDataUiCurrentState.screenState =
            ScreenState.success;
      case Failure(:final message):
        _coinMetaDataUiCurrentState.errorMessage = message;
        _coinMetaDataUiCurrentState.screenState =
            ScreenState.error;
        debugPrint('Inside view model error : $message');
    }
    notifyListeners();
  }
}
