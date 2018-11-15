import 'package:flutter/material.dart';
import 'package:umart/auth.dart';

class HomePage extends StatefulWidget {

  //TODO: Hey! start implementing your Home Features Here!

  BaseAuth auth;
  VoidCallback callBackSignOut;

  HomePage({this.auth, this.callBackSignOut});

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String id;

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

  void openScanScreen(){
    //Navigator.push(context, MaterialPageRoute(builder: (context) => LiveShopping()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("UMart"),),
      body: new Container(
        child: new Center(
            child: new Column(
              children: <Widget>[
                new Text("Welcome $id"),
                new RaisedButton(onPressed: openScanScreen,child: new Text("live shopping"),),
                new RaisedButton(onPressed: logOut, child: new Text("Log Out"),)
              ],
            )
        ),

      ),

    );
  }
}
