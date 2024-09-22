import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class CustomPageChangeButton extends StatelessWidget {
  const CustomPageChangeButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    this.disable = false,
  });

  final VoidCallback onPressed;
  final IconData iconData;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: disable
          ? Theme.of(context).colorScheme.scrim
          : Theme.of(context).floatingActionButtonTheme.backgroundColor,
      heroTag: null,
      onPressed: disable ? null : onPressed,
      child: Icon(iconData,
      color: disable ? Theme.of(context).colorScheme.surfaceDim :
      Theme.of(context).floatingActionButtonTheme.foregroundColor
      ),
    );
  }
}
