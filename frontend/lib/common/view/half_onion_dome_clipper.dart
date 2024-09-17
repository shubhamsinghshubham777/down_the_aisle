import 'package:flutter/material.dart';

class HalfOnionDomeClipper extends CustomClipper<Path> {
  const HalfOnionDomeClipper({this.close = true});

  final bool close;

  @override
  Path getClip(Size size) {
    final path = Path()..moveTo(size.width, 0);
    final heightDelta = close ? 0 : 8;
    final widthDelta = close ? 0 : 0.025;

    close ? path.lineTo(0, 0) : path.moveTo(0, 0);

    path
      ..lineTo(0, size.height - 104 - heightDelta)
      ..lineTo(
        size.width * (0.1037736 + widthDelta),
        size.height - 100 - heightDelta,
      )
      ..cubicTo(
        size.width * (0.09622640 + widthDelta),
        size.height - 76 - heightDelta,
        size.width * (0.1713837 + widthDelta),
        size.height - 76 - heightDelta,
        size.width * (0.2099056 + widthDelta),
        size.height - 76 - heightDelta,
      )
      ..cubicTo(
        size.width * (0.2020440 + widthDelta),
        size.height - 76 - heightDelta,
        size.width * (0.2155659 + widthDelta),
        size.height - 40 - heightDelta,
        size.width * (0.3325467 + widthDelta),
        size.height - 32 - heightDelta,
      )
      ..cubicTo(
        size.width * (0.4495280 + widthDelta),
        size.height - 30 - heightDelta,
        size.width * 0.4913520,
        size.height - 10 - heightDelta,
        size.width * 0.4976427,
        size.height - 10 - heightDelta,
      )
      ..cubicTo(
        size.width * 0.5015733,
        size.height - 10 - heightDelta,
        size.width * (0.5396213 - widthDelta),
        size.height - 32 - heightDelta,
        size.width * (0.6603787 - widthDelta),
        size.height - 36 - heightDelta,
      )
      ..cubicTo(
        size.width * (0.7811333 - widthDelta),
        size.height - 40 - heightDelta,
        size.width * (0.7940240 - widthDelta),
        size.height - 76 - heightDelta,
        size.width * (0.7853787 - widthDelta),
        size.height - 76 - heightDelta,
      )
      ..cubicTo(
        size.width * (0.8778293 - widthDelta),
        size.height - 76 - heightDelta,
        size.width * (0.8993707 - widthDelta),
        size.height - 82 - heightDelta,
        size.width * (0.8985840 - widthDelta),
        size.height - 100 - heightDelta,
      )
      ..lineTo(
        size.width,
        size.height - 104 - heightDelta,
      );

    close ? path.close() : path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
