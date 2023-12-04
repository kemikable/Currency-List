import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:list/app.dart';
import 'package:list/repositories/crypto_coins/crypto_coins.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRep>(
      () => CryptoCoinsRep(dio: Dio()));
  runApp(const CurrencyList());
}
