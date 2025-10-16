import '../entities/cryptocurrency.dart';

abstract class SwapRepository {
  Future<List<Cryptocurrency>> getAvailableCryptocurrencies();
  Future<double> getExchangeRate(String fromSymbol, String toSymbol);
  Future<double> getNetworkFee(String symbol);
  Future<bool> executeSwap({
    required Cryptocurrency fromCrypto,
    required Cryptocurrency toCrypto,
    required double amount,
  });
}
