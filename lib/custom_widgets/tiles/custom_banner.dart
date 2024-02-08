import 'package:flutter/material.dart';

import '../../configs/app_colors.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner(
    this.title, {
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: AppColors.defaultAppColorDarker),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
