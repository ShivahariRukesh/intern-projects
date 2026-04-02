import 'package:flutter/widgets.dart';
import 'package:simple_crypto_demo/utils/result.dart';
import 'package:simple_crypto_demo/utils/ui_state.dart';

class BaseViewModel extends ChangeNotifier {
  final UiState _currentUiState = UiState(
    screenState: ScreenState.idle,
    errorMessage: '',
  );

  UiState get currentUiState => _currentUiState;

  void setCurrentUiState({
    ScreenState state = ScreenState.idle,
    String errorMessage = '',
  }) {
    _currentUiState.screenState = state;
    _currentUiState.errorMessage = errorMessage;
    notifyListeners();
  }

  Future<void> executeFuture<T>({
    required Future<Result<T>> Function() future,
    required void Function(T data) onSuccess,
  }) async {
    setCurrentUiState(state: ScreenState.loading);
    final result = await future();

    switch (result) {
      case Success<T>(:final T data):
        onSuccess(data);
        setCurrentUiState(state: ScreenState.success);
      case Failure(:final message):
        setCurrentUiState(
          state: ScreenState.error,
          errorMessage: message,
        );
    }
  }
}
