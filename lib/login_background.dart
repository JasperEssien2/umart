import 'package:flutter/material.dart';

//This method returns a BoxDecoration type that sets its gradient
// and its used as the homePage background
BoxDecoration boxDecoration() {
  return new BoxDecoration(
      gradient: new LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
        0.1,
        0.5,
        0.7,
        0.9,
        1.0
      ],
          colors: [
        Colors.deepPurple,
        Colors.deepPurple,
        Colors.deepPurple,
        Colors.deepPurple,
        Colors.deepPurple,
      ]));
}
