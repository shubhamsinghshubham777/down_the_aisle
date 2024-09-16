import 'package:flutter/material.dart';

class HalfOnionDomeClipper extends CustomClipper<Path> {
  const HalfOnionDomeClipper();

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.height - 110)
      ..lineTo(size.width * 0.1037736, size.height - 100)
      ..cubicTo(
        size.width * 0.09622640,
        size.height - 76,
        size.width * 0.1713837,
        size.height - 76,
        size.width * 0.2099056,
        size.height - 76,
      )
      ..cubicTo(
        size.width * 0.2020440,
        size.height - 76,
        size.width * 0.2155659,
        size.height - 40,
        size.width * 0.3325467,
        size.height - 32,
      )
      ..cubicTo(
        size.width * 0.4495280,
        size.height - 30,
        size.width * 0.4913520,
        size.height - 10,
        size.width * 0.4976427,
        size.height,
      )
      ..cubicTo(
        size.width * 0.5015733,
        size.height - 10,
        size.width * 0.5396213,
        size.height - 32,
        size.width * 0.6603787,
        size.height - 36,
      )
      ..cubicTo(
        size.width * 0.7811333,
        size.height - 40,
        size.width * 0.7940240,
        size.height - 76,
        size.width * 0.7853787,
        size.height - 76,
      )
      ..cubicTo(
        size.width * 0.8778293,
        size.height - 76,
        size.width * 0.8993707,
        size.height - 82,
        size.width * 0.8985840,
        size.height - 100,
      )
      ..lineTo(size.width, size.height - 108)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
