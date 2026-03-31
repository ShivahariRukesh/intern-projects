import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_crypto_demo/data/repository/crypto_repository.dart';
import 'package:simple_crypto_demo/data/service/crypto_service.dart';
import 'package:simple_crypto_demo/ui/features/coin_detail.dart/view_model/coin_meta_data_view_model.dart';
import 'package:simple_crypto_demo/ui/features/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:simple_crypto_demo/ui/features/home/view_model/home_view_model.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        Provider<CryptoService>(
          create: (_) => CryptoService(),
        ),
        ProxyProvider<CryptoService, CryptoRepository>(
          update: (_, service, __) =>
              CryptoRepository(service: service),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(
            repository: context.read<CryptoRepository>(),
          ),
        ),
        ChangeNotifierProvider<CoinMetaDataViewModel>(
          create: (context) => CoinMetaDataViewModel(),
        ),
      ],
      child: myApp(),
    ),
  );
}

Widget myApp() {
  return MaterialApp(
    title: 'Crypto-Currency Tracker App',
    home: Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        12,
        108,
        204,
      ),
      appBar: AppBar(
        title: const Text(
          'Crypto Tracker App',
          style: TextStyle(
            color: Color.fromARGB(206, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(
          255,
          11,
          58,
          97,
        ),
      ),
      body: const HomeScreen(),
    ),
  );
}
