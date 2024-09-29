import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/section_header.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/features/home/view/home_screen.dart';
import 'package:frontend/utils/constants.dart';

class TopVendorsList extends StatelessWidget {
  const TopVendorsList({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SectionHeader(title: 'Top Vendors'),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 132,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 4),
            itemCount: 3,
            itemBuilder: (_, index) {
              return ZoomTapDetector(
                onTap: () {},
                child: Container(
                  width: 248,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: appColors.primaryLight,
                    borderRadius: borderRadius,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: borderRadius,
                        child: CachedNetworkImage(
                          imageUrl: fakeTaskImage,
                          fit: BoxFit.cover,
                          width: 124,
                          height: double.infinity,
                        ),
                      ),
                      Expanded(
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontFamily: Constants.fontKantumruy,
                            height: 1.5,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '01',
                                style: TextStyle(
                                  color: appColors.primaryDark,
                                  fontFamily: Constants.fontDMSerifDisplay,
                                  fontSize: 54,
                                  height: 1,
                                ),
                              ),
                              Text(
                                'Lily Flowers',
                                style: TextStyle(
                                  color: appColors.secondaryDark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Florist',
                                style: TextStyle(
                                  color: appColors.secondaryDark.withOpacity(
                                    0.8,
                                  ),
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
