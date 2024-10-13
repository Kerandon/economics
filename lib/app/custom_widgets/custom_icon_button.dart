import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.onPressed, required this.icon});

  final VoidCallback? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: onPressed != null
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.scrim,
          width: 2,
        ),
        shape: BoxShape.circle, // Circular shape
      ),
      child: IconButton(
        onPressed: onPressed != null
            ? () {
                onPressed?.call();
              }
            : null,
        icon: Icon(
          size: 20,
          icon,
          color: onPressed != null
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.scrim,
        ),
        color: Colors.white, // White icon color for contrast
      ),
    );
  }
}
