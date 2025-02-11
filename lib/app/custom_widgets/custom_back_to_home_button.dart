import 'package:flutter/material.dart';

class CustomBackIconButton extends StatelessWidget {
  const CustomBackIconButton(
    this.navigateToWidget, {
    super.key,
  });

  final Widget navigateToWidget;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => navigateToWidget));
      },
      icon: const Icon(
        Icons.arrow_back_outlined,
      ),
    );
  }
}
