import 'package:flutter/material.dart';
import 'package:umart/custom_fab.dart';

class LiveShopping extends StatefulWidget {
  @override
  State createState() {
    return new LiveShoppingState();
  }
}

class LiveShoppingState extends State<LiveShopping> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: CustomFab(),
    );
  }
}
