
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../configs/constants.dart';

class CustomPageHeading extends StatelessWidget {
  const CustomPageHeading({
    super.key,
    required this.title,
    required this.icon,
    this.expandableControllers,
    this.allTilesCollapsed,
  });

  final String title;
  final Icon icon;
  final List<ExpandableController>? expandableControllers;
  final bool? allTilesCollapsed;

  @override
  Widget build(BuildContext context) {
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
              IconButton(icon: icon, onPressed: null,),
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
              if(expandableControllers != null && expandableControllers!.isNotEmpty) ... [IconButton(
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
                    allTilesCollapsed!
                        ? Icons.expand
                        : Icons.close_fullscreen_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  )),],
              if(expandableControllers == null || expandableControllers!.isEmpty)...[
                IconButton(onPressed: (){}, icon: icon, color: Colors.transparent,)
              ]
            ],
          ),
        ),
      ),
    );
  }
}
