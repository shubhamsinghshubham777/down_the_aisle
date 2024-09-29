import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_screen_state.g.dart';

@riverpod
class IsDrawerOpen extends _$IsDrawerOpen {
  @override
  bool build() => false;
  void openDrawer() => state = true;
  void closeDrawer() => state = false;
}

@riverpod
class MainSelectedScreenType extends _$MainSelectedScreenType {
  @override
  MainScreenType build() => MainScreenType.home;

  void changeScreen(MainScreenType screen) => state = screen;
}

enum MainScreenType { home, dashboard, inspire, vendors, collab }
