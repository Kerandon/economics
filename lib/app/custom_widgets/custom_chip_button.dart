import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class CustomChipButton extends StatelessWidget {
  const CustomChipButton({
    this.label,
    this.textSize,
    required this.onTap,
    this.textAndIconColor,
    this.icon,
    this.selected = true,
    this.isDisabled = false,
    this.fillColor,
    this.outlinedStyle = false,
    super.key,
  });

  final String? label;
  final double? textSize;
  final IconData? icon;
  final Color? textAndIconColor;
  final Color? fillColor;
  final Function? onTap;
  final bool selected;
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
        if (selected) {
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
              : selected
                  ? outlinedStyle
                      ? null
                      : fillColor ?? Theme.of(context).colorScheme.primary
                  : Theme.of(context)
                      .colorScheme
                      .scrim
                      .withAlpha(kBackgroundAlphaLight),
          child: InkWell(
            borderRadius: BorderRadius.circular(kRadius),
            onTap: isDisabled
                ? null
                : () {
                    onTap?.call();
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize:
                    MainAxisSize.min, // Shrinks the row to fit its children
                children: [
                  if (icon != null) ...[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        icon,
                        color: iconAndTextColor,
                      ),
                    ),
                  ],
                  if (label != null) ...[
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(label!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: iconAndTextColor,
                                  fontSize: textSize ?? 16)),
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
