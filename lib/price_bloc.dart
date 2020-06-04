import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocrandomupdate/price_event.dart';
import 'package:flutterblocrandomupdate/price_model.dart';
import 'package:flutterblocrandomupdate/price_state.dart';

class PriceBloc extends Bloc<PriceEvent, PriceState> {
  @override

  PriceState get initialState => PricesLoaded(
    prices: List.of([
        PriceModel(
          id: 1,
          changePercentage: 1,
          coinCode: "BTC",
          coinName: "Bitcoin",
          closePrice: 1000000,
          highPrice: 10000,
          transType: 100000,
          volume: 1000000,
          lowPrice: 10000
        ),
        PriceModel(
            id: 2,
            changePercentage: 1,
            coinCode: "ETH",
            coinName: "Ethereum",
            closePrice: 1000000,
            highPrice: 10000,
            transType: 100000,
            volume: 1000000,
            lowPrice: 10000
        )
    ])
  );

  @override
  Stream<PriceState> mapEventToState(PriceEvent event) async* {
    if (event is UpdatePrices) {
      yield* _mapUpdatePricesToState(event);
    }

    if(event is LoadPrices){
      PricesLoaded finalState = state;
      new Timer.periodic(Duration(milliseconds: 100), (Timer t) {
        var randomPrice = new Random();
        int price = randomPrice.nextInt(10000000);

        var randomTranstype = new Random();
        int transtype = randomTranstype.nextInt(1);

        var randomId = new Random();
        int _id = randomId.nextInt(finalState.prices.length);

        String mockSocketJSON =
            '{"category":"trade","i": $_id,"u":1,"c":"BTC","n":"Bitcoin","b":108105000,"a":108119000,"cp":0,"cl":$price,"v":$price,"h":111539000,"l":107533000,"o":110945000,"d":3,"mk":1960246534239000, "t": [[1588095652, $transtype, 3009000, 35528390, 11.807374543038]]}';
        var socket = json.decode(mockSocketJSON);
        add(UpdatePrices(socket));
      });
    }
  }

  Stream<PriceState> _mapUpdatePricesToState(UpdatePrices event) async* {
    final priceState = state;
    if (priceState is PricesLoaded) {
      List<PriceModel> oldPrices = List.from(priceState.prices);

      dynamic newPrice = event.newPrice;
      try{
        oldPrices.forEach((element) {
          if (element.id.toString() == newPrice["i"].toString()) {
            element.id = newPrice["i"];
            element.coinCode = newPrice['c'];
            element.coinName = newPrice['n'];
            element.closePrice = newPrice['cl'].toDouble();
            element.highPrice = newPrice['h'].toDouble();
            element.lowPrice = newPrice['l'].toDouble();
            element.openPrice = newPrice['o'].toDouble();
            element.volume = newPrice['v'].toDouble();
            element.changePercentage = (newPrice['cp']).toDouble();
            element.transType = newPrice['t'][0][1];
          }
          return element;
        });
//        yield PricesLoaded(prices: oldPrices);
      }catch(e){
        print(e);
      }
    }
  }
}
