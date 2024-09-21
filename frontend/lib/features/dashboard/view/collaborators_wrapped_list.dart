import 'package:flutter/material.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/section_header.dart';
import 'package:frontend/features/dashboard/view/due_tasks_list.dart';
import 'package:frontend/utils/constants.dart';

class CollaboratorsWrappedList extends StatelessWidget {
  const CollaboratorsWrappedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Level A Collaborators',
            onActionTap: () {},
          ),
          const SizedBox(height: 16),
          Wrap(
            runSpacing: 24,
            spacing: 48,
            children: List.filled(
              4,
              SizedBox(
                width: 150,
                height: 56,
                child: Row(
                  children: [
                    const CircleAvatar(
                      foregroundImage: NetworkImage(fakeUserImage),
                      radius: 32,
                    ),
                    Flexible(
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: appColors.secondaryDark,
                          fontFamily: Constants.fontKantumruy,
                          fontSize: 14,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sister',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '988820011',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
