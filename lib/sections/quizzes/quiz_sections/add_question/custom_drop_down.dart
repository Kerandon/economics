import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomDropDown extends ConsumerWidget {
  const CustomDropDown({
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final dynamic value;
  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        // Rounded corners for the dropdown button
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          value: value,
          items: items,
          onChanged: (e) {
            onChanged.call(e);
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              // Rounded edges for the button
              borderSide: const BorderSide(
                  color: Colors.transparent), // No visible border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
          ),
          dropdownColor: Colors.white,
          // Background color for the dropdown menu
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          // Arrow icon color
          style: const TextStyle(color: Colors.black, fontSize: 16),
          // Text style
          isExpanded: true,
          menuMaxHeight: 300,
          // Max height for dropdown menu
          borderRadius: BorderRadius.circular(
              12.0), // Rounded corners for the dropdown menu
        ),
      ),
    );
  }
}
