
import 'package:flutter/material.dart';

class CustomerShapeBuilder{

}


class TrianglePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
   Paint paint = Paint();
   paint.color = Colors.red;
   paint.strokeWidth = 12.0;
   paint.style = PaintingStyle.fill;
  }

  Path getTrianglePath(double x,double y){
    return Path()
        ..moveTo(0, y)
        ..lineTo(x/2, 0)
        ..lineTo(x, y)
        ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // return oldDelegate.s
    return true;
  }

}