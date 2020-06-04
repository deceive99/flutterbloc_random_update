abstract class PriceEvent {
  const PriceEvent();
}

class LoadPrices extends PriceEvent {
  @override

  List<Object> get props =>[];
}


class UpdatePrices extends PriceEvent {
  final Object newPrice;
  const UpdatePrices(this.newPrice);

  @override

  List<Object> get props => [this.newPrice];
}