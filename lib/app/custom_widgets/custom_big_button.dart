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
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * kDividerIndent,
          horizontal: size.width * 0.15),
      child: SizedBox(
        width: size.width,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: onPressed == null
                ? Theme.of(context).colorScheme.onSecondary.withOpacity(kBackgroundOpacity)
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
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: onPressed == null
                    ? Theme.of(context).colorScheme.onBackground.withOpacity(kNotSelectedOpacity)
                    : Colors.white,
              ),
            ),
          ),
        ),

      ),
    );
  }
}
