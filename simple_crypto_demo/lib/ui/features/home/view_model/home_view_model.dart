import 'package:simple_crypto_demo/data/model/coin_model.dart';
import 'package:simple_crypto_demo/data/repository/crypto_repository.dart';
import 'package:simple_crypto_demo/ui/core/shared/base_view_model.dart';

enum HomeState { loading, error, success, idle }

class HomeViewModel extends BaseViewModel {
  List<CoinModel> _coinList = [];

  String _searchQuery = '';

  final CryptoRepository _repository;

  HomeViewModel({required repository})
    : _repository = repository;

  List<CoinModel> get coinList => _coinList;

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
  Future<void> getCoins() async {
    await executeFuture(
      future: () => _repository.getCoinsData(),
      onSuccess: (data) {
        _coinList = data;
      },
    );
  }
}
