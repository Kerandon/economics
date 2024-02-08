import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        return SizedBox(
            width: size.width,
            height: size.height,
            child: const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
