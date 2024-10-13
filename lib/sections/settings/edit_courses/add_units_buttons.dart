import 'package:flutter/material.dart';

import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_chip_button.dart';

class AddUnitsButtons extends StatelessWidget {
  const AddUnitsButtons({
    super.key,
    required this.onAdd,
    required this.onRemove,
    this.disableOnRemove = false,
    required this.label,
  });

  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool disableOnRemove;
  final String label;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Wrap(
      spacing: size.width * kWrapSpacing,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(label),
        CustomChipButton(
            outlinedStyle: true,
            icon: Icons.add,
            onPressed: () {
              onAdd.call();
            }),
        CustomChipButton(
            outlinedStyle: true,
            isDisabled: disableOnRemove,
            icon: Icons.remove,
            onPressed: () {
              onRemove.call();
            }),
      ],
    );
  }
}
