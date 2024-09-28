import 'package:auto_size_text/auto_size_text.dart';
import 'package:economics_app/app/state/app_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../configs/constants.dart';

class CustomPageHeading extends ConsumerWidget {
  const CustomPageHeading({
    super.key,
    required this.title,
    this.icon,
    this.expandableControllers,
    this.trailing,
  });

  final String title;
  final Icon? icon;
  final List<ExpandableController>? expandableControllers;
  final Widget? trailing;

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
          height: size.height * 0.08,
          decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primary,
              borderRadius: BorderRadius.circular(kRadius)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: icon != null ? IconButton(
                  icon: icon!,
                  onPressed: null,
                ) : const SizedBox.shrink(),
              ),
              Expanded(
                flex: 12,

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white,),
                    ),
                  ),
                ),

              if (trailing != null) ...[
                Expanded(child: trailing!),
              ],
              if (expandableControllers != null) ...[
                Expanded(
                  child: IconButton(
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
                ),
              ],
              if (expandableControllers == null && trailing == null) ...[
                const Expanded(child: SizedBox.shrink()),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
