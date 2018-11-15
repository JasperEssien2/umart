import 'package:flutter/material.dart';
import 'package:umart/Items/Item_my_cart.dart' as cartItemWidget;
import 'package:umart/Items/Item_my_cart.dart';

class MyCartPage extends StatefulWidget {
  @override
  State createState() {
    return new MyCartPageState();
  }
}

class MyCartPageState extends State<MyCartPage> {
  Widget bottomWidget;
  List<cartItemWidget.MyCartItem> cartList = new List<MyCartItem>();

  MyCartPageState() {
    _initList();
    text = new Text(
      "Pay #" + _totalItemsInCartPrice().toString(),
      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );
    _getMyCartItemsList();
  }

  //Dummy Data
  void _initList() {
    cartList = <cartItemWidget.MyCartItem>[
      new cartItemWidget.MyCartItem(
          new cartItemWidget.MyCart(
              "https://i.imgur.com/8XpQ6yP.jpg", "Cake", 500, 2, "7878"),
          Icons.cake,
          callBack: setCartTotalState),
      new cartItemWidget.MyCartItem(
          new cartItemWidget.MyCart(
              "https://i.imgur.com/2n54PEc.gif", "Biscuits", 500, 2, "7879"),
          Icons.cake,
          callBack: setCartTotalState),
      new cartItemWidget.MyCartItem(
          new cartItemWidget.MyCart(
              "https://i.imgur.com/nhoaRcZ.jpg", "Bread", 500, 2, "78710"),
          Icons.cake,
          callBack: setCartTotalState),
      new cartItemWidget.MyCartItem(
          new cartItemWidget.MyCart(
              "https://i.imgur.com/kNelaDd.jpg", "Meat Pie", 500, 2, "78711"),
          Icons.cake,
          callBack: setCartTotalState),
      new cartItemWidget.MyCartItem(
          new cartItemWidget.MyCart("https://i.imgur.com/T9b5dqz.jpg",
              "Sausage roll", 500, 2, "78712"),
          Icons.cake,
          callBack: setCartTotalState),
      new cartItemWidget.MyCartItem(
          new cartItemWidget.MyCart(
              "https://i.imgur.com/nhoaRcZ.jpg", "Pie", 500, 2, "787813"),
          Icons.cake,
          callBack: setCartTotalState),
      new cartItemWidget.MyCartItem(
          new cartItemWidget.MyCart(
              "https://i.imgur.com/4lkJAMf.jpg", "Roller", 500, 2, "787814"),
          Icons.cake,
          callBack: setCartTotalState),
      new cartItemWidget.MyCartItem(
          new cartItemWidget.MyCart("https://i.imgur.com/YSRrkrN.jpg",
              "Grilled Fish", 500, 2, "78715"),
          Icons.cake,
          callBack: setCartTotalState),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //_initList(this);
    text = new Text(
      "Pay #" + _totalItemsInCartPrice().toString(),
      style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(cartList[index].myCart.itemId),
            child: cartList[index],
            onDismissed: (direction) {
              setState(() {
                listOfMyCart.removeAt(index);
                cartList.removeAt(index);
              });
              _updateTotalWhenItemRemoved();
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("Undo")));
            },
          );
        },
      ),
      bottomNavigationBar: new BottomAppBar(child: _bottomWidget()),
    );
  }

  Text text;

  _bottomWidget() {
    return new Container(
      color: Colors.grey,
      height: 50.0,
      //decoration: new BoxDecoration(),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16.0),
            child: text,
          ),
          new Align(
              alignment: Alignment.centerRight, child: _button("CheckOut")),
        ],
      ),
    );
  }

  Container _button(String buttonText) {
    return new Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 8.0),
      alignment: Alignment.center,
      child: new RaisedButton(
        onPressed: _onCheckOutButtonClicked,
        color: Colors.grey[300],
        highlightColor: Colors.deepPurpleAccent,
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        child: new Text(buttonText),
      ),
    );
  }

  _getBottomSheetWidget() {
    return new Container();
  }

  _onCheckOutButtonClicked() {}

  //This calculates and returns a list of each item prices

  List<MyCart> listOfMyCart = new List<MyCart>();

  //This gets the list of all MyCart objects in the list of widget
  List<MyCart> _getMyCartItemsList() {
    for (int i = 0; i < cartList.length; i++) {
      listOfMyCart.add(cartList[i].myCart);
    }
    return listOfMyCart;
  }

  //This returns the total of each item in cart and inserts it in a list then returns it
  List<int> _getListOfPricesInCart() {
    List<int> priceList = new List<int>();
    for (int i = 0; i < listOfMyCart.length; i++) {
      priceList.add(
          _totalItemPrice(listOfMyCart[i].amount, listOfMyCart[i].itemCount));
    }
    return priceList;
  }

  //This returns the total price of all items
  int _totalItemPrice(int amount, int itemCount) {
    return (amount * itemCount);
  }

  int _totalItemsInCartPrice() {
    List<int> itemsPriceList = _getListOfPricesInCart();
    int total = 0;
    for (int i = 0; i < itemsPriceList.length; i++) {
      total += itemsPriceList[i];
    }

    return total;
  }

  void _updateTotalWhenItemRemoved() {
    setState(() {
      text = new Text("Pay #" + _totalItemsInCartPrice().toString(),
          style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold));
      print("Total when item removed " + _totalItemsInCartPrice().toString());
      print("Cart widget list " + cartList.toSet().toString());
      print("Cart Item list " + listOfMyCart.toSet().toString());
    });
  }

  //This method is called as a callback method when decrement or increment button is clicked
  //to update the total price of all the item widget
  void setCartTotalState(MyCart formerMyCartVal, MyCart myCartVal) {
    setState(() {
      listOfMyCart
          .firstWhere((item) => item.itemId == myCartVal.itemId)
          .itemCount = myCartVal.itemCount;
      print("List of mycart prices == " + _getListOfPricesInCart().toString());
      text = new Text(
        "Pay #" + _totalItemsInCartPrice().toString(),
        style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    });
  }
}
