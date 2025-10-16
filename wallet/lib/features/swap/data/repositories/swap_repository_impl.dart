import '../../domain/entities/cryptocurrency.dart';
import '../../domain/repositories/swap_repository.dart';
import '../datasources/swap_datasource.dart';

class SwapRepositoryImpl implements SwapRepository {
  final SwapDataSource dataSource;

  SwapRepositoryImpl({required this.dataSource});

  @override
  Future<List<Cryptocurrency>> getAvailableCryptocurrencies() async {
    try {
      final models = await dataSource.getAvailableCryptocurrencies();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get available cryptocurrencies: $e');
    }
  }

  @override
  Future<double> getExchangeRate(String fromSymbol, String toSymbol) async {
    try {
      return await dataSource.getExchangeRate(fromSymbol, toSymbol);
    } catch (e) {
      throw Exception('Failed to get exchange rate: $e');
    }
  }

  @override
  Future<double> getNetworkFee(String symbol) async {
    try {
      return await dataSource.getNetworkFee(symbol);
    } catch (e) {
      throw Exception('Failed to get network fee: $e');
    }
  }

  @override
  Future<bool> executeSwap({
    required Cryptocurrency fromCrypto,
    required Cryptocurrency toCrypto,
    required double amount,
  }) async {
    try {
      // In a real app, this would call an API to execute the swap
      await Future.delayed(const Duration(seconds: 2));

      // Validate balance
      if (amount > fromCrypto.balance) {
        throw Exception('Insufficient balance');
      }

      return true;
    } catch (e) {
      throw Exception('Failed to execute swap: $e');
    }
  }
}
