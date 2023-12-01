import 'package:list/features/crypto-coin/cryptocoin.dart';
import 'package:list/features/crypto-list/cryptolist.dart';

final routes = {
  '/': (context) => const CryptoListScreen(
        title: 'Crypto Currency List',
      ),
  '/coin': (context) => const CryptoCoinScreen(),
};
