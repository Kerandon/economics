import 'package:flutter/material.dart';

import '../../configs/constants.dart';

class CustomSubheadingTile extends StatelessWidget {
  const CustomSubheadingTile({
    super.key,
    required this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  });

  final String leading;
  final String title;
  final String? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final indent = size.width * kDividerIndent;
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Text(leading),
          title: Text(title),
          trailing: trailing != null ? Text(trailing!) : null,
        ),
        Divider(
          indent: indent,
          endIndent: indent,
        )
      ],
    );
  }
}
