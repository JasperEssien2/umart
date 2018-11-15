import 'package:flutter/material.dart';
import 'package:umart/Items/item_cart_count_indicator.dart';
import 'package:umart/Items/items_category.dart';
import 'package:umart/pages/MyCartPage.dart';

class CategoryDetailsPage extends StatefulWidget {
  final Items item;
  final int cartItemCount;

  CategoryDetailsPage(this.item, this.cartItemCount);

  @override
  _CategoryDetailsPageState createState() =>
      _CategoryDetailsPageState(item, cartItemCount);
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  Items items;
  int cartItemCount;

  _CategoryDetailsPageState(this.items, this.cartItemCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: _getBar(),
        floatingActionButton: new FloatingActionButton(
          onPressed: _onAddToCartFabClicked,
          child: new Icon(Icons.add_shopping_cart),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        //TODO: Take care of orientation change
        body: MediaQuery.of(context).orientation == Orientation.portrait
            ? _getPortraitHomeLayout()
            : _getLanscapeHomeLayout());
  }

  Widget _getLanscapeHomeLayout() {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _getLandscapeBar(),
        //SingleChildScrollView(
        new Container(
            padding: EdgeInsets.all(16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  //color: Colors.grey,
                  child: _getTextWidget(items.itemName, 32.0, Colors.black,
                      FontWeight.bold, 1, null),
                ),
                _getTextWidget("₦" + items.priceTag.toString(), 28.0,
                    Colors.black45, FontWeight.bold, 1, null),
                new Column(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(top: 32.0),
                      alignment: Alignment.centerLeft,
                      child: _getTextWidget("Description", 20.0, Colors.black45,
                          FontWeight.bold, 1, null),
                    ),
                    _getTextLabelDivider()
                  ],
                ),
                _getTextWidget(items.itemDescrption, 18.0, Colors.black54,
                    FontWeight.bold, 0, FontStyle.italic)
              ],
            )),
        //  )
      ],
    );
  }

  Widget _getPortraitHomeLayout() {
    return SingleChildScrollView(
        child: new Column(
      children: <Widget>[
        _getPortraitBar(),
        new Container(
            padding: EdgeInsets.all(16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  //color: Colors.grey,
                  child: _getTextWidget(items.itemName, 32.0, Colors.black,
                      FontWeight.bold, 1, null),
                ),
                _getTextWidget("₦" + items.priceTag.toString(), 28.0,
                    Colors.black45, FontWeight.bold, 1, null),
                new Column(
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(top: 32.0),
                      alignment: Alignment.centerLeft,
                      child: _getTextWidget("Description", 20.0, Colors.black45,
                          FontWeight.bold, 1, null),
                    ),
                    _getTextLabelDivider()
                  ],
                ),
                _getTextWidget(items.itemDescrption, 18.0, Colors.black54,
                    FontWeight.bold, 0, FontStyle.italic)
              ],
            )),
      ],
    ));
  }

  Widget _cartIcon() {
    return new Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 7.0, right: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new CountIndicator(cartItemCount),
          new Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 24.0,
          ),
        ],
      ),
    );
  }

  _getTextLabelDivider() {
    return new Divider(
      color: Colors.black45,
      //height: 10.0,
    );
  }

  _getTextWidget(String text, double textSize, Color textColor,
      FontWeight fontWeight, int maxLines, FontStyle fontStyle) {
    if (maxLines == 0) maxLines = null;
    return new Text(
      text,
      softWrap: true,
      style: new TextStyle(
          color: textColor,
          fontSize: textSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle),
      maxLines: maxLines,
    );
  }

  PreferredSizeWidget _getLandscapeBar() {
    return new PreferredSize(
        preferredSize: const Size.fromWidth(260.0),
        child: new Container(
            width: 260.0,
            margin: EdgeInsets.only(top: 24.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: new NetworkImage(items.imageUrl), fit: BoxFit.cover),
                color: Colors.grey),
            child: new Container(
//        margin: EdgeInsets.only(top: 16.0),

              alignment: Alignment.topCenter,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //new AppBar(f)
                  new IconButton(
                      icon: new Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: _backButtonClicked),
                  GestureDetector(
                    onTap: _viewCarts,
                    child: _cartIcon(),
                  )
                ],
              ),
            )));
  }

  PreferredSizeWidget _getPortraitBar() {
    return new PreferredSize(
        preferredSize: const Size.fromHeight(260.0),
        child: new Container(
            height: 260.0,
            margin: EdgeInsets.only(top: 24.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: new NetworkImage(items.imageUrl), fit: BoxFit.cover),
                color: Colors.grey),
            child: new Container(
//        margin: EdgeInsets.only(top: 16.0),
              height: 50.0,
              alignment: Alignment.topCenter,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //new AppBar(f)
                  new IconButton(
                      icon: new Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: _backButtonClicked),
                  GestureDetector(
                    onTap: _viewCarts,
                    child: _cartIcon(),
                  )
                ],
              ),
            )));
  }

  _onAddToCartFabClicked() {
    setState(() {});
  }

  _backButtonClicked() {
    setState(() {
      Navigator.pop(context);
    });
  }

  _viewCarts() {
    setState(() {
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext) => MyCartPage()));
    });
  }
}
