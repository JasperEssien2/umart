import 'package:flutter/material.dart';
import 'package:umart/Items/item_cart_count_indicator.dart';
import 'package:umart/auth.dart';
import 'package:umart/login_background.dart';
import 'package:umart/pages/live_shopping_scan_page.dart';

import 'CategoriesPage.dart' as categories;
import 'MyCartPage.dart' as myCart;

class HomePage extends StatefulWidget {
  int cartCount;
  BaseAuth auth;
  VoidCallback callBackSignOut;

  HomePage(this.cartCount, {this.auth, this.callBackSignOut});

  @override
  State createState() {
    return new HomePageState(cartCount);
  }
}

class HomePageState extends State<HomePage> {
  String id;

  int _selectedDrawerIndex = 0;
  Text appBarTitle = new Text("Home");
  CountIndicator countIndicator;
  int cartCount;
  final TextEditingController _searchQuery = new TextEditingController();
  String searchText = "";
  String categoryType; //This field is used to determine the type of category

  SearchCallback searchCallback;
  CategoryTypeCallback categoryTypeCallBack;

  List<Widget> navDrawerItem = new List<Widget>();

  HomePageState(this.cartCount) {
    countIndicator = new CountIndicator(cartCount);
    _setUpSearchQuery();
  }

  @override
  void initState() {
    super.initState();

    widget.auth.getUserId().then((onValue) {
      setState(() {
        id = onValue;
      });
    });
  }

  void logOut() async {
    widget.auth.logUserOut();
    widget.callBackSignOut();
  }

  @override
  Widget build(BuildContext context) {
//    return new MaterialApp(
//        debugShowCheckedModeBanner: false,
    navDrawerItem.clear();
    _getDrawer();
    return new Scaffold(
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: navDrawerItem, //updates the drawer items
        ),
      ),
      appBar: new AppBar(
        backgroundColor: Colors.deepPurple,
        title: appBarTitle,
        bottom: _getSearchBar(),
        actions: <Widget>[
          //_cartIcon(),
          new IconButton(
            padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
            icon: _cartIcon(),
            onPressed: () {
              new Future(_onCartButtonPressed(2));
            },
          ),
//          countIndicator
        ],
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }

  //Returns the widget according to the selected drawer item
  initCategoryTypeCallBack(CategoryTypeCallback categoryTypeCallback) {
    this.categoryTypeCallBack = categoryTypeCallback;
  }

  initSearchCallback(SearchCallback searchCallback) {
    this.searchCallback = searchCallback;
  }

  Widget _cartIcon() {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        countIndicator,
        new Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ],
    );
  }

  //Sets the state of the app, updates the index and closes the drawer
  DrawerHeader _drawerHeader(String userEmailAddress) {
    return new DrawerHeader(
      margin: const EdgeInsets.all(0.0),
      child: new Column(
        children: <Widget>[
          new Container(
              alignment: Alignment.topCenter,
              width: 60.0,
              height: 60.0,
              margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2.0, color: Colors.grey),
                  color: Colors.blue,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          "https://i.imgur.com/BoN9kdC.png")))),
          new Text(
            userEmailAddress,
            style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )
        ],
      ),
    );
  }

  //This is used to change the appBar header according to the current page
  Drawer _getDrawer() {
    navDrawerItem.add(Container(
      //color: Colors.deepPurple,
      decoration: boxDecoration(),
      child: DrawerHeader(
        child: _drawerHeader("JasperEssien2@gmail.com"),
      ),
    ));
    navDrawerItem.add(ListTile(
      leading: new Icon(Icons.home),
      title: new Text("Home"),
      onTap: () {
        _onSelectedItem(0);
      },
    ));
    navDrawerItem.add(ListTile(
      leading: new Icon(Icons.shopping_cart),
      title: new Text("My Cart"),
      onTap: () {
        _onSelectedItem(2);
        //Navigator.of(context).pop();
      },
    ));

    navDrawerItem.add(new ExpansionTile(
      leading: new Icon(Icons.shop),
      title: new Text("Shop"),
      initiallyExpanded: true,
      children: _getListTilesShopping(),
    ));

    navDrawerItem.add(new ExpansionTile(
      leading: new Icon(Icons.list),
      title: new Text("Categories"),
      initiallyExpanded: true,
      children: _getListTilesCategory(
          <String>["Food and Drinks", "Office Supplies", "Cooking utensils"]),
    ));

    navDrawerItem.add(ListTile(
      leading: new Icon(Icons.power_settings_new),
      title: new Text("Log Out"),
      onTap: () {
        logOut();
      },
    ));
    return new Drawer(
      child: ListView(
        //shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: navDrawerItem, //updates the drawer items
      ),
    );
  }

  //This method sets up the search query widget
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new categories.CategoriesPage(
          homePageState: this,
          categoryType: categoryType,
        );
      case 1:
        return new categories.CategoriesPage(
          homePageState: this,
          categoryType: categoryType,
        );
      case 2:
        return new myCart.MyCartPage();
      case 3:
        return new LiveShopping();
      default:
        return new Text("Error");
    }
  }

  //This method returns a drawer header to be used in the nav bar
  List<ListTile> _getListTilesCategory(List<String> categoryNames) {
    List<ListTile> list = new List<ListTile>();
    for (int i = 0; i < categoryNames.length; i++) {
      list.add(new ListTile(
        title: new Text(categoryNames.elementAt(i)),
        onTap: () {
          new Future(_onSelectedItem(1, categoriesType: categoryNames[i]));
        },
      ));
    }
    return list;
  }

  //This method returns a navigation drawer for the home page
  List<ListTile> _getListTilesShopping() {
    List<ListTile> list = <ListTile>[
      new ListTile(
        title: new Text("Live Shopping"),
        onTap: () {
          //new Future(_onSelectedItem(3);
          _onSelectedItem(3);
        },
      ),
      new ListTile(
        title: new Text("Online Shopping"),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    ];
    return list;
  }

  //Returns the drawer nav widget
  PreferredSizeWidget _getSearchBar() {
    return new PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: new Container(
          color: Colors.deepPurple,
          height: 65.0,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          padding: EdgeInsets.all(0.0),
          child: new TextFormField(
            //onFieldSubmitted: _onSearchQueried(),
            controller: _searchQuery,
            decoration: new InputDecoration(
                hintText: "Search",
                filled: true,
                fillColor: Colors.white,
//                border: new OutlineInputBorder(
//                    borderRadius: new BorderRadius.circular(10.0)),
                prefixIcon: new IconButton(
                  icon: new Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    _onSearchQueried();
                  },
                )
                //errorText: errorText,
                ),
            keyboardType: TextInputType.text,
            style: new TextStyle(color: Colors.black87, fontSize: 15.0),
          ),
        ));
  }

  Widget _homepageBody() {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(8.0),
      children: <Widget>[],
    );
  }

  ListView _itemsCategory(List<ListTile> listTiles) {
    return new ListView(
      children: listTiles,
    );
  }

  //Takes a list of category names returns a list of ListTile to be inserted in the
  //categories section of the drawer nav
  Widget _listTileRowTitle(IconData icon, String text) {
    return Row(
      children: <Widget>[new Icon(icon), new Text(text)],
    );
  }

  //Returns a widget for the searchBar
  _onCartButtonPressed(int index) {
    setState(() {
      _selectedDrawerIndex = index;
      switch (index) {
        case 0:
          appBarTitle = new Text("Home");
          break;
        case 1:
          appBarTitle = new Text("Categories");
          break;
        case 2:
          appBarTitle = new Text("My Cart");
          break;
      }
    });
  }

  //WWhen this method is called it calls a callBack method to perform the required
  //action
  _onSearchQueried() {
    searchCallback(searchText, categoryType);
  }

  _onSelectedItem(int index, {var categoriesType}) {
    setState(() {
      _selectedDrawerIndex = index;
      switch (index) {
        case 0:
          appBarTitle = new Text("Home");
          break;
        case 1:
          this.categoryType = categoriesType;
          if (categoryTypeCallBack != null) {
            categoryTypeCallBack(categoryType);
          }
          appBarTitle = new Text(categoryType);
          break;
        case 2:
          appBarTitle = new Text("My Cart");
          break;
        case 3:
          appBarTitle = new Text("Live Shopping");
          break;
      }
    });
    Navigator.of(context).pop(); // close the drawer
  }

  _setUpSearchQuery() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          //TODO: Show toast with message "Search cant be empty"
        });
      } else {
        setState(() {
          searchText = _searchQuery.text;
          _onSearchQueried();
        });
      }
    });
  }
}

//This is used for search callbacks
typedef SearchCallback = void Function(String searchText, String categoryType);

typedef CategoryTypeCallback = void Function(String categoryType);

class Items {
  String itemName;

  var imageUrl;

  var priceTag;

  Items(this.imageUrl, this.priceTag, this.itemName);
}
