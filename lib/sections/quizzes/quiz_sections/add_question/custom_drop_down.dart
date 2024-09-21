import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/state/app_state.dart';

class CustomDropDown<T> extends ConsumerWidget {
  const CustomDropDown({
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);
    final isDarkTheme = appState.isDarkTheme; // Detect if dark theme is enabled
    bool isDisabled = items.isEmpty;

// Colors for light and dark themes
    Color? backgroundColor = isDisabled ? Colors.grey.shade200 : Colors.white;
    Color? dropdownColor = Colors.white;
    Color? iconColor = isDisabled ? Colors.grey.shade200 : Colors.black;
    Color textColor = Colors.black;

    if(isDarkTheme){
      backgroundColor = isDisabled ? Colors.black54 : dropdownColor = Colors.grey[900];
        dropdownColor = Colors.grey[900]; // Dark dropdown color
        iconColor = isDisabled ? Colors.black54 : Colors.white;
        textColor = Colors.white;

    }


    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // Set background color based on theme and selection
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
            fillColor: backgroundColor, // Set fill color based on theme and selection
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
          dropdownColor: dropdownColor, // Set dropdown color based on theme
          icon: Icon(
            Icons.arrow_drop_down,
            color: iconColor, // Set icon color based on theme
          ),
          style: TextStyle(
            color: textColor, // Set text color based on theme
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
