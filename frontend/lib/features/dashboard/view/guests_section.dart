import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/indicator_legend.dart';
import 'package:frontend/common/view/section_header.dart';
import 'package:frontend/utils/constants.dart';

class GuestsSection extends StatelessWidget {
  const GuestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SectionHeader(title: 'Guests'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                      sections: [
                        PieChartSectionData(
                          color: appColors.primaryDark,
                          value: 211,
                          title: '211',
                          radius: 100,
                        ),
                        PieChartSectionData(
                          color: appColors.primaryLight,
                          value: 124,
                          title: '124',
                          radius: 100,
                        ),
                        PieChartSectionData(
                          color: appColors.accent,
                          value: 223,
                          title: '223',
                          radius: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Guests',
                    style: TextStyle(
                      fontFamily: Constants.fontKantumruy,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '558',
                    style: TextStyle(
                      color: appColors.primaryDark,
                      fontFamily: Constants.fontDMSerifDisplay,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  IndicatorLegend(
                    text: 'Confirmed',
                    color: appColors.accent,
                  ),
                  const SizedBox(height: 16),
                  IndicatorLegend(
                    text: 'Pending',
                    color: appColors.primaryDark,
                  ),
                  const SizedBox(height: 16),
                  IndicatorLegend(
                    text: 'Not attending',
                    color: appColors.primaryLight,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
