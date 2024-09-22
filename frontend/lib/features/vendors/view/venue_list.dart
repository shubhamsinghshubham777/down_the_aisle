import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_icon.dart';
import 'package:frontend/common/view/heart_painter.dart';
import 'package:frontend/common/view/section_header.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/features/home/view/home_screen.dart';
import 'package:frontend/utils/constants.dart';

class VenueList extends StatelessWidget {
  const VenueList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionHeader(
            title: 'Pick your Venue',
            actionAsset: null,
            onActionTap: () {},
          ),
        ),
        const SizedBox(height: 8),
        const _VenueCategorySelector(),
        const SizedBox(height: 16),
        SizedBox(
          height: 248,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (_, index) {
              final isLastIndex = index == 4;
              return _VenueItem(
                key: ValueKey(index),
                isLastIndex: isLastIndex,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _VenueItem extends StatelessWidget {
  const _VenueItem({
    super.key,
    required this.isLastIndex,
  });

  final bool isLastIndex;

  @override
  Widget build(BuildContext context) {
    return ZoomTapDetector(
      onTap: () {},
      child: Container(
        width: 240,
        margin: EdgeInsets.only(
          right: isLastIndex ? 0 : 16,
          top: 8,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 4.94),
              blurRadius: 4,
            ),
          ],
          border: Border.all(
            color: const Color(0xFFF0F0F0),
            width: 0.99,
          ),
          color: appColors.surface,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: fakeTaskImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bloom Hotel',
                      style: TextStyle(
                        color: appColors.secondaryDark,
                        fontFamily: Constants.fontDMSerifDisplay,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        DtaIcon(
                          Assets.iconsStar,
                          color: appColors.yellow,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          '4.93',
                          style: TextStyle(
                            fontFamily: Constants.fontKantumruy,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '(111 reviews)',
                          style: TextStyle(
                            color: appColors.secondaryDark.withOpacity(
                              0.6,
                            ),
                            fontFamily: Constants.fontKantumruy,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                        const Spacer(),
                        ZoomTapDetector(
                          onTap: () {},
                          child: const CustomPaint(
                            size: Size(20, 16),
                            painter: HeartPainter(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VenueCategorySelector extends StatelessWidget {
  const _VenueCategorySelector();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (_, index) {
          final isSelected = index == 0;
          final isLastIndex = index == 9;
          return Padding(
            padding: EdgeInsets.only(right: isLastIndex ? 0 : 12),
            child: ZoomTapDetector(
              onTap: () {},
              child: Chip(
                backgroundColor:
                    isSelected ? appColors.primaryDark : appColors.primaryLight,
                label: Text(
                  'Top Rated',
                  style: TextStyle(
                    color: isSelected
                        ? appColors.surface
                        : appColors.secondaryDark,
                    fontFamily: Constants.fontKantumruy,
                    fontSize: 14,
                  ),
                ),
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
