import 'package:flutter/material.dart';
import 'package:list/features/crypto-list/widgets/widgets.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).dividerColor,
              ),
          itemBuilder: (context, i) {
            const coinName = 'Currency name';

            return const CryptoCoinTile(coinName: coinName);
          }),
    );
  }
}
