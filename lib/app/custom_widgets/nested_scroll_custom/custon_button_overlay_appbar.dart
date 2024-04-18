import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../configs/constants.dart';

class CustomButtonOverlayAppBar extends StatelessWidget {
  const CustomButtonOverlayAppBar({
    super.key,
    required this.title,
    required this.expansionControllers,
  });

  final String title;
  final List<ExpansionTileController> expansionControllers;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * kPageIndentHorizontal),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                for (var c in expansionControllers) {
                  if (c.isExpanded) {
                    c.collapse();
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
      ),
    );
  }
}
