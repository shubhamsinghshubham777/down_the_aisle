import 'dart:async';

import 'package:animations/animations.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/common/providers.dart';
import 'package:frontend/common/view/app_colors.dart';
import 'package:frontend/features/auth/view/authentication_screen.dart';
import 'package:frontend/features/main/view/main_screen.dart';
import 'package:frontend/utils/extensions.dart';
import 'package:frontend/utils/utils.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupDesktopWindow();
  final appEnv = AppEnvironment.values.firstWhere(
    (e) => e.name == const String.fromEnvironment('APP_ENV'),
    orElse: () => AppEnvironment.prod,
  );
  await dotenv.load(fileName: '.env.${appEnv.name}');
  unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge));
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarContrastEnforced: false,
    ),
  );
  runApp(const ProviderScope(child: App()));
}

void _setupDesktopWindow() {
  if (!kIsWeb) {
    windowManager
      ..ensureInitialized()
      ..waitUntilReadyToShow(
        const WindowOptions(minimumSize: Size(450, 450)),
        () => windowManager
          ..show()
          ..focus(),
      );
  }
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  bool? isUserLoggedIn;

  @override
  void initState() {
    postFrameCallback(() async {
      final prefs = await ref.read(sharedPreferencesProvider.future);
      setState(() => isUserLoggedIn = prefs.accessToken != null);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: appColors.primaryDark,
          selectionColor: appColors.secondaryMedium,
          selectionHandleColor: appColors.secondaryMedium,
        ),
        colorScheme: ColorScheme.light(
          surface: appColors.surface,
          onSurface: appColors.secondaryDark,
        ),
      ),
      home: PageTransitionSwitcher(
        duration: 3.seconds,
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1, 0),
            ).animate(
              CurvedAnimation(
                parent: secondaryAnimation,
                curve: Curves.elasticInOut,
              ),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: primaryAnimation,
                  curve: Curves.elasticInOut,
                ),
              ),
              child: child,
            ),
          );
        },
        child: isUserLoggedIn == null
            ? Scaffold(
                backgroundColor: appColors.backgroundPink,
                body: Center(
                  child: CircularProgressIndicator(color: appColors.accent),
                ),
              )
            : isUserLoggedIn!
                ? const MainScreen()
                : const AuthenticationScreen(),
      ),
    );
  }
}

enum AppEnvironment { dev, prod }
