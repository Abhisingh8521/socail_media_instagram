import 'package:flutter/material.dart';

extension DoubleExtensions on double{

  /// sizes
  Widget get height => SizedBox(height: this);
  Widget get width => SizedBox(width: this,);
  Size get size => Size(this, this);
  double getHeight({required BuildContext context}) => (MediaQuery.sizeOf(context).height)/this;
  double getWidth({required BuildContext context}) => (MediaQuery.sizeOf(context).width)/this;

  BorderRadius get circularRadius => BorderRadius.circular(this);
 DateTime get toDateTime =>DateTime.fromMillisecondsSinceEpoch(toInt()*1000);

}