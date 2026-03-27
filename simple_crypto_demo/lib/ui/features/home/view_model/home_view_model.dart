import 'package:flutter/material.dart';
import 'package:simple_crypto_demo/data/model/coin_model.dart';
import 'package:simple_crypto_demo/data/repository/crypto_repository.dart';
import 'package:simple_crypto_demo/utils/result.dart';

enum HomeState { loading, error, success, idle }

class HomeViewModel extends ChangeNotifier {
  List<CoinModel> _coinList = [];
  String _errorMessage = '';
  HomeState _currentState = HomeState.idle;
  String _searchQuery = '';

  final CryptoRepository _repository;

  HomeViewModel({required repository})
    : _repository = repository;

  List<CoinModel> get coinList => _coinList;
  String get errorMessage => _errorMessage;
  HomeState get currentState => _currentState;

  /// Retrieve the coin lists based on search query (either through name or symbol)
  List<CoinModel> get filteredCoins {
    if (_searchQuery.trim().isEmpty) return _coinList;
    final query = _searchQuery.toLowerCase();
    return _coinList.where((coin) {
      return coin.name.toLowerCase().contains(query) ||
          coin.symbol.toLowerCase().contains(query);
    }).toList();
  }

  /// Updates the coin lists based on search query
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Retrieve the coins details
  void getCoins() async {
    _currentState = HomeState.loading;
    notifyListeners();
    final getCoinsResult = await _repository.getCoinsData();

    switch (getCoinsResult) {
      case Success<List<CoinModel>>(:final data):
        _coinList = data;
        _currentState = HomeState.success;

      case Failure<List<CoinModel>>(:final message):
        _currentState = HomeState.error;
        _errorMessage = message;
    }

    notifyListeners();
  }
}
