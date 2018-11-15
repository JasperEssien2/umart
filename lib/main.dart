import 'package:flutter/material.dart';
import 'package:umart/auth.dart';
import 'package:umart/root_page.dart';


void main() {
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "UMart",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: new RootPage(auth:new Auth()),
    );
  }
}
