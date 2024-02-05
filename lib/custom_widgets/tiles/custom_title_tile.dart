import 'package:economics_app/utils/helper_methods/string_extensions.dart';
import 'package:flutter/material.dart';

class CustomTitleTile extends StatelessWidget {
  const CustomTitleTile(
    this.title, {
    this.leading,
    super.key,
  });

  final Widget? leading;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title != null
          ? Text(
              title!.capitalizeFirstLetter(),
              style: Theme.of(context).textTheme.headlineMedium,
            )
          : null,
    );
  }
}
