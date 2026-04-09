typedef Result<T> = ({
  SuccessResponse<T>? success,
  ErrorResponse? error
});

class SuccessResponse<T> {
  final T data;
  final String? message;
  SuccessResponse({required this.data, this.message});
}

class ErrorResponse {
  final String message;

  ErrorResponse({required this.message});
}
