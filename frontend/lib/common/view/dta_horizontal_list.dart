import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/dta_icon.dart';
import 'package:frontend/common/view/section_header.dart';
import 'package:frontend/common/view/underlined_text.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/features/home/model/dta_horizontal_list_data.dart';
import 'package:frontend/features/home/view/status_label.dart';
import 'package:frontend/utils/constants.dart';

class DTAHorizontalList extends StatelessWidget {
  const DTAHorizontalList({
    required this.items,
    this.title,
    this.tags = const [],
    this.itemSize = DTAHorizontalListItemSize.medium,
    super.key,
  });

  final List<DTAHorizontalListData> items;
  final String? title;
  final List<String> tags;
  final DTAHorizontalListItemSize itemSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 24),
            child: SectionHeader(title: title!),
          ),
        if (tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: SizedBox(
              height: 16,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tags.length,
                padding: const EdgeInsets.only(left: 20, right: 12),
                itemBuilder: (listContext, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ZoomTapDetector(
                      onTap: () {},
                      child: UnderlinedText(tags[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        const SizedBox(height: 16),
        SizedBox(
          height: switch (itemSize) {
            DTAHorizontalListItemSize.small => 109,
            DTAHorizontalListItemSize.medium => 185.84,
            DTAHorizontalListItemSize.large => 259,
          },
          child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.only(left: 20, right: 4),
            scrollDirection: Axis.horizontal,
            itemBuilder: (listContext, index) {
              final itemData = items[index];
              return ZoomTapDetector(
                onTap: itemData.onTap,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: itemData.imageUrl,
                          width: switch (itemSize) {
                            DTAHorizontalListItemSize.small => 76,
                            DTAHorizontalListItemSize.medium => 148,
                            DTAHorizontalListItemSize.large => 176,
                          },
                          height: switch (itemSize) {
                            DTAHorizontalListItemSize.small => 77,
                            DTAHorizontalListItemSize.medium => 128,
                            DTAHorizontalListItemSize.large => 259,
                          },
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) {
                            return ColoredBox(
                              color: appColors.primaryLight,
                              child: Center(
                                child: DtaIcon(
                                  Assets.iconWarning,
                                  color: appColors.accent.withOpacity(0.8),
                                  width: 32,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (itemData.itemTitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            itemData.itemTitle!,
                            style: listContext.titleSmall?.copyWith(
                              fontFamily: Constants.fontKantumruy,
                              fontWeight:
                                  itemSize == DTAHorizontalListItemSize.medium
                                      ? FontWeight.bold
                                      : null,
                            ),
                          ),
                        ),
                      const Spacer(),
                      if (itemData.isCompleted != null)
                        StatusLabel(isCompleted: itemData.isCompleted!),
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

enum DTAHorizontalListItemSize { small, medium, large }
