sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure extends Result<Never> {
  final String message;
  const Failure(this.message);
}
