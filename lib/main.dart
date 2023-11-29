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
      home: const MyHomePage(title: 'Crypto Currency List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter += 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        // leading: Icon(Icons.home),
      ),

      body: ListView.separated(
          itemCount: 10,
          separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).dividerColor,
              ),
          itemBuilder: (context, i) => ListTile(
                leading: SvgPicture.asset(
                  'assets/Bitcoin.svg',
                  height: 45,
                  width: 45,
                ),
                title: Text(
                  "Currency",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  "too much",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              )),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
