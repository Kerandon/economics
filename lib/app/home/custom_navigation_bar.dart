import 'package:economics_app/app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/get_custom_icon.dart';

class CustomNavigationBar extends ConsumerWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);
    final appNotifier = ref.read(appProvider.notifier);
    return NavigationBar(
      indicatorColor: Theme.of(context).colorScheme.primary,
      selectedIndex: appState.page,
      onDestinationSelected: (index) {
        appNotifier.setPage(index);
      },
      destinations: [
        NavigationDestination(
          icon: getCustomIcon(CustomIcon.quiz),
          label: 'Quiz',
        ),
        NavigationDestination(
          icon: getCustomIcon(CustomIcon.diagrams),
          label: 'Diagrams',
        ),
      ],
    );
  }
}
