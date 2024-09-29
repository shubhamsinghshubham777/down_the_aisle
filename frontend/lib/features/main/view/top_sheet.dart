import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/common/view/zoom_tap_animation.dart';
import 'package:frontend/features/main/provider/main_screen_state.dart';
import 'package:frontend/utils/constants.dart';

class TopSheet extends ConsumerWidget {
  const TopSheet({super.key});

  static const _duration = Durations.medium4;
  static const _curve = Curves.fastOutSlowIn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDrawerOpen = ref.watch(isDrawerOpenProvider);
    final drawerController = ref.watch(isDrawerOpenProvider.notifier);

    return Stack(
      children: [
        // Scrim
        AnimatedSwitcher(
          duration: _duration,
          switchInCurve: _curve,
          switchOutCurve: _curve,
          child: isDrawerOpen
              ? GestureDetector(
                  onTap: drawerController.closeDrawer,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black54,
                  ),
                )
              : null,
        ),

        // Content
        Align(
          alignment: Alignment.topCenter,
          child: AnimatedSwitcher(
            duration: _duration,
            switchInCurve: _curve,
            switchOutCurve: _curve,
            transitionBuilder: (child, animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            child: isDrawerOpen
                ? Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: appColors.surface,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: context.mqViewPadding.top + 8),
                            const Text(
                              'Down the Aisle',
                              style: TextStyle(
                                fontFamily: Constants.fontDMSerifDisplay,
                                fontSize: 28,
                              ),
                            ),
                            const Text(
                              'Your own wedding companion',
                              style: TextStyle(
                                fontFamily: Constants.fontKrylon,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                2,
                                (index) => ZoomTapDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: appColors.secondaryDark,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    // TODO(Shubham) : Replace `1` with `lastIndex`
                                    margin: index != 1
                                        ? const EdgeInsets.only(right: 24)
                                        : null,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          switch (index) {
                                            1 => Icons.policy,
                                            _ => Icons.handshake,
                                          },
                                          size: 48,
                                          color: appColors.secondaryLight,
                                        ),
                                        const SizedBox(height: 12),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Text(
                                            switch (index) {
                                              1 => 'Terms & Conditions',
                                              _ => 'Privacy Policy',
                                            },
                                            style: TextStyle(
                                              color: appColors.secondaryLight,
                                              fontFamily:
                                                  Constants.fontElMessiri,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: IconButton.filled(
                              onPressed: drawerController.closeDrawer,
                              icon: const Icon(Icons.arrow_upward),
                              style: IconButton.styleFrom(
                                backgroundColor: appColors.accent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
