import 'package:flutterblocrandomupdate/price_model.dart';

abstract class PriceState{
  const PriceState();
}

class PricesLoading extends PriceState {
  @override

  List<Object> get props => [];
}

class PricesLoaded extends PriceState {
  final List<PriceModel> prices;
  const PricesLoaded({this.prices});

  @override

  List<Object> get props => [prices];

  PriceModel getById(int id) {
    return prices.where((element) => element.id == id).first;
  }

  @override
  String toString() => 'Loaded { prices: ${prices.length} }';
}

class PricesError extends PriceState {
  @override

  List<Object> get props => [];
}
