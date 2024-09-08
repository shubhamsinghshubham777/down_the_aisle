import 'package:flutter/material.dart';

class GreetingBGShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Normalize the path to fit any size
    double w = size.width;
    double h = size.height;

    path.moveTo(w, h * 0.8304);
    path.lineTo(w, h * 0.1572);
    path.lineTo(w * 0.8915, h * 0.1572);
    path.cubicTo(
      w * 0.9028,
      h * 0.1235,
      w * 0.8207,
      h * 0.1192,
      w * 0.7783,
      h * 0.1212,
    );
    path.cubicTo(
      w * 0.7807,
      h * 0.1100,
      w * 0.7571,
      h * 0.0658,
      w * 0.6391,
      h * 0.0555,
    );
    path.cubicTo(
      w * 0.5448,
      h * 0.0473,
      w * 0.5055,
      h * 0.0151,
      w * 0.4976,
      h * 0,
    );
    path.cubicTo(
      w * 0.4882,
      h * 0.0151,
      w * 0.4439,
      h * 0.0473,
      w * 0.3420,
      h * 0.0555,
    );
    path.cubicTo(
      w * 0.2401,
      h * 0.0637,
      w * 0.2162,
      h * 0.1028,
      w * 0.2170,
      h * 0.1212,
    );
    path.cubicTo(
      w * 0.1015,
      h * 0.1100,
      w * 0.1015,
      h * 0.1522,
      w * 0.1038,
      h * 0.1531,
    );
    path.cubicTo(
      w * 0.1057,
      h * 0.1540,
      w * 0.0354,
      h * 0.1562,
      w * 0,
      h * 0.1572,
    );
    path.lineTo(
      w * 0,
      h * 0.8294,
    );
    path.lineTo(
      w * 0.1038,
      h * 0.8366,
    );
    path.cubicTo(
      w * 0.0962,
      h * 0.8736,
      w * 0.1714,
      h * 0.8746,
      w * 0.2099,
      h * 0.8705,
    );
    path.cubicTo(
      w * 0.2021,
      h * 0.8897,
      w * 0.2156,
      h * 0.9309,
      w * 0.3325,
      h * 0.9424,
    );
    path.cubicTo(
      w * 0.4495,
      h * 0.9539,
      w * 0.4914,
      h * 0.9856,
      w * 0.4976,
      h * 1,
    );
    path.cubicTo(
      w * 0.5016,
      h * 0.9867,
      w * 0.5396,
      h * 0.9564,
      w * 0.6604,
      h * 0.9424,
    );
    path.cubicTo(
      w * 0.7811,
      h * 0.9285,
      w * 0.7940,
      h * 0.8887,
      w * 0.7854,
      h * 0.8705,
    );
    path.cubicTo(
      w * 0.8778,
      h * 0.8828,
      w * 0.8994,
      h * 0.8531,
      w * 0.8986,
      h * 0.8366,
    );
    path.lineTo(
      w,
      h * 0.8304,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
