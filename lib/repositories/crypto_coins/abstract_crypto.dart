import 'package:list/repositories/crypto_coins/models/crypto_coin.dart';

abstract class AbstractCoinsRep {
  Future<List<CryptoCoin>> getCoinsList();
}
