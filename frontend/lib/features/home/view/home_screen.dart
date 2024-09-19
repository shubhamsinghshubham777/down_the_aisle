import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/view/custom_package_advertisement.dart';
import 'package:frontend/common/view/dta_app_bar.dart';
import 'package:frontend/common/view/dta_horizontal_list.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/features/home/model/dta_horizontal_list_data.dart';
import 'package:frontend/features/home/view/setup_profile_section.dart';
import 'package:frontend/features/home/view/task_quick_details_card.dart';
import 'package:frontend/features/home/view/upcoming_task_card.dart';
import 'package:frontend/features/main/view/main_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
    this.onDrawerOpen,
  });

  final VoidCallback? onDrawerOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const SetupProfileSection(),
                DTAAppBar(onDrawerOpen: onDrawerOpen),
              ],
            ),
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
                itemBuilder: (_, index) {
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
            DTAHorizontalList(
              title: 'Tasks',
              items: [
                DTAHorizontalListData(
                  imageUrl: _fakeTaskImage,
                  itemTitle: 'Food Menu',
                  isCompleted: false,
                  onTap: () {},
                ),
                DTAHorizontalListData(
                  imageUrl: _fakeTaskImage,
                  itemTitle: 'Guest List',
                  isCompleted: true,
                  onTap: () {},
                ),
                DTAHorizontalListData(
                  imageUrl: _fakeTaskImage,
                  itemTitle: 'Vendor',
                  isCompleted: false,
                  onTap: () {},
                ),
              ],
            ),
            DTAHorizontalList(
              title: 'Vendors',
              itemSize: DTAHorizontalListItemSize.small,
              items: [
                DTAHorizontalListData(
                  imageUrl: _fakeTaskImage,
                  itemTitle: 'Decor',
                  onTap: () {},
                ),
                DTAHorizontalListData(
                  imageUrl: _fakeTaskImage,
                  itemTitle: 'Makeup',
                  onTap: () {},
                ),
                DTAHorizontalListData(
                  imageUrl: _fakeTaskImage,
                  itemTitle: 'Caterer',
                  onTap: () {},
                ),
                DTAHorizontalListData(
                  imageUrl: _fakeTaskImage,
                  itemTitle: 'Clothing',
                  onTap: () {},
                ),
              ],
            ),
            const CustomPackageAdvertisement(),
            DTAHorizontalList(
              title: 'Trending Today',
              tags: const ['#goldlehnga'],
              itemSize: DTAHorizontalListItemSize.large,
              items: [
                DTAHorizontalListData(
                  imageUrl: _fakeTaskImage,
                  onTap: () {},
                ),
                DTAHorizontalListData(
                  imageUrl: _fakeTaskImage,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(
              height: MainScreen.bottomNavBarHeight(context),
            ),
          ],
        ),
      ),
    );
  }
}

const _fakeTaskImage =
    'https://media.istockphoto.com/id/1290444763/photo/assorted-of-indian-dish-with-curry-dish-naan-chicken.jpg?s=612x612&w=0&k=20&c=5q09leP6_QnvdUEfsB6KUXDTTBJtl88bEwrDfRVNA0U=';
