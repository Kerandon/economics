import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class CustomSmallDivider extends StatelessWidget {
  const CustomSmallDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Divider(
      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.20),
    );
  }
}
