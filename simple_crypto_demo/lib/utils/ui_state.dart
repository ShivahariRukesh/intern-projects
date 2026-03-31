enum ScreenState { loading, error, success, idle }

class UiState {
  ScreenState screenState;
  String errorMessage;

  UiState({
    required this.screenState,
    required this.errorMessage,
  });
}
