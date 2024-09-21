import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/view/dta_horizontal_list.dart';
import 'package:frontend/features/dashboard/view/budget_section.dart';
import 'package:frontend/features/dashboard/view/collaborators_wrapped_list.dart';
import 'package:frontend/features/dashboard/view/current_date_tasks_list.dart';
import 'package:frontend/features/dashboard/view/due_tasks_list.dart';
import 'package:frontend/features/dashboard/view/guests_section.dart';
import 'package:frontend/features/dashboard/view/task_count_section.dart';
import 'package:frontend/features/dashboard/view/week_calendar_row.dart';
import 'package:frontend/features/home/model/dta_horizontal_list_data.dart';
import 'package:frontend/features/home/view/home_screen.dart';
import 'package:frontend/features/main/view/main_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({
    super.key,
    this.onDrawerOpen,
  });

  final VoidCallback? onDrawerOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TaskCountSection(onDrawerOpen: onDrawerOpen),
            const WeekCalendarRow(),
            const SizedBox(height: 16),
            const CurrentDateTasksList(),
            const SizedBox(height: 24),
            const DueTasksList(),
            DTAHorizontalList(
              items: [
                DTAHorizontalListData(
                  imageUrl: fakeTaskImage,
                  itemTitle: 'Food Menu',
                  isCompleted: false,
                  onTap: () {},
                ),
                DTAHorizontalListData(
                  imageUrl: fakeTaskImage,
                  itemTitle: 'Guest List',
                  isCompleted: true,
                  onTap: () {},
                ),
                DTAHorizontalListData(
                  imageUrl: fakeTaskImage,
                  itemTitle: 'Vendor',
                  isCompleted: false,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            const CollaboratorsWrappedList(),
            const SizedBox(height: 24),
            const BudgetSection(),
            const SizedBox(height: 24),
            const GuestsSection(),
            SizedBox(height: MainScreen.bottomNavBarHeight(context)),
          ],
        ),
      ),
    );
  }
}
