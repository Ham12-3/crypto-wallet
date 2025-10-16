import '../models/cryptocurrency_model.dart';

abstract class SwapDataSource {
  Future<List<CryptocurrencyModel>> getAvailableCryptocurrencies();
  Future<double> getExchangeRate(String fromSymbol, String toSymbol);
  Future<double> getNetworkFee(String symbol);
}

class SwapDataSourceImpl implements SwapDataSource {
  // Mock data for available cryptocurrencies
  @override
  Future<List<CryptocurrencyModel>> getAvailableCryptocurrencies() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const CryptocurrencyModel(
        id: 'eth',
        symbol: 'ETH',
        name: 'Ethereum',
        iconPath: 'assets/images/eth_icon.png',
        balance: 2.5,
        currentPrice: 3000.0,
      ),
      const CryptocurrencyModel(
        id: 'btc',
        symbol: 'BTC',
        name: 'Bitcoin',
        iconPath: 'assets/images/btc_icon.png',
        balance: 0.5,
        currentPrice: 38920.75,
      ),
      const CryptocurrencyModel(
        id: 'usdt',
        symbol: 'USDT',
        name: 'Tether',
        iconPath: 'assets/images/usdt_icon.png',
        balance: 5000.0,
        currentPrice: 1.0,
      ),
      const CryptocurrencyModel(
        id: 'sol',
        symbol: 'SOL',
        name: 'Solana',
        iconPath: 'assets/images/sol_icon.png',
        balance: 10.0,
        currentPrice: 98.5,
      ),
      const CryptocurrencyModel(
        id: 'ada',
        symbol: 'ADA',
        name: 'Cardano',
        iconPath: 'assets/images/ada_icon.png',
        balance: 1000.0,
        currentPrice: 0.45,
      ),
    ];
  }

  // Mock exchange rates
  @override
  Future<double> getExchangeRate(String fromSymbol, String toSymbol) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Mock exchange rate calculations based on USD prices
    final prices = {
      'ETH': 3000.0,
      'BTC': 38920.75,
      'USDT': 1.0,
      'SOL': 98.5,
      'ADA': 0.45,
      'LTC': 72.0,
    };

    if (fromSymbol == toSymbol) return 1.0;

    final fromPrice = prices[fromSymbol] ?? 1.0;
    final toPrice = prices[toSymbol] ?? 1.0;

    return fromPrice / toPrice;
  }

  // Mock network fee calculation
  @override
  Future<double> getNetworkFee(String symbol) async {
    await Future.delayed(const Duration(milliseconds: 200));

    // Mock network fees based on crypto type
    final fees = {
      'ETH': 0.001,
      'BTC': 0.00005,
      'USDT': 1.0,
      'SOL': 0.00025,
      'ADA': 0.17,
      'LTC': 0.001,
    };

    return fees[symbol] ?? 0.001;
  }
}
