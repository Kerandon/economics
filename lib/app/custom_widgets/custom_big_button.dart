import 'package:flutter/material.dart';

import '../configs/constants.dart';

class CustomBigButton extends StatelessWidget {
  const CustomBigButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.60, // Minimum width of 70% of screen width
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: onPressed == null
              ? Theme.of(context).colorScheme.scrim
              : Theme.of(context).colorScheme.primary,
          side: BorderSide(
            color: onPressed == null
                ? Theme.of(context).colorScheme.shadow
                : Theme.of(context).colorScheme.primary,
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: onPressed == null
                        ? Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(kNotSelectedOpacity)
                        : Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
