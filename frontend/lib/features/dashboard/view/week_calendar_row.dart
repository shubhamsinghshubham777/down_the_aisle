import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_icon.dart';
import 'package:frontend/common/view/underlined_text.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/utils/extensions.dart';
import 'package:frontend/utils/utils.dart';

class WeekCalendarRow extends StatefulWidget {
  const WeekCalendarRow({super.key});

  @override
  State<WeekCalendarRow> createState() => _WeekCalendarRowState();
}

class _WeekCalendarRowState extends State<WeekCalendarRow> {
  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'This Week',
                  style: TextStyle(
                    fontFamily: Constants.fontKantumruy,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ZoomTapDetector(
                onTap: () {},
                child: const UnderlinedText('View Calendar'),
              ),
              const SizedBox(width: 8),
              DtaIcon(
                Assets.iconArrowForward,
                color: appColors.accent,
                width: 8,
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: currentWeekDates.map((date) {
              final isSelected = date.isSameDate(today);
              return ZoomTapDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? appColors.primaryLight : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 8,
                    right: 10,
                    bottom: 4,
                  ),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: isSelected
                          ? appColors.primaryDark
                          : appColors.secondaryDark,
                      fontFamily: isSelected
                          ? Constants.fontElMessiri
                          : Constants.fontKantumruy,
                      fontSize: isSelected ? 24 : 16,
                      height: 1,
                    ),
                    child: Column(
                      children: [
                        Opacity(
                          opacity: isSelected ? 1 : 0,
                          child: Text(
                            date.monthName,
                            style: const TextStyle(fontSize: 10.38),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 6,
                            bottom: isSelected ? 0 : 4,
                          ),
                          child: Text(date.day.toString()),
                        ),
                        Text(
                          date.dayName[0],
                          style: const TextStyle(fontSize: 12),
                        ),
                        Offstage(
                          offstage: isSelected,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              children: List.generate(
                                3,
                                (index) => Container(
                                  width: 5,
                                  height: 5,
                                  margin: const EdgeInsets.only(right: 2),
                                  decoration: BoxDecoration(
                                    color: switch (index) {
                                      0 => Colors.green,
                                      1 => Colors.blue,
                                      _ => Colors.red,
                                    },
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
