import 'package:flutter/material.dart';
import '../../configs/app_colors.dart';
import '../article/paragraph_heading.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.child,
    required this.expansionController,
  });

  final String title;
  final Widget child;
  final ExpansionTileController expansionController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: AppColors.defaultAppColor,
      ),
      child: ExpansionTile(
        iconColor: Colors.white,
        controller: expansionController,
        collapsedIconColor: Colors.white,
        initiallyExpanded: true,
        title: ParagraphBlock(
          title,
          isLarge: true,
          fontWeight: FontWeight.bold,
        ),
        children: [
          Container(
            width: size.width,
            color: Theme.of(context).colorScheme.background,
            child: child,
          ),
        ],
      ),
    );
  }
}
