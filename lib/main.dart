import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app/configs/theme_data.dart';
import 'app/state/app_state.dart';
import 'home_page_new/pages/home_page.dart';

void main() {
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
      home: HomePage(),
    );
  }
}
