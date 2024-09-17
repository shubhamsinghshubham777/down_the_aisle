import 'package:animations/animations.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
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

  static const _appBarPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 24);

  static Size appBarSize(BuildContext context) => Size(
        context.width,
        // AppBar (content + padding) height
        36 + _appBarPadding.vertical,
      );

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final selectedScreen = ref.watch(mainSelectedScreenTypeProvider);
    final screenChanger = ref.watch(mainSelectedScreenTypeProvider.notifier);

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: MainScreen.appBarSize(context),
        child: Padding(
          padding: MainScreen._appBarPadding,
          child: Stack(
            children: [
              Align(
                child: PageTransitionSwitcher(
                  duration: _pageTransitionDuration,
                  transitionBuilder: (
                    child,
                    primaryAnimation,
                    secondaryAnimation,
                  ) {
                    return SharedAxisTransition(
                      animation: primaryAnimation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.vertical,
                      fillColor: Colors.transparent,
                      child: child,
                    );
                  },
                  child: Text(
                    switch (selectedScreen) {
                      MainScreenType.home => 'Welcome',
                      MainScreenType.dashboard => 'Dashboard',
                      MainScreenType.inspire => 'Inspirations',
                      MainScreenType.vendors => 'Vendors',
                      MainScreenType.collab => 'Collab',
                    },
                    key: Key(selectedScreen.name),
                    style: context.bodyLarge?.copyWith(
                      fontFamily: Constants.fontDMSerifDisplay,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ZoomTapAnimation(
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: appColors.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 5),
                          blurRadius: 20,
                          color: appColors.accent.withOpacity(0.15),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                        top: 5,
                        right: 4,
                        bottom: 3,
                      ),
                      child: SvgPicture.asset(Assets.iconsBxMenu),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ZoomTapAnimation(
                      onTap: () {},
                      child: SvgPicture.asset(Assets.iconsBiBell),
                    ),
                    const SizedBox(width: 20),
                    ZoomTapAnimation(
                      onTap: () {},
                      child: SvgPicture.asset(Assets.iconsOcticonPerson),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: _BottomNavItem.bottomNavBarHorizontalPadding,
          right: _BottomNavItem.bottomNavBarHorizontalPadding,
          bottom: context.mqViewPadding.bottom == 0
              ? _BottomNavItem.bottomNavBarHorizontalPadding
              : context.mqViewPadding.bottom,
        ),
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
                onTap: () => screenChanger.changeScreen(MainScreenType.home),
              ),
              _BottomNavItem(
                asset: Assets.iconsBottomNavDash,
                label: 'Dashboard',
                selected: selectedScreen == MainScreenType.dashboard,
                onTap: () =>
                    screenChanger.changeScreen(MainScreenType.dashboard),
              ),
              _BottomNavItem(
                asset: Assets.iconsBottomNavInspire,
                label: 'Inspire',
                selected: selectedScreen == MainScreenType.inspire,
                onTap: () => screenChanger.changeScreen(MainScreenType.inspire),
              ),
              _BottomNavItem(
                asset: Assets.iconsBottomNavVendors,
                label: 'Vendors',
                selected: selectedScreen == MainScreenType.vendors,
                onTap: () => screenChanger.changeScreen(MainScreenType.vendors),
              ),
              _BottomNavItem(
                asset: Assets.iconsBottomNavCollab,
                label: 'Collab',
                selected: selectedScreen == MainScreenType.collab,
                onTap: () => screenChanger.changeScreen(MainScreenType.collab),
              ),
            ],
          ),
        ),
      ),
      drawer: const Drawer(),
      body: PageTransitionSwitcher(
        duration: _pageTransitionDuration,
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
            child: child,
          );
        },
        child: switch (selectedScreen) {
          MainScreenType.home => const HomeScreen(),
          MainScreenType.dashboard => const DashboardScreen(),
          MainScreenType.inspire => const InspireScreen(),
          MainScreenType.vendors => const VendorsScreen(),
          MainScreenType.collab => const CollabScreen(),
        },
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
      child: ZoomTapAnimation(
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

final _pageTransitionDuration = 600.milliseconds;
