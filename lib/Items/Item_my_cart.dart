import 'package:flutter/material.dart';

class MyCartItem extends StatefulWidget {
  final MyCart myCart;
  final IconData iconData;
  final ItemCountCallback callBack;

  MyCartItem(this.myCart, this.iconData, {this.callBack});

  @override
  State createState() {
    return new MyCartItemState(myCart, iconData);
  }
}

class MyCartItemState extends State<MyCartItem> {
  Text itemCountTextWidget = new Text("");
  TextStyle itemCountTextStyle = new TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
    color: Colors.grey[800],
  );

  MyCart myCart;
  IconData iconData;

  //MyCartPageState myCartPageState;

  MyCartItemState(this.myCart, this.iconData) {
    itemCount = myCart.itemCount;
    itemCountTextWidget = new Text(
      myCart.itemCount.toString(),
      style: itemCountTextStyle,
    );
  }

  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 5.0,
      color: Colors.white,
      margin: EdgeInsets.only(top: 4.0, right: 4.0, bottom: 4.0),
      child: _cartItem(myCart.imageUrl, myCart.itemName, iconData,
          myCart.amount.toString(), myCart.itemCount),
    );
  }

  Widget _cartItem(String imageUrl, String itemName, IconData icon,
      String amount, int itemCount) {
    return new Container(
//      color: Colors.,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            //padding: EdgeInsets.all(8.0),
            height: 100.0,
            width: 110.0,
            decoration: new BoxDecoration(
                image: DecorationImage(
                    image: new NetworkImage(imageUrl), fit: BoxFit.cover)),
          ),
          new Expanded(
              child: new Container(
                  margin: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: new Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _titleWidget(itemName, icon),
                      _amountWidget(myCart.amount.toString(), myCart.itemCount)
                    ],
                  )))
        ],
      ),
    );
  }

  Widget _titleWidget(String itemName, IconData icon) {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(
          itemName,
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Colors.deepPurpleAccent),
        ),
      ],
    );
  }

  Widget _amountWidget(String amount, int itemCount) {
    return new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(
          "₦" + amount,
          style: new TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20.0,
              fontStyle: FontStyle.italic),
        ),
        _incrementWidget(itemCount)
      ],
    );
  }

  //For incrementing items needed in cart
  Widget _incrementWidget(int itemCount) {
    return new Column(
      children: <Widget>[
        //new Icon(icon),
        new Row(
          children: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.remove_circle_outline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              onPressed: _onDecrementButtonPressed,
              disabledColor: Colors.grey[600],
              splashColor: Colors.deepPurpleAccent,
            ),
            new Container(
              margin: EdgeInsets.all(8.0),
              child: itemCountTextWidget,
            ),
            new IconButton(
              icon: new Icon(
                Icons.add_circle_outline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              onPressed: _onIncrementButtonPressed,
              disabledColor: Colors.grey,
              splashColor: Colors.deepPurpleAccent,
            ),
            //new Icon(Icons.add_circle_outline)
          ],
        )
      ],
    );
  }

  //Called when increment button is called
  _onIncrementButtonPressed() {
    setState(() {
      //TODO Remember to check the number of items available and compare with the incremented val
      itemCount = itemCount + 1;
      itemCountTextWidget = new Text(
        itemCount.toString(),
        style: itemCountTextStyle,
      );
      MyCart formerCartVal = myCart;
      myCart = new MyCart(myCart.imageUrl, myCart.itemName, myCart.amount,
          itemCount, myCart.itemId);
      widget.callBack(formerCartVal, myCart);
    });
  }

  //Called when decrement button is clicked
  _onDecrementButtonPressed() {
    setState(() {
      if (!(itemCount <= 1)) {
        itemCount--;
        itemCountTextWidget = new Text(
          itemCount.toString(),
          style: itemCountTextStyle,
        );
        MyCart formerCartVal = myCart;
        myCart = new MyCart(myCart.imageUrl, myCart.itemName, myCart.amount,
            itemCount, myCart.itemId);
        widget.callBack(formerCartVal, myCart);
      }
    });
  }
}

//class SelectedItem
typedef ItemCountCallback = void Function(
    MyCart formerCartVal, MyCart myCartVal);

class MyCart {
  var imageUrl;
  String itemName;
  int amount;
  int itemCount;
  String itemId;

  MyCart(
      this.imageUrl, this.itemName, this.amount, this.itemCount, this.itemId);
}
