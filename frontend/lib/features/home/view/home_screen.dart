import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_icon.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/features/home/view/setup_profile_section.dart';
import 'package:frontend/features/home/view/upcoming_task_card.dart';
import 'package:frontend/utils/constants.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SetupProfileSection(),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: UpcomingTaskCard(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 145,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20, right: 4),
                itemBuilder: (listContext, index) {
                  return TaskQuickDetailsCard(
                    key: Key(index.toString()),
                    dateTime: DateTime.now(),
                    iconAsset: switch (index) {
                      0 => Assets.iconsCalendar,
                      1 => Assets.iconsMoney,
                      _ => Assets.iconsBiBell,
                    },
                    title: switch (index) {
                      0 => 'Wedding',
                      1 => 'Budget',
                      _ => 'Task $index',
                    },
                    value: switch (index) {
                      0 => '163',
                      1 => '41',
                      _ => '80',
                    },
                    valueUnit: switch (index) {
                      0 => 'Days',
                      1 => '% Spent',
                      _ => '% Done',
                    },
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskQuickDetailsCard extends StatelessWidget {
  const TaskQuickDetailsCard({
    required this.title,
    required this.value,
    required this.valueUnit,
    required this.dateTime,
    required this.iconAsset,
    required this.onTap,
    super.key,
  });

  final String title;
  final String value;
  final String valueUnit;
  final DateTime dateTime;
  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        width: 156,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: appColors.primaryLight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: context.bodySmall?.copyWith(
                    color: appColors.secondaryDark,
                    fontFamily: Constants.fontKantumruy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: appColors.accent,
                  size: 16,
                ),
              ],
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: value,
                  style: context.displayLarge?.copyWith(
                    color: appColors.primaryDark,
                    fontSize: 56,
                    fontFamily: Constants.fontDMSerifDisplay,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: ' $valueUnit',
                      style: context.titleMedium?.copyWith(
                        color: appColors.primaryDark,
                        fontFamily: Constants.fontDMSerifDisplay,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(dateTime),
                  style: context.bodySmall?.copyWith(
                    color: appColors.secondaryDark.withOpacity(0.8),
                    fontFamily: Constants.fontKantumruy,
                  ),
                ),
                DtaIcon(
                  Assets.iconsCalendar,
                  color: appColors.secondaryDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
