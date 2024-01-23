import 'package:economics_app/state/app_state.dart';
import 'package:economics_app/utils/enums/level_enum.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopicContents extends ConsumerWidget {
  const TopicContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appProvider);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.mainTopics.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(state.mainTopics[index].unit.toString()),
          title: Text(state.mainTopics[index].title ?? ""),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 0,
                itemBuilder: (context, subIndex) {
                  return ListTile();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
