import 'package:flutter/material.dart';

class CustomChipButton extends StatelessWidget {
  const CustomChipButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    this.icon,
    this.padding,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final IconData? icon;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: size.width * 0.01),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              backgroundColor:
                  isSelected ? Theme.of(context).colorScheme.primary : null,
              side: BorderSide(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.50),
              )),
          onPressed: onPressed,
          child: Row(
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
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.50),
                ),
              ),
            ],
          )),
    );
  }
}
