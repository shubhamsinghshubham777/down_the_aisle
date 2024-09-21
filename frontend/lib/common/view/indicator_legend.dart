import 'package:flutter/material.dart';
import 'package:frontend/utils/constants.dart';

class IndicatorLegend extends StatelessWidget {
  const IndicatorLegend({required this.text, required this.color, super.key});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Opacity(
            opacity: 0.8,
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: Constants.fontKantumruy,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
