import 'package:flutter/material.dart';
import 'package:list/features/crypto-list/widgets/widgets.dart';
import 'package:list/repositories/crypto_coins/crypto_coins_rep.dart';
import 'package:list/repositories/crypto_coins/models/crypto_coin.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinList;

  @override
  void initState() {
    _loadCryptoCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: (_cryptoCoinList == null)
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.only(top: 5),
              itemCount: _cryptoCoinList!.length,
              separatorBuilder: (context, index) => Divider(
                    color: Theme.of(context).dividerColor,
                  ),
              itemBuilder: (context, i) {
                final coin = _cryptoCoinList![i];
                return CryptoCoinTile(coin: coin);
              }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.update_outlined),
        onPressed: () async {
          await _loadCryptoCoins();
        },
      ),
    );
  }

  Future<void> _loadCryptoCoins() async {
    final coinsList = await CryptoCoinsRep().getCoinsList();
    setState(() {
      _cryptoCoinList = coinsList;
    });
  }
}




// floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.update_outlined),
//         onPressed: () async {
//           final coinsList = await CryptoCoinsRep().getCoinsList();
//           setState(() {
//             _cryptoCoinList = coinsList;
//           });
//         },
//       ),
//update button moved to Appbar
// class CryptoListScreen extends StatefulWidget {
//   const CryptoListScreen({super.key, required this.title});

//   final String title;

//   @override
//   State<CryptoListScreen> createState() => _CryptoListScreenState();
// }

// class _CryptoListScreenState extends State<CryptoListScreen> {
//   List<CryptoCoin>? _cryptoCoinList;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.update),
//             onPressed: () async {
//               final coinsList = await CryptoCoinsRep().getCoinsList();
//               setState(() {
//                 _cryptoCoinList = coinsList;
//               });
//             },
//           ),
//         ],
//       ),
//       body: (_cryptoCoinList == null)
//           ? const SizedBox()
//           : ListView.separated(
//               itemCount: _cryptoCoinList!.length,
//               separatorBuilder: (context, index) => Divider(
//                     color: Theme.of(context).dividerColor,
//                   ),
//               itemBuilder: (context, i) {
//                 final coin = _cryptoCoinList![i];
//                 final coinName = coin.name;
//                 return CryptoCoinTile(coinName: coinName);
//               }),
//     );
//   }
// }
