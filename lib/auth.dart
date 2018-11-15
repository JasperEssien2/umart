import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


abstract class BaseAuth {

  Future<String> signInwithEmailAndPassword(String email, String password);

  Future<String> createUserwithEmailAndPassword(String email, String password);

  Future<String> getUserId();
  Future<void> logUserOut();

}

class Auth implements BaseAuth {

  @override
  Future<String> createUserwithEmailAndPassword(String email,
      String password) async {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    return user.uid;
  }

  @override
  Future<String> signInwithEmailAndPassword(String email,
      String password) async {


    FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);

    return user.uid;
  }

  @override
  Future<String> getUserId() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  Future<void> logUserOut() async{
    return FirebaseAuth.instance.signOut();
  }

}