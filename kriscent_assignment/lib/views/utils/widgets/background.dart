import 'package:kriscent_assignment/views/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class AppBackGrounds {
  BuildContext context;

  AppBackGrounds({required this.context});

  Widget authBackGround({required Widget child}) => Stack(
    children: [
      Container(
        color: bgColor,
        child: child,
      ),
      Positioned(
        right: -80,
          top: -80,
          child: _circleView(150)),
      Positioned(
        top: context.fullHeight/4,
          left: 20,
          child: _circleView(30)),
    ],
  );

  _circleView(double radius) => CircleAvatar(
    radius: radius,
        backgroundColor: Colors.white.withOpacity(.3),
      );
}
