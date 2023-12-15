// import 'dart:async';

// import 'package:crypto_coins_list/crypto_coins_list_app.dart';
// import 'package:crypto_coins_list/firebase_options.dart';
// import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:talker_bloc_logger/talker_bloc_logger.dart';
// import 'package:talker_dio_logger/talker_dio_logger.dart';
// import 'package:talker_flutter/talker_flutter.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final app = await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   final talker = TalkerFlutter.init();
//   GetIt.I.registerSingleton(talker);
//   GetIt.I<Talker>().debug('Talker started...');

//   talker.info(app.options.projectId);
//   await Hive.initFlutter();
//   Hive.registerAdapter(CryptoCoinAdapter());
//   Hive.registerAdapter(CryptoCoinDetailAdapter());

//   final cryptoCoinsBox = await Hive.openBox<CryptoCoin>('crypto_coins_box');

//   final dio = Dio();
//   dio.interceptors.add(
//     TalkerDioLogger(
//       talker: talker,
//       settings: const TalkerDioLoggerSettings(
//         printResponseData: false,
//       ),
//     ),
//   );

//   Bloc.observer = TalkerBlocObserver(
//     talker: talker,
//     settings: const TalkerBlocLoggerSettings(
//       printStateFullData: false,
//       printEventFullData: false,
//     ),
//   );

//   GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
//     () => CryptoCoinsRepository(dio: dio, cryptoCoinsBox: cryptoCoinsBox),
//   );

//   FlutterError.onError =
//       (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

//   runZonedGuarded(() => runApp(const CryptoCurrenciesListApp()), (e, st) {
//     GetIt.I<Talker>().handle(e, st);
//   });
// }

// import 'dart:async';

// import 'package:crypto_coins_list/crypto_coins_list_app.dart';
// import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:talker_bloc_logger/talker_bloc_logger.dart';
// import 'package:talker_dio_logger/talker_dio_logger.dart';
// import 'package:talker_flutter/talker_flutter.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final talker = TalkerFlutter.init();
//   GetIt.I.registerSingleton(talker);
//   GetIt.I<Talker>().debug('Talker started...');

//   const cryptoCoinsBoxName = 'crypto_coins_box';

//   await Hive.initFlutter();

//   Hive.registerAdapter(CryptoCoinAdapter());
//   Hive.registerAdapter(CryptoCoinDetailAdapter());

//   final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

//   final dio = Dio();
//   dio.interceptors.add(
//     TalkerDioLogger(
//       talker: talker,
//       settings: const TalkerDioLoggerSettings(
//         printResponseData: false,
//       ),
//     ),
//   );

//   Bloc.observer = TalkerBlocObserver(
//     talker: talker,
//     settings: const TalkerBlocLoggerSettings(
//       printStateFullData: false,
//       printEventFullData: false,
//     ),
//   );

//   GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
//     () => CryptoCoinsRepository(
//       dio: dio,
//       cryptoCoinsBox: cryptoCoinsBox,
//     ),
//   );

//   FlutterError.onError =
//       (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

//   runZonedGuarded(() => runApp(const CryptoCurrenciesListApp()), (e, st) {
//     GetIt.I<Talker>().handle(e, st);
//   });
// }

import 'package:crypto_coins_list/crypto_coins_list_app.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');

  const cryptoCoinsBoxName = 'crypto_coins_box';

  await Hive.initFlutter();

  Hive.registerAdapter(CryptoCoinAdapter());
  Hive.registerAdapter(CryptoCoinDetailAdapter());

  final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      ),
    ),
  );

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
    () => CryptoCoinsRepository(
      dio: dio,
      cryptoCoinsBox: cryptoCoinsBox,
    ),
  );

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runApp(const CryptoCurrenciesListApp());
}

// import 'package:crypto_coins_list/crypto_coins_list_app.dart';
// import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:talker_bloc_logger/talker_bloc_logger.dart';
// import 'package:talker_flutter/talker_flutter.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final talker = TalkerFlutter.init();
//   GetIt.I.registerSingleton(talker);
//   GetIt.I<Talker>().debug('Talker started...');

//   const cryptoCoinsBoxName = 'crypto_coins_box';

//   await Hive.initFlutter();

//   Hive.registerAdapter(CryptoCoinAdapter());
//   Hive.registerAdapter(CryptoCoinDetailAdapter());

//   final cryptoCoinsBox = await Hive.openBox<CryptoCoin>(cryptoCoinsBoxName);

//   Bloc.observer = TalkerBlocObserver(
//     talker: talker,
//     settings: const TalkerBlocLoggerSettings(
//       printStateFullData: false,
//       printEventFullData: false,
//     ),
//   );

//   GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
//     () => CryptoCoinsRepository(
//       cryptoCoinsBox: cryptoCoinsBox,
//     ),
//   );

//   FlutterError.onError =
//       (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

//   runApp(const CryptoCurrenciesListApp());
// }

// class CryptoCoinsRepository implements AbstractCoinsRepository {
//   CryptoCoinsRepository({
//     required this.cryptoCoinsBox,
//   });

//   final Box<CryptoCoin> cryptoCoinsBox;

//   @override
//   Future<List<CryptoCoin>> getCoinsList() async {
//     var cryptoCoinsList = <CryptoCoin>[];
//     try {
//       cryptoCoinsList = await _fetchCoinsListFromApi();
//       final cryptoCoinsMap = {for (var e in cryptoCoinsList) e.name: e};
//       await cryptoCoinsBox.putAll(cryptoCoinsMap);
//     } catch (e, st) {
//       GetIt.instance<Talker>().handle(e, st);
//       cryptoCoinsList = cryptoCoinsBox.values.toList();
//     }

//     cryptoCoinsList.sort((a, b) => a.name.compareTo(b.name));
//     return cryptoCoinsList;
//   }

//   Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
//     final response = await http.get(Uri.parse(
//         'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,TRX,MKR,LINK,SHIB,ATOM,XRP,SOL,USDC,ADA,DOGE,ETC,BNB,AVAX,TON,USDT,LTC,BCH,XMR&tsyms=USD'));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body) as Map<String, dynamic>;
//       final dataRaw = data['RAW'] as Map<String, dynamic>;

//       final cryptoCoinsList = dataRaw.entries.map((e) {
//         final usdData =
//             (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
//         final details = CryptoCoinDetail.fromJson(usdData);
//         return CryptoCoin(name: e.key, details: details);
//       }).toList();

//       return cryptoCoinsList;
//     } else {
//       throw Exception('Failed to load coins list');
//     }
//   }

//   @override
//   Future<CryptoCoin> getCoinDetails(String currencyCode) async {
//     try {
//       final coin = await _fetchCoinDetailsFromApi(currencyCode);
//       cryptoCoinsBox.put(currencyCode, coin);
//       return coin;
//     } catch (e, st) {
//       GetIt.instance<Talker>().handle(e, st);
//       return cryptoCoinsBox.get(currencyCode)!;
//     }
//   }

//   Future<CryptoCoin> _fetchCoinDetailsFromApi(String currencyCode) async {
//     final response = await http.get(Uri.parse(
//         'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD'));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body) as Map<String, dynamic>;
//       final dataRaw = data['RAW'] as Map<String, dynamic>;

//       final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
//       final usdData = coinData['USD'] as Map<String, dynamic>;
//       final details = CryptoCoinDetail.fromJson(usdData);

//       return CryptoCoin(name: currencyCode, details: details);
//     } else {
//       throw Exception('Failed to load coin details');
//     }
//   }
// }
