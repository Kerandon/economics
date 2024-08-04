import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class CustomChipButton extends StatelessWidget {
  const CustomChipButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    this.icon,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal:
        size.width * kPageIndentHorizontal),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(8),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal:
                size.width * 0.03, vertical: size.height * 0.005),
                child: Icon(icon, size: 15,),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface.withOpacity(0.50),
                ),
              ),
            ],
          )),
    );
  }
}
