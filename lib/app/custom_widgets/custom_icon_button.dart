import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key, required this.onPressed, required this.icon});

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary, // Green background color
        shape: BoxShape.circle, // Circular shape
      ),
      child: IconButton(
        onPressed: () {
          onPressed.call();
        },
        icon: Icon(icon),
        color: Colors.white, // White icon color for contrast
      ),
    );
  }
}
