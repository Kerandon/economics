import 'package:economics_app/utils/helper_methods/string_extensions.dart';
import 'package:flutter/material.dart';

class CustomHeadingTile extends StatelessWidget {
  const CustomHeadingTile(
    this.title, {
    this.leading,
    this.backgroundColor,
    this.isLarge = false,
    this.isItalic = false,
    super.key,
  });

  final Widget? leading;
  final String? title;
  final Color? backgroundColor;
  final bool isLarge;
  final bool isItalic;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title != null
          ? Text(title!.capitalizeFirstLetter(),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold))
          : null,
    );
  }
}
