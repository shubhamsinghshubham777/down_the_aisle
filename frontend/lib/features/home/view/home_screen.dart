import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/features/home/view/setup_profile_section.dart';
import 'package:frontend/features/home/view/task_quick_details_card.dart';
import 'package:frontend/features/home/view/upcoming_task_card.dart';

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
