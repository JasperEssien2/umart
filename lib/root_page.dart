import 'package:flutter/material.dart';
import 'package:umart/auth.dart';
import 'package:umart/login_page.dart';
import 'package:umart/pages/HomePage.dart';

enum AuthStatus {
  signedIn,
  notSignedIn
}

class RootPage extends StatefulWidget {
  final BaseAuth auth;

  RootPage({this.auth});

  @override
  _RootPageState createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;
  String id;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.auth.getUserId().then((userId) {
      setState(() {
        _authStatus =
        userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        id = userId;
      });
    });
  }

  void _sigedIn() {
    setState(() {
      print("Sign in caleed oooh");
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_authStatus == AuthStatus.notSignedIn) {
      return
        new LogInPage(
          auth: widget.auth,
          signInCallBack: _sigedIn,
        );
    } else {
      return new Scaffold(
          body: new HomePage(
            5,
            auth: widget.auth,
            callBackSignOut: _signedOut,
          )

      );
    }
  }
}
