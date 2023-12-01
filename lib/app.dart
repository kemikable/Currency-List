import 'package:flutter/material.dart';
import 'package:list/routes/routes.dart';
import 'package:list/theme/theme.dart';

class CurrencyList extends StatelessWidget {
  const CurrencyList({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Currency List', theme: darkTheme, routes: routes);
  }
}
