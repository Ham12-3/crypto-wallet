import 'package:equatable/equatable.dart';
import 'cryptocurrency.dart';

class SwapTransaction extends Equatable {
  final Cryptocurrency fromCrypto;
  final Cryptocurrency toCrypto;
  final double fromAmount;
  final double toAmount;
  final double exchangeRate;
  final double networkFee;
  final DateTime timestamp;

  const SwapTransaction({
    required this.fromCrypto,
    required this.toCrypto,
    required this.fromAmount,
    required this.toAmount,
    required this.exchangeRate,
    required this.networkFee,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        fromCrypto,
        toCrypto,
        fromAmount,
        toAmount,
        exchangeRate,
        networkFee,
        timestamp,
      ];
}
