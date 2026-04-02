sealed class Result<T> {
  Result();
}

class Success<T> extends Result<T> {
  final T _data;
  T get data => _data;

  Success({required T data}) : _data = data;
}

class Failure extends Result<Never> {
  final String _errorMessage;
  String get errorMessage => _errorMessage;

  Failure({required String message})
    : _errorMessage = message;
}
