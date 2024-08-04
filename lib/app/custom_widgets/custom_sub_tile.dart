
import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class CustomSubTile extends StatelessWidget {
  const CustomSubTile({
    super.key,
    required this.leadingText,
    required this.title,
    this.removeDivider = false,
  });

  final String leadingText;
  final String title;
  final bool removeDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Text(leadingText),
          title: Text(title),
          onTap: () {},
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: Theme.of(context).colorScheme.primary,
            size: 18,
          ),
        ),
        if (!removeDivider) CustomDivider(),
      ],
    );
  }
}
