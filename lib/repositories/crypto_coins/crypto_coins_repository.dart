// import 'package:dio/dio.dart';

// import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class CryptoCoinsRepository implements AbstractCoinsRepository {
//   CryptoCoinsRepository({
//     required this.dio,
//     required this.cryptoCoinsBox,
//   });

//   final Dio dio;

//   final Box<CryptoCoin> cryptoCoinsBox;

//   @override
//   Future<List<CryptoCoin>> getCoinsList() async {
//     final response = await dio.get(
//         'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,TRX,MKR,LINK,SHIB,ATOM,XRP,SOL,USDC,ADA,DOGE,ETC,BNB,AVAX,TON,USDT,LTC,BCH,XMR&tsyms=USD');

//     final data = response.data as Map<String, dynamic>;
//     final dataRaw = data['RAW'] as Map<String, dynamic>;
//     final cryptoCoinsList = dataRaw.entries.map((e) {
//       final usdData =
//           (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;

//       final details = CryptoCoinDetail.fromJson(usdData);

//       return CryptoCoin(
//         name: e.key,
//         details: details,
//       );
//     }).toList();

//     final cryptoCoinsMap = {for (var e in cryptoCoinsList) e.name: e};
//     await cryptoCoinsBox.putAll(cryptoCoinsMap);
//     return cryptoCoinsList;
//   }

//   @override
//   Future<CryptoCoin> getCoinDetails(String currencyCode) async {
//     final response = await dio.get(
//         'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');

//     final data = response.data as Map<String, dynamic>;
//     final dataRaw = data['RAW'] as Map<String, dynamic>;
//     final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
//     final usdData = coinData['USD'] as Map<String, dynamic>;
//     final details = CryptoCoinDetail.fromJson(usdData);

//     return CryptoCoin(
//       name: currencyCode,
//       details: details,
//     );
//   }
// }

import 'package:dio/dio.dart';

import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
    required this.cryptoCoinsBox,
  });

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var cryptoCoinsList = <CryptoCoin>[];
    try {
      cryptoCoinsList = await _fetchCoinsListFromApi();
      final cryptoCoinsMap = {for (var e in cryptoCoinsList) e.name: e};
      await cryptoCoinsBox.putAll(cryptoCoinsMap);
    } catch (e, st) {
      GetIt.instance<Talker>().handle(e, st);
      cryptoCoinsList = cryptoCoinsBox.values.toList();
    }

// sort by price!!!!!!!!
    cryptoCoinsList
        .sort((a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD));
// sort by name!!!!!!!!
    // cryptoCoinsList.sort((a, b) => a.name.compareTo(b.name));
    return cryptoCoinsList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,TRX,MKR,LINK,SHIB,ATOM,XRP,SOL,USDC,ADA,DOGE,ETC,BNB,AVAX,TON,USDT,LTC,BCH,XMR&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final details = CryptoCoinDetail.fromJson(usdData);
      return CryptoCoin(name: e.key, details: details);
    }).toList();
    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    try {
      final coin = await _fetchCoinDetailsFromApi(currencyCode);
      cryptoCoinsBox.put(currencyCode, coin);
      return coin;
    } catch (e, st) {
      GetIt.instance<Talker>().handle(e, st);
      return cryptoCoinsBox.get(currencyCode)!;
    }
  }

  Future<CryptoCoin> _fetchCoinDetailsFromApi(String currencyCode) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);
    return CryptoCoin(name: currencyCode, details: details);
  }
}

// import 'dart:convert';
// import 'package:dio/src/dio.dart';
// import 'package:http/http.dart' as http;
// import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:talker_flutter/talker_flutter.dart';

// class CryptoCoinsRepository implements AbstractCoinsRepository {
//   CryptoCoinsRepository({
//     required this.cryptoCoinsBox, required Dio dio,
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

//     // sort by name
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
