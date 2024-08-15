import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class CustomChipButton extends StatelessWidget {
  const CustomChipButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    this.icon,
    this.padding,
    this.leading,
    this.removeShadingOfText = false,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final IconData? icon;
  final EdgeInsets? padding;
  final Widget? leading;
  final bool removeShadingOfText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: size.width * 0.01),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(kBackgroundOpacity),
          side: BorderSide.none,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (icon != null) ...[
              Padding(
                padding: EdgeInsets.only(right: size.width * 0.01),
                child: Icon(
                  icon,
                  size: 15,
                ),
              ),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: isSelected || removeShadingOfText
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.50),
              ),
            ),
            if (leading != null) leading!
          ],
        ),
      ),
    );
  }
}
