import 'package:economics_app/app/state/app_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../configs/constants.dart';

class CustomPageHeading extends ConsumerWidget {
  const CustomPageHeading({
    super.key,
    required this.title,
    required this.icon,
    this.expandableControllers,
  });

  final String title;
  final Icon icon;
  final List<ExpandableController>? expandableControllers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appNotifier = ref.read(appProvider.notifier);
    bool showExpanded = false;
    if (expandableControllers != null) {
      if (expandableControllers!.any((c) => c.expanded)) {
        showExpanded = true;
      } else {
        showExpanded = false;
      }
      WidgetsBinding.instance.addPostFrameCallback((t) {
        appNotifier.toggleToRebuildWidgetTree();
      });
    }
    final size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.01),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(kBackgroundOpacity),
              borderRadius: BorderRadius.circular(kRadius)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: icon,
                onPressed: null,
              ),
              Padding(
                padding: EdgeInsets.all(size.width * 0.04),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              if (expandableControllers != null) ...[
                IconButton(
                  onPressed: () {
                    if (expandableControllers!.any((c) => c.expanded)) {
                      for (var c in expandableControllers!) {
                        if (c.expanded) {
                          c.toggle();
                        }
                      }
                    } else if (expandableControllers!
                        .every((c) => !c.expanded)) {
                      for (var c in expandableControllers!) {
                        c.toggle();
                      }
                    }
                  },
                  icon: Icon(
                    showExpanded
                        ? Icons.expand_more_outlined
                        : Icons.expand_less_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
              if (expandableControllers == null) ...[
                IconButton(
                  onPressed: () {},
                  icon: icon,
                  color: Colors.transparent,
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
