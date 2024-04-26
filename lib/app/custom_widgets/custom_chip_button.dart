import 'package:flutter/material.dart';

class CustomChipButton extends StatelessWidget {
  const CustomChipButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onBackground,
        )),
        onPressed: onPressed,
        child: Text(text));
  }
}
