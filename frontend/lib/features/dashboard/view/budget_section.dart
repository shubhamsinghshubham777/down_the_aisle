import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/indicator_legend.dart';
import 'package:frontend/common/view/section_header.dart';
import 'package:frontend/common/view/underlined_text.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/utils/constants.dart';

class BudgetSection extends StatelessWidget {
  const BudgetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionHeader(
            title: 'Budget',
            actionText: 'View More',
            onActionTap: () {},
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 16, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: appColors.primaryLight,
          ),
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            height: 124,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _CostColumn(
                    title: 'Estimated Cost',
                    amount: '20,00,00',
                    child: ZoomTapDetector(
                      onTap: () {},
                      child: const UnderlinedText('Edit'),
                    ),
                  ),
                ),
                VerticalDivider(
                  color: appColors.primaryDark,
                  thickness: 1.1,
                  indent: 8,
                  endIndent: 8,
                ),
                Expanded(
                  child: _CostColumn(
                    title: 'Final Cost',
                    amount: '10,00,00',
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: appColors.secondaryDark,
                        fontSize: 12,
                      ),
                      child: const Opacity(
                        opacity: 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Paid - 6,00,000',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Pending - 4,00,000',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 16, right: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  _LinearProgressIndicator(
                    value: 1,
                    color: appColors.primaryLight,
                  ),
                  _LinearProgressIndicator(
                    value: 0.7,
                    color: appColors.primaryDark,
                  ),
                  _LinearProgressIndicator(
                    value: 0.45,
                    color: appColors.accent,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: IndicatorLegend(
                      text: 'Total Cost',
                      color: appColors.accent,
                    ),
                  ),
                  Flexible(
                    child: IndicatorLegend(
                      text: 'Paid',
                      color: appColors.primaryDark,
                    ),
                  ),
                  Flexible(
                    child: IndicatorLegend(
                      text: 'Pending',
                      color: appColors.primaryLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CostColumn extends StatelessWidget {
  const _CostColumn({
    required this.title,
    required this.amount,
    required this.child,
  });

  final String title;
  final String amount;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DefaultTextStyle(
        style: TextStyle(
          color: appColors.secondaryDark,
          fontFamily: Constants.fontKantumruy,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Text(
              '$amount Rs',
              style: TextStyle(
                color: appColors.primaryDark,
                fontFamily: Constants.fontDMSerifDisplay,
                fontSize: 24,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}

class _LinearProgressIndicator extends StatelessWidget {
  const _LinearProgressIndicator({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      borderRadius: BorderRadius.circular(16),
      color: color,
      backgroundColor: Colors.transparent,
      minHeight: 18,
      value: value,
    );
  }
}
