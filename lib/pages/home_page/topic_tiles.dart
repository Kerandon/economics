import 'package:economics_app/state/app_state.dart';
import 'package:economics_app/pages/subtopics_page.dart';
import 'package:economics_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../custom_widgets/custom_tile.dart';

class TopicTiles extends ConsumerWidget {
  const TopicTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final gap = size.width * kPageIndent;
    final state = ref.watch(appProvider);

    return GridView.builder(
      itemCount: state.mainTopics.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: gap,
        crossAxisSpacing: gap,
      ),
      itemBuilder: (context, index) {
        final mainTopic = state.mainTopics[index];
        return CustomTile(
          title: mainTopic.title!,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SubtopicsPage(mainTopic)));
          },
        );
      },
    );
  }
}
