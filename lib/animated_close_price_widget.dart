import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterblocrandomupdate/price_model.dart';

class AnimatedClosePriceWidget extends StatefulWidget {
  final PriceModel price;
  double fontSize = 13;
  BuildContext context;
  TextAlign textAlign = TextAlign.right;
  Color defaultTextColor;
  FontWeight fontWeight = FontWeight.w500;
  AnimatedClosePriceWidget(
      {Key key,
      @required this.price,
      @required this.context,
      this.fontSize,
      this.fontWeight,
      this.textAlign})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => AnimatedClosePriceWidgetState();
}

class AnimatedClosePriceWidgetState extends State<AnimatedClosePriceWidget> {
  bool isUpdated = false;
  Color colorUpdated;

  @override
  void didUpdateWidget(AnimatedClosePriceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.price.volume != widget.price.volume) {
      if (widget.price.transType == 0 || widget.price.transType == 20) {
        if(mounted){
          setState(() {
            isUpdated = true;
            colorUpdated = Colors.green;
          });
        }
      } else {
        if(mounted){
          setState(() {
            isUpdated = true;
            colorUpdated = Colors.red;
          });
        }
      }

      if (isUpdated) {
        Future.delayed(Duration(milliseconds: 500), () {
          if(mounted){
            setState(() {
              isUpdated = false;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.price.closePrice.toString(),
        textAlign: widget.textAlign,
        style: TextStyle(
            fontSize: widget.fontSize,
            fontFamily: "DINNextLTPro",
            fontWeight: widget.fontWeight,
            color: isUpdated
                ? colorUpdated
                : Theme.of(context).textTheme.title.color));
  }
}
