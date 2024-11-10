import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap({
    super.key,
    this.showDivider = false,
  });

  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.001),
      child: showDivider
          ? Divider(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(kBackgroundOpacity),
            )
          : null,
    );
  }
}
