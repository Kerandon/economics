import 'package:flutter/material.dart';

class CustomSmallDivider extends StatelessWidget {
  const CustomSmallDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.20),
    );
  }
}
