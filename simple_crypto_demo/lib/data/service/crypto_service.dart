import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_crypto_demo/data/model/coin_model.dart';
import 'package:simple_crypto_demo/data/service/api_service.dart';
import 'package:simple_crypto_demo/utils/error_handler.dart';
import 'package:simple_crypto_demo/utils/result.dart';

class CryptoService {
  final Dio _apiService = ApiService().dio;
  Future<Result<List<CoinModel>>> fetchAllCoinData() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final response = await _apiService.get(
        '',
        queryParameters: {'limit': 10},
      );

      final value = jsonDecode(response.toString());

      final coinDetails = (value['data'] as List)
          .map((val) => CoinModel.fromJson(val))
          .toList();

      return Success(coinDetails);
    } on DioException catch (e) {
      return Failure(handleDioError(e));
    } on FormatException {
      return const Failure(
        'Received malformed data from the server.',
      );
    } catch (e) {
      debugPrint('Unexpected error: ${e.toString()}');
      return const Failure('Something went wrong!!');
    }
  }
}
