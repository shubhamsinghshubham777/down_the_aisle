import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:easy_animated_indexed_stack/easy_animated_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/features/collab/view/collab_screen.dart';
import 'package:frontend/features/dashboard/view/dashboard_screen.dart';
import 'package:frontend/features/home/view/home_screen.dart';
import 'package:frontend/features/inspire/view/inspire_screen.dart';
import 'package:frontend/features/main/provider/main_screen_state.dart';
import 'package:frontend/features/vendors/view/vendors_screen.dart';
import 'package:frontend/utils/constants.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  static double bottomNavBarHeight(
    BuildContext context, {
    bool addExtraSpace = true,
  }) {
    return 74 +
        _bottomNavBarPadding(context).vertical +
        (addExtraSpace ? 24 : 0);
  }

  static EdgeInsets _bottomNavBarPadding(BuildContext context) {
    return EdgeInsets.only(
      left: _BottomNavItem.bottomNavBarHorizontalPadding,
      right: _BottomNavItem.bottomNavBarHorizontalPadding,
      bottom: context.mqViewPadding.bottom == 0
          ? _BottomNavItem.bottomNavBarHorizontalPadding
          : context.mqViewPadding.bottom,
    );
  }

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final screenChanger = ref.read(mainSelectedScreenTypeProvider.notifier);

  @override
  Widget build(BuildContext context) {
    final selectedScreen = ref.watch(mainSelectedScreenTypeProvider);

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      drawer: const Drawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          EasyAnimatedIndexedStack(
            index: selectedScreen.index,
            children: [
              HomeScreen(
                onDrawerOpen: _scaffoldKey.currentState?.openDrawer,
              ),
              DashboardScreen(
                onDrawerOpen: _scaffoldKey.currentState?.openDrawer,
              ),
              const InspireScreen(),
              const VendorsScreen(),
              const CollabScreen(),
            ],
          ),
          SizedBox(
            height: MainScreen.bottomNavBarHeight(
              context,
              addExtraSpace: false,
            ),
            child: Padding(
              padding: MainScreen._bottomNavBarPadding(context),
              child: Container(
                decoration: BoxDecoration(
                  color: appColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: appColors.secondaryDark.withOpacity(0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _BottomNavItem(
                      asset: Assets.iconsBottomNavHome,
                      label: 'Home',
                      selected: selectedScreen == MainScreenType.home,
                      onTap: () => screenChanger.changeScreen(
                        MainScreenType.home,
                      ),
                    ),
                    _BottomNavItem(
                      asset: Assets.iconsBottomNavDash,
                      label: 'Dashboard',
                      selected: selectedScreen == MainScreenType.dashboard,
                      onTap: () => screenChanger.changeScreen(
                        MainScreenType.dashboard,
                      ),
                    ),
                    _BottomNavItem(
                      asset: Assets.iconsBottomNavInspire,
                      label: 'Inspire',
                      selected: selectedScreen == MainScreenType.inspire,
                      onTap: () => screenChanger.changeScreen(
                        MainScreenType.inspire,
                      ),
                    ),
                    _BottomNavItem(
                      asset: Assets.iconsBottomNavVendors,
                      label: 'Vendors',
                      selected: selectedScreen == MainScreenType.vendors,
                      onTap: () => screenChanger.changeScreen(
                        MainScreenType.vendors,
                      ),
                    ),
                    _BottomNavItem(
                      asset: Assets.iconsBottomNavCollab,
                      label: 'Collab',
                      selected: selectedScreen == MainScreenType.collab,
                      onTap: () => screenChanger.changeScreen(
                        MainScreenType.collab,
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

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.asset,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String asset;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const double bottomNavBarHorizontalPadding = 24;

  @override
  Widget build(BuildContext context) {
    final color = selected ? appColors.accent : appColors.secondaryDark;

    return SizedBox(
      width: context.width
          .subtract(bottomNavBarHorizontalPadding * 2)
          .divide(MainScreenType.values.length)
          .toDouble(),
      child: ZoomTapDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                asset,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                width: 20,
                height: 20,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.bodyLarge?.copyWith(
                  color: color,
                  fontSize: 12,
                  fontFamily: Constants.fontKantumruy,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
