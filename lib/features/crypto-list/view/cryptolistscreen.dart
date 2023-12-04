import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:list/features/crypto-list/bloc/crypto_list_bloc.dart';
import 'package:list/features/crypto-list/widgets/crypto_coin_tile.dart';
import '../../../repositories/crypto_coins/crypto_coins.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  // List<CryptoCoin>? _cryptoCoinList;

  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRep>());

  @override
  void initState() {
    // _loadCryptoCoins();
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<CryptoListBloc, CryptoListState>(
        bloc: _cryptoListBloc,
        builder: (context, state) {
          if (state is CryptoListLoaded) {
            return ListView.separated(
                padding: const EdgeInsets.only(top: 5),
                itemCount: state.coinsList.length,
                separatorBuilder: (context, index) => Divider(
                      color: Theme.of(context).dividerColor,
                    ),
                itemBuilder: (context, i) {
                  final coin = state.coinsList[i];
                  return CryptoCoinTile(coin: coin);
                });
          }
          if (state is CryptoListLoadingFailure) {
            return const Center(
                child: Text('Something went wrong. Please try again later'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),

      // (_cryptoCoinList == null)
      //     ? const Center(child: CircularProgressIndicator())
      //     : ListView.separated(
      //         padding: const EdgeInsets.only(top: 5),
      //         itemCount: _cryptoCoinList!.length,
      //         separatorBuilder: (context, index) => Divider(
      //               color: Theme.of(context).dividerColor,
      //             ),
      //         itemBuilder: (context, i) {
      //           final coin = _cryptoCoinList![i];
      //           return CryptoCoinTile(coin: coin);
      //         }),

      ///////
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.update_outlined),
      //   onPressed: () async {
      //     await _loadCryptoCoins();
      //   },
      // ),
    );
  }

  // Future<void> _loadCryptoCoins() async {
  //   final coinsList = await GetIt.I<AbstractCoinsRep>().getCoinsList();
  //   setState(() {
  //     _cryptoCoinList = coinsList;
  //   });
  // }
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
