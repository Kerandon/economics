import 'package:flutter/material.dart';

import '../configs/constants.dart';

class CustomHeading extends StatelessWidget {
  const CustomHeading(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.width * kDividerIndent),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
