import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomButtonOverlayAppBar extends StatelessWidget {
  const CustomButtonOverlayAppBar({
    super.key,
    required this.title,
    this.expansionControllers,
  });

  final String title;
  final List<ExpansionTileController>? expansionControllers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (expansionControllers != null &&
                  expansionControllers!.isNotEmpty) {
                for (var c in expansionControllers!) {
                  if (c.isExpanded) {
                    c.collapse();
                  }
                }
              }
            });
          },
          child: Center(
            child: AutoSizeText(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
