class PriceModel{
  int id;
  String coinCode;
  String coinName;
  int transType;
  double lowPrice;
  double closePrice;
  double highPrice;
  double openPrice;
  double volume;
  double changePercentage;

  PriceModel({this.id, this.coinCode, this.coinName, this.transType, this.lowPrice, this.closePrice, this.highPrice, this.volume, this.changePercentage});

  PriceModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson["id"];
    coinCode = parsedJson['cd'];
    coinName = parsedJson['n'];
    closePrice = parsedJson['c'].toDouble();
    highPrice = parsedJson['h'].toDouble();
    lowPrice = parsedJson['l'].toDouble();
    openPrice = parsedJson['o'].toDouble();
    volume = parsedJson['v'].toDouble();
    changePercentage = (parsedJson['cp']).toDouble();
    transType = parsedJson['tt'];
  }

  PriceModel updateJson(Map<String, dynamic> parsedJson) {

    id = parsedJson["i"];
    coinCode = parsedJson['c'];
    coinName = parsedJson['n'];
    closePrice =parsedJson['cl'].toDouble();
    highPrice = parsedJson['h'].toDouble();
    lowPrice = parsedJson['l'].toDouble();
    openPrice = parsedJson['o'].toDouble();
    volume = parsedJson['v'].toDouble();
    changePercentage = (parsedJson['cp']).toDouble();
    transType = parsedJson['t'][0][1];
    return this;
  }

}
