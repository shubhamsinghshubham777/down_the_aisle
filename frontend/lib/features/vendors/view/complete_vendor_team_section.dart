import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/section_header.dart';
import 'package:frontend/features/home/view/home_screen.dart';
import 'package:frontend/utils/constants.dart';

class CompleteVendorTeamSection extends StatelessWidget {
  const CompleteVendorTeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Complete your vendor team'),
          const SizedBox(height: 4),
          const Opacity(
            opacity: 0.8,
            child: Text(
              'Find and book your vendors step by step',
              style: TextStyle(
                fontFamily: Constants.fontKantumruy,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          SectionHeader(
            title: '2/9 Services Booked',
            titleAlternateFont: true,
            onActionTap: () {},
            actionAsset: null,
            dense: true,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.4,
            backgroundColor: appColors.secondaryLight,
            color: appColors.primaryDark,
            borderRadius: BorderRadius.circular(16),
            minHeight: 12,
          ),
          const SizedBox(height: 16),
          ...List.filled(
            3,
            const _VendorTeamListItem(
              categoryName: 'Photographers',
              shortlistedCount: 3,
              bookedCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorTeamListItem extends StatelessWidget {
  const _VendorTeamListItem({
    required this.categoryName,
    required this.shortlistedCount,
    required this.bookedCount,
  });

  final String categoryName;
  final int shortlistedCount;
  final int bookedCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: appColors.secondaryLight,
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              width: 48,
              height: 48,
              child: CachedNetworkImage(
                imageUrl: fakeTaskImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          DefaultTextStyle(
            style: TextStyle(
              color: appColors.secondaryDark.withOpacity(0.8),
              fontFamily: Constants.fontKantumruy,
              fontSize: 14,
              height: 1.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('Shortlisted : $shortlistedCount'),
                    const SizedBox(
                      height: 20,
                      child: VerticalDivider(),
                    ),
                    Text('Booked : $bookedCount'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
