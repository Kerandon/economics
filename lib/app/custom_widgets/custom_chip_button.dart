import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class CustomChipButton extends StatelessWidget {
  const CustomChipButton({
    this.text,
    required this.onPressed,
    this.textColor,
    this.icon,
    this.isSelected = true,
    this.isDisabled = false,
    super.key,
  });

  final String? text;
  final Icon? icon;
  final Color? textColor;
  final Function? onPressed;
  final bool isSelected;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kRadius),
      child: Material(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context)
                .colorScheme
                .onSurface
                .withOpacity(kBackgroundOpacity),
        child: InkWell(
          borderRadius: BorderRadius.circular(kRadius),
          onTap: isDisabled
              ? null
              : () {
                  onPressed?.call();
                },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize:
                  MainAxisSize.min, // Shrinks the row to fit its children
              children: [
                if (icon != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: icon,
                  ),
                ],
                if (text != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text!,
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor ??
                            (isSelected
                                ? Colors.white
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.50)),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
