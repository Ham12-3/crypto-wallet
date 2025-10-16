import 'package:equatable/equatable.dart';
import '../../domain/entities/cryptocurrency.dart';

class SwapState extends Equatable {
  final List<Cryptocurrency> availableCurrencies;
  final Cryptocurrency? fromCurrency;
  final Cryptocurrency? toCurrency;
  final double fromAmount;
  final double toAmount;
  final double exchangeRate;
  final double networkFee;
  final bool isLoading;
  final String? errorMessage;
  final bool swapSuccess;

  const SwapState({
    this.availableCurrencies = const [],
    this.fromCurrency,
    this.toCurrency,
    this.fromAmount = 0.0,
    this.toAmount = 0.0,
    this.exchangeRate = 0.0,
    this.networkFee = 0.001,
    this.isLoading = false,
    this.errorMessage,
    this.swapSuccess = false,
  });

  SwapState copyWith({
    List<Cryptocurrency>? availableCurrencies,
    Cryptocurrency? fromCurrency,
    Cryptocurrency? toCurrency,
    double? fromAmount,
    double? toAmount,
    double? exchangeRate,
    double? networkFee,
    bool? isLoading,
    String? errorMessage,
    bool? swapSuccess,
  }) {
    return SwapState(
      availableCurrencies: availableCurrencies ?? this.availableCurrencies,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      fromAmount: fromAmount ?? this.fromAmount,
      toAmount: toAmount ?? this.toAmount,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      networkFee: networkFee ?? this.networkFee,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      swapSuccess: swapSuccess ?? this.swapSuccess,
    );
  }

  @override
  List<Object?> get props => [
        availableCurrencies,
        fromCurrency,
        toCurrency,
        fromAmount,
        toAmount,
        exchangeRate,
        networkFee,
        isLoading,
        errorMessage,
        swapSuccess,
      ];
}
