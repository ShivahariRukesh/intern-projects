import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:simple_crypto_demo/data/model/coin_model.dart';
import 'package:simple_crypto_demo/data/service/api_service.dart';
import 'package:simple_crypto_demo/utils/error_handler.dart';
import 'package:simple_crypto_demo/utils/result.dart';

class OldCryptoService {
  final Dio _apiService = ApiService().dio;

  Future<Result<CoinModel>> getCoinMetaData() async {
    try {
      final int randomCoinId = Random().nextInt(200) + 100;
      await Future.delayed(const Duration(seconds: 2));
      final response = await _apiService.get(
        'v1/exchange/info',
        queryParameters: {'id': randomCoinId},
      );
      final jsonData = jsonDecode(response.toString());

      final CoinModel coinMetaData = CoinModel.fromJson(
        jsonData['data'],
      );
      return Success(coinMetaData);
    } on DioException catch (e) {
      debugPrint('Unexpected error: ${e.toString()}');
      return Failure(handleDioError(e));
    } on FormatException catch (e) {
      debugPrint('Format Exception : $e.toString()');
      return const Failure('Unformatted data');
    } on TypeError catch (e) {
      debugPrint('Type Error : $e');
      return const Failure('Type error issue');
    } catch (e) {
      debugPrint('Unexpected error: ${e.toString()}');
      return const Failure('Something went wrong}');
    }
  }
}
