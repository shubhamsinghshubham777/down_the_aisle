import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_icon.dart';
import 'package:frontend/common/view/section_header.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/utils/extensions.dart';

class DueTasksList extends StatelessWidget {
  const DueTasksList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SectionHeader(
            title: 'Due this week (5)',
            dense: true,
            onActionTap: () {},
          ),
          const SizedBox(height: 16),
          ...List.generate(
            3,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _DueTaskListItem(
                  key: ValueKey(index),
                  title: switch (index) {
                    0 => 'Finalise Caterer',
                    1 => 'Book Florist',
                    _ => 'Finalise Venue',
                  },
                  dateTime: DateTime.now().add(index.days),
                  userImageUrls: List.filled(2, fakeUserImage),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DueTaskListItem extends StatelessWidget {
  const _DueTaskListItem({
    required this.title,
    required this.dateTime,
    required this.userImageUrls,
    super.key,
  });

  final String title;
  final DateTime dateTime;
  final List<String> userImageUrls;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF7F7F7),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZoomTapDetector(
              onTap: () {},
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: appColors.secondaryDark.withOpacity(0.6),
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: Constants.fontKantumruy,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Opacity(
                    opacity: 0.6,
                    child: Text(
                      '${dateTime.day} ${dateTime.monthName}, '
                      '${dateTime.dayName}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontFamily: Constants.fontKantumruy,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 48,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      2,
                      (index) => DtaIcon(
                        switch (index) {
                          0 => Assets.iconChatBubble,
                          _ => Assets.iconBiBell,
                        },
                        color: appColors.secondaryDark.withOpacity(0.6),
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    children: userImageUrls
                        .mapIndexed(
                          (index, url) => Transform.translate(
                            offset: Offset(index > 0 ? (14.0 * index) : 0, 0),
                            child: CircleAvatar(
                              foregroundImage: NetworkImage(url),
                              radius: 10,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const fakeUserImage =
    'https://r2.starryai.com/results/1005156662/01ea57ea-66bd-4bed-a467-11bbdedb43ea.webp';
