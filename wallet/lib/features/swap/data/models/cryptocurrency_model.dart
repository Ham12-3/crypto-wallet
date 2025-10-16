import '../../domain/entities/cryptocurrency.dart';

class CryptocurrencyModel extends Cryptocurrency {
  const CryptocurrencyModel({
    required super.id,
    required super.symbol,
    required super.name,
    required super.iconPath,
    required super.balance,
    required super.currentPrice,
  });

  factory CryptocurrencyModel.fromJson(Map<String, dynamic> json) {
    return CryptocurrencyModel(
      id: json['id'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      iconPath: json['iconPath'] as String,
      balance: (json['balance'] as num).toDouble(),
      currentPrice: (json['currentPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'iconPath': iconPath,
      'balance': balance,
      'currentPrice': currentPrice,
    };
  }

  Cryptocurrency toEntity() {
    return Cryptocurrency(
      id: id,
      symbol: symbol,
      name: name,
      iconPath: iconPath,
      balance: balance,
      currentPrice: currentPrice,
    );
  }
}
