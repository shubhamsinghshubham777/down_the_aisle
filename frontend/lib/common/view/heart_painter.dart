import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';

class HeartPainter extends CustomPainter {
  const HeartPainter({this.fill = false});

  final bool fill;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0.9302833, size.height * 0.2044393)
      ..cubicTo(
        size.width * 0.9159167,
        size.height * 0.1645060,
        size.width * 0.8951889,
        size.height * 0.1283193,
        size.width * 0.8692778,
        size.height * 0.09790400,
      )
      ..cubicTo(
        size.width * 0.8433444,
        size.height * 0.06739800,
        size.width * 0.8127667,
        size.height * 0.04315547,
        size.width * 0.7792111,
        size.height * 0.02649447,
      )
      ..cubicTo(
        size.width * 0.7444167,
        size.height * 0.009149400,
        size.width * 0.7070944,
        size.height * 0.0002711867,
        size.width * 0.6694167,
        size.height * 0.0003752533,
      )
      ..cubicTo(
        size.width * 0.6165556,
        size.height * 0.0003752533,
        size.width * 0.5649833,
        size.height * 0.01774513,
        size.width * 0.5201633,
        size.height * 0.05055500,
      )
      ..cubicTo(
        size.width * 0.5094411,
        size.height * 0.05840360,
        size.width * 0.4992550,
        size.height * 0.06702400,
        size.width * 0.4896050,
        size.height * 0.07641667,
      )
      ..cubicTo(
        size.width * 0.4799556,
        size.height * 0.06702400,
        size.width * 0.4697694,
        size.height * 0.05840360,
        size.width * 0.4590472,
        size.height * 0.05055500,
      )
      ..cubicTo(
        size.width * 0.4142283,
        size.height * 0.01774513,
        size.width * 0.3626550,
        size.height * 0.0003752533,
        size.width * 0.3097944,
        size.height * 0.0003752533,
      )
      ..cubicTo(
        size.width * 0.2717311,
        size.height * 0.0003752533,
        size.width * 0.2348467,
        size.height * 0.009124533,
        size.width * 0.1999994,
        size.height * 0.02649447,
      )
      ..cubicTo(
        size.width * 0.1663322,
        size.height * 0.04322100,
        size.width * 0.1359883,
        size.height * 0.06728133,
        size.width * 0.1099333,
        size.height * 0.09790400,
      )
      ..cubicTo(
        size.width * 0.08398556,
        size.height * 0.1282847,
        size.width * 0.06325778,
        size.height * 0.1644807,
        size.width * 0.04892439,
        size.height * 0.2044393,
      )
      ..cubicTo(
        size.width * 0.03402061,
        size.height * 0.2459987,
        size.width * 0.02640789,
        size.height * 0.2901307,
        size.width * 0.02640789,
        size.height * 0.3355500,
      )
      ..cubicTo(
        size.width * 0.02640789,
        size.height * 0.3783960,
        size.width * 0.03369894,
        size.height * 0.4230427,
        size.width * 0.04817389,
        size.height * 0.4684620,
      )
      ..cubicTo(
        size.width * 0.06029000,
        size.height * 0.5064187,
        size.width * 0.07766000,
        size.height * 0.5457900,
        size.width * 0.09985444,
        size.height * 0.5855480,
      )
      ..cubicTo(
        size.width * 0.1350233,
        size.height * 0.6484653,
        size.width * 0.1833806,
        size.height * 0.7140867,
        size.width * 0.2434244,
        size.height * 0.7806067,
      )
      ..cubicTo(
        size.width * 0.3429261,
        size.height * 0.8908733,
        size.width * 0.4414628,
        size.height * 0.9670400,
        size.width * 0.4456444,
        size.height * 0.9701333,
      )
      ..lineTo(size.width * 0.4710561, size.height * 0.9896867)
      ..cubicTo(
        size.width * 0.4823144,
        size.height * 0.9983067,
        size.width * 0.4967889,
        size.height * 0.9983067,
        size.width * 0.5080472,
        size.height * 0.9896867,
      )
      ..lineTo(size.width * 0.5334589, size.height * 0.9701333)
      ..cubicTo(
        size.width * 0.5376406,
        size.height * 0.9669133,
        size.width * 0.6360722,
        size.height * 0.8908733,
        size.width * 0.7356778,
        size.height * 0.7806067,
      )
      ..cubicTo(
        size.width * 0.7957222,
        size.height * 0.7140867,
        size.width * 0.8440778,
        size.height * 0.6484653,
        size.width * 0.8792500,
        size.height * 0.5855480,
      )
      ..cubicTo(
        size.width * 0.9014444,
        size.height * 0.5457900,
        size.width * 0.9189222,
        size.height * 0.5064187,
        size.width * 0.9309278,
        size.height * 0.4684620,
      )
      ..cubicTo(
        size.width * 0.9454056,
        size.height * 0.4230427,
        size.width * 0.9526944,
        size.height * 0.3783960,
        size.width * 0.9526944,
        size.height * 0.3355500,
      )
      ..cubicTo(
        size.width * 0.9528000,
        size.height * 0.2901307,
        size.width * 0.9451889,
        size.height * 0.2459987,
        size.width * 0.9302833,
        size.height * 0.2044393,
      )
      ..close();

    final paintFill = Paint()
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..color =
          fill ? appColors.accent : appColors.secondaryDark.withOpacity(0.6)
      ..strokeWidth = 1.75;

    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
