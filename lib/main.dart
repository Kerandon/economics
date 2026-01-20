import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'app/configs/theme_data.dart';
import 'app/state/app_state.dart';
import 'home_page/pages/home_page_mobile.dart';
import 'home_page/pages/home_page_web.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {}
  runApp(const ProviderScope(child: EconApp()));
}

class EconApp extends ConsumerWidget {
  const EconApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: CustomAppTheme(appState, context).appTheme,

      /// Wrap the whole app with ResponsiveBreakpoints
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: const [
          Breakpoint(start: 0, end: 800, name: MOBILE),
          Breakpoint(start: 801, end: double.infinity, name: DESKTOP),
        ],
        child: child!,
      ),

      /// Pick the right homepage depending on screen size
      home: Builder(
        builder: (context) {
          final bp = ResponsiveBreakpoints.of(context);
          if (bp.isMobile) {
            return const HomePageMobile();
          } else {
            return const HomePageWeb();
          }
        },
      ),
    );
  }
}
