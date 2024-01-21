import 'package:economics_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'custom_tile.dart';

class TopicTiles extends ConsumerWidget {
  const TopicTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final gap = size.width * 0.01;
    final state = ref.watch(appProvider);
    return GridView.builder(
      itemCount: state.contents.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: gap,
        crossAxisSpacing: gap,
      ),
      itemBuilder: (context, index) => CustomTile(
        title: state.contents[index].title ?? "",
      ),
    );
  }
}
