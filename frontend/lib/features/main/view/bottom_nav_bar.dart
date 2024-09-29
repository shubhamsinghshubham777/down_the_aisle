import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/constants/assets.dart';
import 'package:frontend/features/main/provider/main_screen_state.dart';
import 'package:frontend/features/main/view/main_screen.dart';
import 'package:frontend/utils/constants.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends ConsumerState<BottomNavBar> {
  late final screenChanger = ref.read(mainSelectedScreenTypeProvider.notifier);

  @override
  Widget build(BuildContext context) {
    final selectedScreen = ref.watch(mainSelectedScreenTypeProvider);
    return SizedBox(
      height: MainScreen.bottomNavBarHeight(
        context,
        addExtraSpace: false,
      ),
      child: Padding(
        padding: MainScreen.bottomNavBarPadding(context),
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
              BottomNavBarItem(
                asset: Assets.iconBottomNavHome,
                label: 'Home',
                selected: selectedScreen == MainScreenType.home,
                onTap: () => screenChanger.changeScreen(
                  MainScreenType.home,
                ),
              ),
              BottomNavBarItem(
                asset: Assets.iconBottomNavDash,
                label: 'Dashboard',
                selected: selectedScreen == MainScreenType.dashboard,
                onTap: () => screenChanger.changeScreen(
                  MainScreenType.dashboard,
                ),
              ),
              BottomNavBarItem(
                asset: Assets.iconBottomNavInspire,
                label: 'Inspire',
                selected: selectedScreen == MainScreenType.inspire,
                onTap: () => screenChanger.changeScreen(
                  MainScreenType.inspire,
                ),
              ),
              BottomNavBarItem(
                asset: Assets.iconBottomNavVendors,
                label: 'Vendors',
                selected: selectedScreen == MainScreenType.vendors,
                onTap: () => screenChanger.changeScreen(
                  MainScreenType.vendors,
                ),
              ),
              BottomNavBarItem(
                asset: Assets.iconBottomNavCollab,
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
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    required this.asset,
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
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
