// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  const CryptoCoin({
    required this.name,
    required this.priceUSD,
    required this.logo,
  });
  final String name;
  final num priceUSD;
  final String logo;

  @override
  List<Object> get props => [name, priceUSD, logo];
}
