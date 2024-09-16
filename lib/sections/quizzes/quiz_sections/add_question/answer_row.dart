import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class AnswerRow extends StatelessWidget {
  const AnswerRow({
    super.key,
    required this.controller,
    required this.index,
    this.hintText,
  });

  final TextEditingController controller;
  final int index;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: CustomTextField(
              controller: controller,
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
