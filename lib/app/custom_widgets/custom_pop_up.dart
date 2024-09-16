import 'package:flutter/material.dart';

class CustomPopUp extends StatelessWidget {
  const CustomPopUp({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: subtitle != null
          ? const Text(
              'Multi-choice questions must have between 2 to 4 answers')
          : null,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close this dialog
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
