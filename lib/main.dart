import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const List());
}

class List extends StatelessWidget {
  const List({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency List',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.amber,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.amber,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  color: Color.fromARGB(255, 11, 136, 246),
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          dividerColor: Colors.grey,
          listTileTheme: const ListTileThemeData(
              iconColor: Color.fromARGB(255, 11, 136, 246)),
          textTheme: TextTheme(
              bodyMedium: const TextStyle(
                  color: Color.fromARGB(255, 11, 136, 246),
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
              labelSmall: TextStyle(
                  color: Colors.blue.withOpacity(0.6),
                  fontSize: 14,
                  fontStyle: FontStyle.italic))),
      routes: {
        '/': (context) => const CryptoListScreen(
              title: 'Crypto Currency List',
            ),
        '/coin': (context) => const CryptoCoinScreen(),
      },
      // home: const CryptoListScreen(title: 'Crypto Currency List'),
    );
  }
}

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

            return ListTile(
              leading: SvgPicture.asset(
                'assets/Bitcoin.svg',
                height: 45,
                width: 45,
              ),
              title: Text(
                coinName,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                '104.3 \$',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.of(context).pushNamed('/coin', arguments: coinName);
              },
            );
          }),
    );
  }
}

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is String, 'You must provide String args');
    // if (args == null) {
    //   debugPrint('You must provide args');
    //   return;
    // }
    // if (args is! String) {
    //   debugPrint('You must provide String args');
    //   return;
    // }
    coinName = args as String;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? '...'),
      ),
    );
  }
}
