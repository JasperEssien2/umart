import 'package:flutter/material.dart';

class CountIndicator extends StatelessWidget {
  final int cartCount;

  CountIndicator(this.cartCount);

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      //margin: EdgeInsets.only(right: 8.0, bottom: 8.0, top: 8.0),
      width: 13.0,
      height: 13.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: new Text(cartCount.toString(),
          textAlign: TextAlign.center,
          style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12.0)),
    );
  }
}

//class CountIndicator extends StatefulWidget {
//  final int cartCount;
//  _CountIndicatorState _countIndicatorState;
//  CountIndicator(this.cartCount){
//    _countIndicatorState = _CountIndicatorState(cartCount);
//  }
//
//  @override
//  _CountIndicatorState createState() => _countIndicatorState;
//
//  setCartCountState(int newCartCount){
//    _countIndicatorState.setCartCountState(newCartCount);
//  }
//}
//
//class _CountIndicatorState extends State<CountIndicator> {
//   int cartCount;
//   Text cartCountWidget;
//
//  _CountIndicatorState(this.cartCount){
//    cartCountWidget = new Text(cartCount.toString());
//  }
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//      width: 20.0,
//      height: 20.0,
//      decoration: new BoxDecoration(
//        shape: BoxShape.circle,
//        color: Colors.white,
//      ),
//      child: new Text(cartCount.toString(), textAlign: TextAlign.center, style:
//      new TextStyle(color: Colors.black, fontWeight: FontWeight.bold, ), ),
//    );
//  }
//
//  //This method is used to set the state of the count indicator when an item is
//   //added to cart it increments
//  setCartCountState(int newCartCount){
//    setState(() {
//      cartCount = newCartCount;
//      //cartCountWidget
//    });
//  }
//}
