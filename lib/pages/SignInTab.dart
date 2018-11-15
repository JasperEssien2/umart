import 'package:flutter/material.dart';

class SignInTab extends StatefulWidget {
  @override
  State createState() {
    return new SignInTabState();
  }
}

class SignInTabState extends State<SignInTab> {
  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Container(
//      color: Colors.grey,
        alignment: Alignment.center,
        child: new Card(
          color: Colors.white70,
          margin: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadiusDirectional.all(new Radius.circular(8.0))),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                  //color: Colors.grey,
                  child: textForm("Email Address", "", true),
                  margin: EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0, top: 32.0)),
              new Container(
                  //color: Colors.grey,
                  child: textForm("Password", "", false),
                  margin:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0)),
//              new Row(
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  new Align(
//                    alignment: Alignment.centerLeft,
//                    child: loginPageButton("Sign Up"),
//                  ),
//                  new Row(
//                    children: <Widget>[
//                      new Align(
//                          alignment: Alignment.center,
//                          child: new Icon(Icons.local_drink, color: Colors.blue,size: 30.0,)
//                      ),
//                      new Align(
//                          alignment: Alignment.center,
//                          child: new Icon(Icons.local_drink, color: Colors.orange, size: 30.0)
//                      ),
//                    ],
//                  ),
//
//                  new Align(
//                    alignment: Alignment.centerRight,
//                    child: loginPageButton("Sign In"),
//                  )
//                ],
//              ),
              new Align(
                alignment: Alignment.topCenter,
                child: loginPageButton("Login"),
              )
            ],
          ),
          //),
        ),
      ),
    );
  }

  TextFormField textForm(String hint, String errorText, bool typeEmail) {
    TextInputType textInputType = null;
    bool obscure;
    var icon;
    if (typeEmail) {
      textInputType = TextInputType.emailAddress;
      obscure = false;
      icon = new Icon(Icons.email);
    } else {
      textInputType = TextInputType.text;
      obscure = true;
      icon = new Icon(Icons.lock);
    }
    return new TextFormField(
      decoration: new InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[300],
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(15.0)),
          suffixIcon: icon
          //errorText: errorText,
          ),
      keyboardType: textInputType,
      obscureText: obscure,
      style: new TextStyle(color: Colors.black87, fontSize: 15.0),
    );
  }

  //TODO: Remember to validate the edittext before signin up
  void onLoginButtonPressed() {
    setState(() {
      Navigator.of(context).pushNamed('/HomePage');
    });
  }

  //This method creates and returns a container contaning a button
  Container loginPageButton(String buttonText) {
    return new Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
      child: new RaisedButton(
        onPressed: onLoginButtonPressed,
        color: Colors.grey[300],
        shape: new RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        child: new Text(buttonText),
      ),
    );
  }
}
