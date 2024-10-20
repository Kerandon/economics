import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class CustomChipButton extends StatelessWidget {
  const CustomChipButton({
    this.text,
    required this.onPressed,
    this.textAndIconColor,
    this.icon,
    this.isSelected = true,
    this.isDisabled = false,
    this.fillColor,
    this.outlinedStyle = false,
    super.key,
  });

  final String? text;
  final IconData? icon;
  final Color? textAndIconColor;
  final Color? fillColor;
  final Function? onPressed;
  final bool isSelected;
  final bool isDisabled;
  final bool outlinedStyle;

  @override
  Widget build(BuildContext context) {
    final borderColor = isDisabled
        ? Colors.grey
        : textAndIconColor ?? Theme.of(context).colorScheme.primary;
    Color iconAndTextColor = Colors.white;
    if (isDisabled) {
      iconAndTextColor = Colors.grey;
    } else {
      if (outlinedStyle) {
        iconAndTextColor =
            textAndIconColor ?? Theme.of(context).colorScheme.primary;
      } else {
        if (isSelected) {
          iconAndTextColor = Colors.white;
        } else {
          iconAndTextColor = Theme.of(context).colorScheme.onSurface;
        }
      }
    }
    return Container(
      decoration: outlinedStyle
          ? BoxDecoration(
              border: Border.all(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(kRadius),
            )
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kRadius),
        child: Material(
          color: isDisabled && !outlinedStyle
              ? Theme.of(context).colorScheme.scrim
              : isSelected
                  ? outlinedStyle
                      ? null
                      : fillColor ?? Theme.of(context).colorScheme.primary
                  : Theme.of(context)
                      .colorScheme
                      .scrim
                      .withOpacity(kNotSelectedOpacity),
          child: InkWell(
            borderRadius: BorderRadius.circular(kRadius),
            onTap: isDisabled
                ? null
                : () {
                    onPressed?.call();
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(
                mainAxisSize:
                    MainAxisSize.min, // Shrinks the row to fit its children
                children: [
                  if (icon != null) ...[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        icon,
                        color: iconAndTextColor,
                      ),
                    ),
                  ],
                  if (text != null) ...[
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(text!,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: iconAndTextColor,
                                  )),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
