// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:list/repositories/crypto_coins/crypto_coins.dart';

class CryptoCoinsRep implements AbstractCoinsRep {
  CryptoCoinsRep({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,TRX,MKR,LINK,SHIB,ATOM,XRP,SOL,USDC,ADA,DOGE,ETC,BNB,AVAX,TON,USDT,LTC,BCH,XMR&tsyms=USD');
    final data = response.data as Map<String, dynamic>;

    final dataRaw = data['RAW'] as Map<String, dynamic>;

    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'];
      final logo = usdData['IMAGEURL'];
      return CryptoCoin(
          name: e.key,
          priceUSD: price,
          logo: 'https://www.cryptocompare.com/$logo');
    }).toList();
    return cryptoCoinsList;
  }
}
