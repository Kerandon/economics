import 'package:flutter/material.dart';

import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_chip_button.dart';

class AddUnitsButtons extends StatelessWidget {
  const AddUnitsButtons(
      {super.key,
      required this.onAdd,
      required this.onRemove,
      this.disableOnRemove = false});

  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool disableOnRemove;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Wrap(
      spacing: size.width * kWrapSpacing,
      alignment: WrapAlignment.start,
      children: [
        CustomChipButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              onAdd.call();
            }),
        CustomChipButton(
            isDisabled: disableOnRemove,
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () {
              onRemove.call();
            }),
      ],
    );
  }
}
