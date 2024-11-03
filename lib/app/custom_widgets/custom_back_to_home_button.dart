
import 'package:flutter/material.dart';

class CustomBackIconButton extends StatelessWidget {
  const CustomBackIconButton(this.onPressed,{
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
       onPressed.call();
      },
      icon: const Icon(
        Icons.arrow_back_outlined,
        color: Colors.white,
      ),
    );
  }
}