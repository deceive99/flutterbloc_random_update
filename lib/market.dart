import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocrandomupdate/price_bloc.dart';
import 'package:flutterblocrandomupdate/price_event.dart';
import 'package:flutterblocrandomupdate/price_model.dart';
import 'package:flutterblocrandomupdate/price_state.dart';

import 'animated_close_price_widget.dart';

String mockJson =
    '[{"n":"Bitcoin","id":1,"cd":"BTC","c":107833000,"tt":1,"h":110740000,"l":107461000,"o":110581000,"v":42355156504,"cp":-2.485056203145206,"mk":1964454514486040},{"n":"Bitcoin Cash","id":2,"cd":"BCH","c":3559000,"tt":1,"h":3613000,"l":3521000,"o":3598000,"v":3457178133,"cp":-1.083935519733185,"mk":64734328450480},{"n":"Bitcoin SV","id":16,"cd":"BSV","c":2994000,"tt":1,"h":3067000,"l":2976000,"o":3064000,"v":3089137124,"cp":-2.2845953002610964,"mk":54488157896000},{"n":"Bitcoin Gold","id":3,"cd":"BTG","c":155900,"tt":1,"h":161800,"l":155000,"o":159000,"v":453845868,"cp":-1.949685534591195,"mk":2695136417840},{"n":"Basic Attention Token","id":17,"cd":"BAT","c":2548,"tt":1,"h":2683,"l":2532,"o":2677,"v":193330694,"cp":-4.818827045199851,"mk":3753905055280},{"n":"Dash","id":13,"cd":"DASH","c":1160000,"tt":1,"h":1184000,"l":1144000,"o":1184000,"v":114359714,"cp":-2.027027027027027,"mk":10849564978880},{"n":"EOS","id":21,"cd":"EOS","c":39490,"tt":1,"h":40070,"l":38760,"o":39680,"v":1177765727,"cp":-0.4788306451612903,"mk":36447866674800},{"n":"Ethereum","id":4,"cd":"ETH","c":2517000,"tt":1,"h":2581000,"l":2500000,"o":2559000,"v":9001063126,"cp":-1.6412661195779603,"mk":276467589286320},{"n":"ChainLink","id":18,"cd":"LINK","c":51450,"tt":1,"h":54570,"l":50240,"o":54440,"v":6563893031,"cp":-5.492285084496694,"mk":18764600459640},{"n":"Litecoin","id":5,"cd":"LTC","c":647500,"tt":1,"h":668700,"l":647300,"o":663700,"v":1061312822,"cp":-2.440861835166491,"mk":41472407691000},{"n":"Matic Network","id":23,"cd":"MATIC","c":191,"tt":1,"h":195,"l":189,"o":195,"v":96695924,"cp":-2.051282051282051,"mk":521736526600},{"n":"Maker","id":22,"cd":"MKR","c":4552000,"tt":1,"h":4797000,"l":4552000,"o":4781000,"v":1285334929,"cp":-4.789792930349299,"mk":3991910477640},{"n":"OmiseGo","id":7,"cd":"OMG","c":8700,"tt":1,"h":9060,"l":8700,"o":9060,"v":21993240,"cp":-3.9735099337748347,"mk":1207110958720},{"n":"Augur","id":19,"cd":"REP","c":156000,"tt":1,"h":160700,"l":155900,"o":158800,"v":125162093,"cp":-1.7632241813602016,"mk":1700332579200},{"n":"Tron","id":24,"cd":"TRX","c":199,"tt":0,"h":202,"l":197,"o":201,"v":430755650,"cp":-0.9950248756218906,"mk":13078203466000},{"n":"USD Coin","id":14,"cd":"USDC","c":15935,"tt":1,"h":16105,"l":15890,"o":15935,"v":1199326542,"cp":0,"mk":11667968219520},{"n":"Tether ERC20","id":20,"cd":"USDT","c":16015,"tt":0,"h":16115,"l":15955,"o":16060,"v":4686840925,"cp":-0.28019925280199254,"mk":100649444437120},{"n":"Stellar","id":15,"cd":"XLM","c":759,"tt":1,"h":778,"l":755,"o":773,"v":243981559,"cp":-1.8111254851228977,"mk":15409981393880},{"n":"XRP","id":6,"cd":"XRP","c":2945,"tt":1,"h":3028,"l":2934,"o":2971,"v":495623870,"cp":-0.8751262201279031,"mk":129541749952520},{"n":"Zcash","id":11,"cd":"ZEC","c":576000,"tt":1,"h":582000,"l":564000,"o":575000,"v":126911425,"cp":0.17391304347826086,"mk":5093943158760},{"n":"0x","id":12,"cd":"ZRX","c":2712,"tt":1,"h":2765,"l":2650,"o":2765,"v":174973842,"cp":-1.9168173598553346,"mk":1728829683840},{"n":"ANA Coin","id":9,"cd":"ANA","c":919,"tt":1,"h":936,"l":919,"o":936,"v":220455855,"cp":-1.8162393162393164,"mk":183800000000},{"n":"BBX Coin","id":10,"cd":"BBX","c":8080,"tt":1,"h":8200,"l":8080,"o":8180,"v":8208466,"cp":-1.2224938875305624,"mk":169680000000}]';
List<PriceModel> prices = (json.decode(mockJson) as List)
    .map((item) => PriceModel.fromJson(item))
    .toList();

getColorChangePercentage(PriceModel price, BuildContext context) {
  if (price.changePercentage > 0) {
    return Colors.green;
  } else if (price.changePercentage == 0) {
    return Colors.grey;
  } else {
    return Colors.red;
  }
}

getChangePercentageTextFormat(PriceModel price) {
  if (price.changePercentage > 0) {
    return "+${price.changePercentage.toStringAsFixed(2)}%";
  } else if (price.changePercentage < 0) {
    return "${price.changePercentage.toStringAsFixed(2)}%";
  } else if (price.changePercentage == 0) {
    return "0%";
  }
}

class MarketItem extends StatelessWidget {
  final PriceModel price;
  MarketItem({this.price});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => {},
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(price.coinCode,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                height: 1)),
                        const Text(" / IDR", style: TextStyle(fontSize: 10))
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text("Vol ${price.volume.toString()}",
                        style: TextStyle(fontSize: 10))
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: AnimatedClosePriceWidget(
                  price: price,
                  context: context,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.right,
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: getColorChangePercentage(price, context)),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(getChangePercentageTextFormat(price),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class MarketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Markets"),
        ),
        body: BlocProvider(
          create: (_) => PriceBloc()..add(LoadPrices()),
          child: BlocBuilder<PriceBloc, PriceState>(
            builder: (ctx, state) {
              if (state is PricesLoaded) {
                return PriceList(prices: state.prices);
              }
              return Container();
            },
          ),
        ));
  }
}

class PriceList extends StatefulWidget {
  final List<PriceModel> prices;
  const PriceList({
    Key key,
    this.prices,
  }) : super(key: key);

  @override
  _PriceListState createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: (){
            setState((){});
          },
          child: Text("Force Render"),
        ),
    ListView.separated(
    itemCount: widget.prices.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          thickness: 1,
          color: Theme.of(context).dividerColor,
        );
      },
      itemBuilder: (context, index) {
        return MarketItem(price: widget.prices[index]);
      },
    ),
      ],
    );
  }
}
