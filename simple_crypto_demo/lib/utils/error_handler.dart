import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

String handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      return 'No internet connection. Please check your network.';
    case DioExceptionType.connectionTimeout:
      return 'Connection timed out. The server took too long to respond.';
    // case DioExceptionType.sendTimeout:
    //   return 'Request timed out while sending data.';
    case DioExceptionType.receiveTimeout:
      return 'Response timed out. The server is taking too long.';
    case DioExceptionType.badResponse:
      return _handleStatusCode(
        e.response?.statusCode,
        e.response?.data,
      );
    case DioExceptionType.cancel:
      return 'Request was cancelled.';

    default:
      return e.message ??
          'An unknown network error occurred.';
  }
}

String _handleStatusCode(int? statusCode, dynamic data) {
  final apiMessage = data is Map
      ? (data['status']?['error_message'] as String?)
      : null;
  debugPrint('Badresponse $statusCode');

  switch (statusCode) {
    case 400:
      return apiMessage ?? 'Bad request (400)';
    case 401:
      return 'Your are unauthorized (401)';
    case 403:
      return apiMessage ?? 'Access forbidden (403)';
    case 404:
      return apiMessage ?? 'Resource not found (404)';
    case 422:
      return apiMessage ?? 'Unprocessable request (422)';
    case 500:
      return apiMessage ?? 'Internal server error (500)';
    case 503:
      return apiMessage ?? 'Service unavailable (503)';
    case 504:
      return apiMessage ?? 'Gateway timed out (504)';

    default:
      if (statusCode != null &&
          statusCode >= 400 &&
          statusCode < 500) {
        return apiMessage ?? 'Client error ($statusCode).';
      }
      if (statusCode != null && statusCode >= 500) {
        return apiMessage ?? 'Server error ($statusCode).';
      }
      return apiMessage ??
          'Unexpected response ($statusCode).';
  }
}
