import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    this.hintText,
    super.key,
  });

  final TextEditingController controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(kRadius),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Stack(
        children: [
          TextFormField(
            controller: controller,
            maxLines: 3,
            minLines: 1,
            maxLength: 500,
            // Allows the textbox to expand for multiple lines
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none, // No visible border
            ),
            style: TextStyle(
              fontSize: 16,
              // Adjust to match the appearance of ChatGPT's text box
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Align(
            alignment: const Alignment(1.0, 0.50),
            child: IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: const Icon(Icons.clear_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
