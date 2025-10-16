import 'package:equatable/equatable.dart';
import '../../domain/entities/cryptocurrency.dart';

abstract class SwapEvent extends Equatable {
  const SwapEvent();

  @override
  List<Object?> get props => [];
}

class LoadSwapData extends SwapEvent {}

class UpdateFromAmount extends SwapEvent {
  final String amount;

  const UpdateFromAmount(this.amount);

  @override
  List<Object?> get props => [amount];
}

class SelectFromCurrency extends SwapEvent {
  final Cryptocurrency currency;

  const SelectFromCurrency(this.currency);

  @override
  List<Object?> get props => [currency];
}

class SelectToCurrency extends SwapEvent {
  final Cryptocurrency currency;

  const SelectToCurrency(this.currency);

  @override
  List<Object?> get props => [currency];
}

class SwapCurrencies extends SwapEvent {}

class ExecuteSwap extends SwapEvent {}
