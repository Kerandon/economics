import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomDropDown<T> extends ConsumerWidget {
  const CustomDropDown({
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final T? value; // Specify the type for value
  final List<DropdownMenuItem<T>> items; // Specify the type for items
  final Function(T?)? onChanged; // Specify the type for the onChanged callback

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine if dropdown is disabled (i.e., if items are empty)
    bool isDisabled = items.isEmpty;

    return Container(
      decoration: BoxDecoration(
        color: isDisabled ? Colors.grey[300] : Colors.white, // Greyed-out if disabled
        borderRadius: BorderRadius.circular(12.0),
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
        child: DropdownButtonFormField<T>(
          value: isDisabled ? null : value,
          items: isDisabled ? null : items, // Use null when disabled
          onChanged: isDisabled ? null : onChanged, // Disable onChanged if disabled
          decoration: InputDecoration(
            filled: true,
            fillColor: isDisabled ? Colors.grey[300] : Colors.white, // Greyed-out if disabled
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
          ),
          dropdownColor: isDisabled ? Colors.grey[300] : Colors.white, // Grey dropdown if disabled
          icon: Icon(
            Icons.arrow_drop_down,
            color: isDisabled ? Colors.grey : Colors.black, // Grey arrow icon if disabled
          ),
          style: TextStyle(
            color: isDisabled ? Colors.grey : Colors.black, // Grey text if disabled
            fontSize: 16,
          ),
          isExpanded: true,
          menuMaxHeight: 300,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
