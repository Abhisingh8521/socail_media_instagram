import 'package:flutter/cupertino.dart';

const fontSize = 35.0;
const iconSize = 45.0;
const normaIconSize = 30.0;
const textSize = 25;
const textBoldFont = 25.0;

class Sizes {
  BuildContext context;

  Sizes({required this.context});

  double get getHeight => MediaQuery.sizeOf(context).height;

  double get getWidth => MediaQuery.sizeOf(context).height;
}