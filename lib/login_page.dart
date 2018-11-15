import 'package:flutter/material.dart';
import 'package:umart/auth.dart';

class LogInPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback signInCallBack;

  LogInPage({this.auth, this.signInCallBack});

  @override
  _LogInPageState createState() => new _LogInPageState();
}

enum FormType { login, register }

class _LogInPageState extends State<LogInPage> {
  String _email;
  String _password;

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  FormType _formType = FormType.login;

  bool validateInput() {
    final form = formKey.currentState;
//
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
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

  void authenticateUser() async {
    _setIsLoadingTrue();
    if (validateInput()) {
      //authenticate with firebase
      try {
        String userId;
        if (_formType == FormType.login) {
          userId =
          await widget.auth.signInwithEmailAndPassword(_email, _password);
        } else {
          userId = await widget.auth
              .createUserwithEmailAndPassword(_email, _password);
        }

        widget.signInCallBack();

        print("fb $userId");
      } catch (e) {
        print("fb $e");
      }
    } else
      _setIsLoadingFalse();
  }

  void goToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void goToLogIn() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("UMart"),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildTextInput() + buildSubmitButtons() +
                  _progressbar(),
            )),
      ),
    );
  }

  List<Widget> buildTextInput() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: "Email"),
        validator: (value) => value.isEmpty ? "Email cannot be empty" : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: "Password"),
        obscureText: true,
        validator: (value) => value.isEmpty ? "Password cannot be empty" : null,
        onSaved: (value) => _password = value,
      )
    ];
  }

  List<Widget> _progressbar() {
    return [ isLoading
        ? new Center(
      child: new CircularProgressIndicator(),
    )
        : new Container()
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          onPressed: authenticateUser,
          child: new Text("Log In"),
        ),
        new FlatButton(
            onPressed: goToRegister, child: new Text("Create an Account"))
      ];
    } else {
      return [
        new RaisedButton(
          onPressed: authenticateUser,
          child: new Text("Register Now"),
        ),
        new FlatButton(
            onPressed: goToLogIn,
            child: new Text("Already Registered, Log in now"))
      ];
    }
  }
}
