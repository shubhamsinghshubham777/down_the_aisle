import 'package:flutter/material.dart';

class OnionDomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width, size.height * 0.8304)
      ..lineTo(size.width, size.height * 0.1572)
      ..lineTo(size.width * 0.8915, size.height * 0.1572)
      ..cubicTo(
        size.width * 0.9028,
        size.height * 0.1235,
        size.width * 0.8207,
        size.height * 0.1192,
        size.width * 0.7783,
        size.height * 0.1212,
      )
      ..cubicTo(
        size.width * 0.7807,
        size.height * 0.1100,
        size.width * 0.7571,
        size.height * 0.0658,
        size.width * 0.6391,
        size.height * 0.0555,
      )
      ..cubicTo(
        size.width * 0.5448,
        size.height * 0.0473,
        size.width * 0.5055,
        size.height * 0.0151,
        size.width * 0.4976,
        size.height * 0,
      )
      ..cubicTo(
        size.width * 0.4882,
        size.height * 0.0151,
        size.width * 0.4439,
        size.height * 0.0473,
        size.width * 0.3420,
        size.height * 0.0555,
      )
      ..cubicTo(
        size.width * 0.2401,
        size.height * 0.0637,
        size.width * 0.2162,
        size.height * 0.1028,
        size.width * 0.2170,
        size.height * 0.1212,
      )
      ..cubicTo(
        size.width * 0.1015,
        size.height * 0.1100,
        size.width * 0.1015,
        size.height * 0.1522,
        size.width * 0.1038,
        size.height * 0.1531,
      )
      ..cubicTo(
        size.width * 0.1057,
        size.height * 0.1540,
        size.width * 0.0354,
        size.height * 0.1562,
        size.width * 0,
        size.height * 0.1572,
      )
      ..lineTo(size.width * 0, size.height * 0.8294)
      ..lineTo(size.width * 0.1038, size.height * 0.8366)
      ..cubicTo(
        size.width * 0.0962,
        size.height * 0.8736,
        size.width * 0.1714,
        size.height * 0.8746,
        size.width * 0.2099,
        size.height * 0.8705,
      )
      ..cubicTo(
        size.width * 0.2021,
        size.height * 0.8897,
        size.width * 0.2156,
        size.height * 0.9309,
        size.width * 0.3325,
        size.height * 0.9424,
      )
      ..cubicTo(
        size.width * 0.4495,
        size.height * 0.9539,
        size.width * 0.4914,
        size.height * 0.9856,
        size.width * 0.4976,
        size.height * 1,
      )
      ..cubicTo(
        size.width * 0.5016,
        size.height * 0.9867,
        size.width * 0.5396,
        size.height * 0.9564,
        size.width * 0.6604,
        size.height * 0.9424,
      )
      ..cubicTo(
        size.width * 0.7811,
        size.height * 0.9285,
        size.width * 0.7940,
        size.height * 0.8887,
        size.width * 0.7854,
        size.height * 0.8705,
      )
      ..cubicTo(
        size.width * 0.8778,
        size.height * 0.8828,
        size.width * 0.8994,
        size.height * 0.8531,
        size.width * 0.8986,
        size.height * 0.8366,
      )
      ..lineTo(size.width, size.height * 0.8304)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
