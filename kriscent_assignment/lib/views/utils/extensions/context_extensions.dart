import 'package:flutter/material.dart';

extension MediaQueryExtensions on BuildContext {
  double get fullHeight => MediaQuery.sizeOf(this).height;

  double get fullWidth => MediaQuery.sizeOf(this).width;

  get onBackPressed => Navigator.pop(this);

  gotoNext({required Widget page}) =>
      Navigator.push(this, MaterialPageRoute(builder: (_) => page));

  gotoNextNeverBack({required Widget page}) => Navigator.pushAndRemoveUntil(
      this, MaterialPageRoute(builder: (_) => page), (_) => false);

  showSnackBar(String message, Color? textColor) {
     ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor ?? Colors.black),
      ),
    ));
  }
}
