import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_icon.dart';
import 'package:frontend/common/view/underlined_text.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/utils/constants.dart';

class UpcomingTaskCard extends StatelessWidget {
  const UpcomingTaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        color: appColors.primaryLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Upcoming',
                    style: TextStyle(
                      fontFamily: Constants.fontKantumruy,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ZoomTapDetector(
                  onTap: () {},
                  child: const UnderlinedText('View All Tasks'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Text(
              'Food Tasting',
              style: context.titleLarge?.copyWith(
                fontSize: 20,
                fontFamily: Constants.fontDMSerifDisplay,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: DefaultTextStyle(
              style: context.bodySmall!.copyWith(
                fontFamily: Constants.fontKantumruy,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12, bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '12 June, Monday',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6),
                          Text(
                            '12:30 pm',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 4, right: 24, bottom: 12),
                    child: Text(
                      'F9 Caterers',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  if (context.width > 360)
                    Container(
                      decoration: BoxDecoration(
                        color: appColors.primaryDark,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const DtaIcon(Assets.iconChatBubble),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                '1',
                                style: context.bodyLarge?.copyWith(
                                  color: appColors.surface,
                                  fontFamily: Constants.fontCalibri,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const DtaIcon(Assets.iconBiBell),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
