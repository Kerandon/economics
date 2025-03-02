
import 'package:flutter/material.dart';

class CustomDropdownHeading extends StatelessWidget {
  const CustomDropdownHeading(
      this.text, {
        super.key,
      });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.left,
            ),
          ),
          const Icon(Icons.arrow_drop_down, size: 24),
        ],
      ),
    );
  }
}
