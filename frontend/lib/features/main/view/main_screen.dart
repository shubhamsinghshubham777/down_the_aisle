import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/collab/view/collab_screen.dart';
import 'package:frontend/features/dashboard/view/dashboard_screen.dart';
import 'package:frontend/features/home/view/home_screen.dart';
import 'package:frontend/features/inspire/view/inspire_screen.dart';
import 'package:frontend/features/main/provider/main_screen_state.dart';
import 'package:frontend/features/main/view/bottom_nav_bar.dart';
import 'package:frontend/features/main/view/top_sheet.dart';
import 'package:frontend/features/vendors/view/vendors_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static double bottomNavBarHeight(
    BuildContext context, {
    bool addExtraSpace = true,
  }) {
    return 74 +
        bottomNavBarPadding(context).vertical +
        (addExtraSpace ? 24 : 0);
  }

  static EdgeInsets bottomNavBarPadding(BuildContext context) {
    return EdgeInsets.only(
      left: BottomNavBarItem.bottomNavBarHorizontalPadding,
      right: BottomNavBarItem.bottomNavBarHorizontalPadding,
      bottom: context.mqViewPadding.bottom == 0
          ? BottomNavBarItem.bottomNavBarHorizontalPadding
          : context.mqViewPadding.bottom,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedScreen = ref.watch(mainSelectedScreenTypeProvider);
    final screenSelector = ref.watch(mainSelectedScreenTypeProvider.notifier);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: PopScope(
        canPop: selectedScreen != MainScreenType.home,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) screenSelector.changeScreen(MainScreenType.home);
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            EasyAnimatedIndexedStack(
              index: selectedScreen.index,
              children: const [
                HomeScreen(),
                DashboardScreen(),
                InspireScreen(),
                VendorsScreen(),
                CollabScreen(),
              ],
            ),
            const BottomNavBar(),
            const TopSheet(),
          ],
        ),
      ),
    );
  }
}
