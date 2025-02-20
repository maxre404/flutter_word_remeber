import 'package:flutter/material.dart';


extension NavigationExtensions on BuildContext {
  Future<dynamic> navigateTo(Widget page, {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacement(
        this,
        MaterialPageRoute(builder: (context) => page),
      );
    } else {
      return Navigator.push(
        this,
        MaterialPageRoute(builder: (context) => page),
      );
    }
  }

  void navigateBack() {
    Navigator.pop(this);
  }
}
