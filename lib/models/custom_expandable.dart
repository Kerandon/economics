import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../configs/constants.dart';

class CustomExpandable extends StatelessWidget {
  const CustomExpandable({
    super.key,
    required this.title,
    required this.onExpand,
  });

  final String title;
  final Widget onExpand;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * kPageIndent),
      child: ExpandablePanel(
        header: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        collapsed: const SizedBox.shrink(),
        expanded: onExpand,
      ),
    );
  }
}
