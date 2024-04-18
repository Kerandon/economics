import 'package:economics_app/app/state/app_state.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../sections/articles/articles_pages/sections_page.dart';

import '../../sections/settings/settings_page.dart';
import '../configs/constants.dart';
import 'custom_navigation_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        centerTitle: true,
      ),
      body: appState.page == 0 ? const SectionsPage() : const SectionsPage(),
      bottomNavigationBar: const CustomNavigationBar(),
      drawer: const SettingsPage(),
    );
  }
}
