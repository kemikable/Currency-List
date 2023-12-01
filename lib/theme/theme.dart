import 'package:flutter/material.dart';

final darkTheme = ThemeData(
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
    listTileTheme:
        const ListTileThemeData(iconColor: Color.fromARGB(255, 11, 136, 246)),
    textTheme: TextTheme(
        bodyMedium: const TextStyle(
            color: Color.fromARGB(255, 11, 136, 246),
            fontSize: 22,
            fontWeight: FontWeight.w600),
        labelSmall: TextStyle(
            color: Colors.blue.withOpacity(0.6),
            fontSize: 14,
            fontStyle: FontStyle.italic)));
