import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  void pushWithReplacement({required BuildContext context}) =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => this));

  void pushWithWidget({required BuildContext context}) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => this));

  void pushWithRemoveUntil({required BuildContext context}) =>
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => this), (route) => false);

  SizedBox withSize({double width = 0.0, double height = 0.0}) {
    return SizedBox(height: height, width: width, child: this);
  }

  /// With custom width
  SizedBox withWidth(double width) => SizedBox(width: width, child: this);

  /// With custom height
  SizedBox withHeight(double height) => SizedBox(height: height, child: this);

  /// center widget
  Center center() => Center(
        child: this,
      );

  Align align({AlignmentGeometry alignment = Alignment.center}) => Align(
        alignment: alignment,
        child: this,
      );

  /// return padding top
  Padding paddingTop(double top) {
    return Padding(padding: EdgeInsets.only(top: top), child: this);
  }

  /// return padding left
  Padding paddingLeft(double left) {
    return Padding(padding: EdgeInsets.only(left: left), child: this);
  }

  /// return padding right
  Padding paddingRight(double right) {
    return Padding(padding: EdgeInsets.only(right: right), child: this);
  }

  /// return padding bottom
  Padding paddingBottom(double bottom) {
    return Padding(padding: EdgeInsets.only(bottom: bottom), child: this);
  }

  /// return padding all
  Padding paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  InkWell onTab(void Function()? fun) => InkWell(
        onTap: fun,
        child: this,
      );

  Expanded expanded() => Expanded(child: this);
  Flexible flexible()=> Flexible(child: this);

  /// return custom padding from each side
  Padding paddingOnly({
    double top = 0.0,
    double left = 0.0,
    double bottom = 0.0,
    double right = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }

  /// return padding symmetric
  Padding paddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      child: this,
    );
  }
}
