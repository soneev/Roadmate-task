import 'package:flutter/material.dart';

class CircularTopBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ))
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width,
          size.width / 2) // Adjust this value to control the size of the border
      ..arcTo(
        Rect.fromCircle(
          center: Offset(size.width / 2, 0),
          radius: size.width / 2,
        ),
        0,
        -3.14,
        false,
      )
      ..lineTo(0,
          size.width / 2) // Adjust this value to control the size of the border
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
