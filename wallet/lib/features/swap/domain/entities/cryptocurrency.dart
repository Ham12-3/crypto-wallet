import 'package:equatable/equatable.dart';

class Cryptocurrency extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String iconPath;
  final double balance;
  final double currentPrice; // Price in USD

  const Cryptocurrency({
    required this.id,
    required this.symbol,
    required this.name,
    required this.iconPath,
    required this.balance,
    required this.currentPrice,
  });

  @override
  List<Object?> get props => [id, symbol, name, iconPath, balance, currentPrice];
}
