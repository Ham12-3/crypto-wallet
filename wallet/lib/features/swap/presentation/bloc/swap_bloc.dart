import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cryptocurrency.dart';
import 'swap_event.dart';
import 'swap_state.dart';

class SwapBloc extends Bloc<SwapEvent, SwapState> {
  SwapBloc() : super(const SwapState()) {
    on<LoadSwapData>(_onLoadSwapData);
    on<UpdateFromAmount>(_onUpdateFromAmount);
    on<SelectFromCurrency>(_onSelectFromCurrency);
    on<SelectToCurrency>(_onSelectToCurrency);
    on<SwapCurrencies>(_onSwapCurrencies);
    on<ExecuteSwap>(_onExecuteSwap);
  }

  void _onLoadSwapData(LoadSwapData event, Emitter<SwapState> emit) {
    // Mock data for demonstration
    final currencies = [
      const Cryptocurrency(
        id: 'eth',
        symbol: 'ETH',
        name: 'Ethereum',
        iconPath: 'assets/images/eth_icon.png',
        balance: 2.5,
        currentPrice: 3000.0,
      ),
      const Cryptocurrency(
        id: 'usdt',
        symbol: 'USDT',
        name: 'Tether',
        iconPath: 'assets/images/usdt_icon.png',
        balance: 5000.0,
        currentPrice: 1.0,
      ),
      const Cryptocurrency(
        id: 'btc',
        symbol: 'BTC',
        name: 'Bitcoin',
        iconPath: 'assets/images/btc_icon.png',
        balance: 0.5,
        currentPrice: 68500.0,
      ),
      const Cryptocurrency(
        id: 'bnb',
        symbol: 'BNB',
        name: 'Binance Coin',
        iconPath: 'assets/images/bnb_icon.png',
        balance: 10.0,
        currentPrice: 600.0,
      ),
    ];

    emit(state.copyWith(
      availableCurrencies: currencies,
      fromCurrency: currencies[0], // ETH
      toCurrency: currencies[1], // USDT
      fromAmount: 1.0,
      exchangeRate: 3000.0,
      toAmount: 3000.0,
    ));
  }

  void _onUpdateFromAmount(UpdateFromAmount event, Emitter<SwapState> emit) {
    final amount = double.tryParse(event.amount) ?? 0.0;
    final toAmount = amount * state.exchangeRate;

    emit(state.copyWith(
      fromAmount: amount,
      toAmount: toAmount,
    ));
  }

  void _onSelectFromCurrency(SelectFromCurrency event, Emitter<SwapState> emit) {
    // Calculate new exchange rate
    final newExchangeRate = event.currency.currentPrice / (state.toCurrency?.currentPrice ?? 1);
    final newToAmount = state.fromAmount * newExchangeRate;

    emit(state.copyWith(
      fromCurrency: event.currency,
      exchangeRate: newExchangeRate,
      toAmount: newToAmount,
    ));
  }

  void _onSelectToCurrency(SelectToCurrency event, Emitter<SwapState> emit) {
    // Calculate new exchange rate
    final newExchangeRate = (state.fromCurrency?.currentPrice ?? 1) / event.currency.currentPrice;
    final newToAmount = state.fromAmount * newExchangeRate;

    emit(state.copyWith(
      toCurrency: event.currency,
      exchangeRate: newExchangeRate,
      toAmount: newToAmount,
    ));
  }

  void _onSwapCurrencies(SwapCurrencies event, Emitter<SwapState> emit) {
    final tempCurrency = state.fromCurrency;
    final tempAmount = state.fromAmount;

    final newExchangeRate = (state.toCurrency?.currentPrice ?? 1) / (state.fromCurrency?.currentPrice ?? 1);
    final newToAmount = state.toAmount * newExchangeRate;

    emit(state.copyWith(
      fromCurrency: state.toCurrency,
      toCurrency: tempCurrency,
      fromAmount: state.toAmount,
      toAmount: newToAmount,
      exchangeRate: newExchangeRate,
    ));
  }

  void _onExecuteSwap(ExecuteSwap event, Emitter<SwapState> emit) async {
    emit(state.copyWith(isLoading: true));

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock successful swap
    emit(state.copyWith(
      isLoading: false,
      swapSuccess: true,
    ));

    // Reset success state after a short delay
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(swapSuccess: false));
  }
}
