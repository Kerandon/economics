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
      itemCount: state.contents.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(state.contents[index].unit.toString()),
          title: Text(state.contents[index].title ?? ""),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.contents[index].subtopics?.length,
                itemBuilder: (context, subIndex) {
                  return ListTile(
                    leading: Text(state
                            .contents[index].subtopics?[subIndex].unit
                            .toString() ??
                        ""),
                    trailing: Text(state.contents[index].subtopics?[subIndex]
                            .level!.formattedName ??
                        ""),
                    title: Text(
                        state.contents[index].subtopics?[subIndex].title ?? ""),
                    // Additional subtopic details can be displayed here
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
