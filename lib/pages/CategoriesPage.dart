import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:umart/Items/items_category.dart' as categoryItemWidget;
import 'package:umart/Utility/GetData.dart';

import '../pages/HomePage.dart';

class CategoriesPage extends StatefulWidget {
  //final CategoryPageCallback categoryPageCallback;
  final String categoryType;
  final HomePageState homePageState;

  CategoriesPage({this.categoryType, this.homePageState});

  @override
  State createState() {
    return new CategoriesPageState();
  }
}

class CategoriesPageState extends State<CategoriesPage> {
  CategoriesPageState() {}

  List<categoryItemWidget.Items> itemsList = List();
  var isLoading = false;

  @override
  void initState() {
    _fetchData(widget.categoryType, searchText: "");
    widget.homePageState
        .initSearchCallback((String searchText, String categoryType) {
      _fetchData(categoryType, searchText: searchText);
    });
    widget.homePageState.initCategoryTypeCallBack((String categoryType) {
      _fetchData(categoryType, searchText: "");
    });
  }

  //This method is called to get the data from the api
  void _fetchData(String categoryType, {String searchText}) async {
    setState(() {
      _setIsLoadingTrue();
    });

    var response = await GetData.getData(searchText);
    if (response.statusCode == 200) {
      itemsList = (json.decode(response.body) as List)
          .map((data) => new categoryItemWidget.Items.fromJson(data))
          .toList();
      _setIsLoadingFalse();
    } else {
      _setIsLoadingFalse();
    }
    print(response.body);
  }

  //calls set state and sets the variable isLoading to true
  _setIsLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  //calls set state and sets the variable isLoading to false
  _setIsLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<categoryItemWidget.CategoryItem> categoryList = List();

    //print(itemsList[0].itemName + " CategoriesPage build method meeeeeeeeehn");
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                itemCount: itemsList.length,
                //gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                gridDelegate:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2)
                        : new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return new categoryItemWidget.CategoryItem(itemsList[index]);
                  //TODO: chek if itemList[index].categoryTpe equal to the categoryType field
                  //TODo: If yes then return an item a new item_category widget if no skip
                })
        //),
        );
  }

  _getOrientation() {}
}
