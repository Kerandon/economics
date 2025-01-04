import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap({
    super.key,
    this.showDivider = false,
    this.color,
  });

  final bool showDivider;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.003),
      child: showDivider
          ? Divider(
              color: color ??
                  Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withAlpha(kBackgroundOpacity),
            )
          : null,
    );
  }
}
