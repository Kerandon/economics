import 'package:flutter/material.dart';

import 'custom_chip_button.dart';

class CustomPopup extends StatelessWidget {
  const CustomPopup({
    super.key,
    required this.actionButtons,
    required this.title,
    this.content,
  });

  final String title;
  final Widget? content;
  final List<CustomChipButton> actionButtons;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: actionButtons,
    );
  }
}
