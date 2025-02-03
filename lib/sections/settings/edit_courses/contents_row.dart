import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

class ContentsRow extends StatelessWidget {
  const ContentsRow({
    super.key,
    required this.unit,
    required this.textEditingController,
    this.isSubunit = false,
  });

  final bool isSubunit;
  final String unit;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            unit,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        Expanded(
          flex: 8,
          child: TextFormField(
            decoration: InputDecoration(
              fillColor: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withAlpha(kBackgroundAlphaLight),
              filled: true,
              isDense: true,
              hintText:
                  isSubunit == true ? 'Enter subunit name' : 'Enter unit name',
              hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.grey,
                  ), // Grey hint text
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadius), // Rounded edges
                borderSide: BorderSide.none, // No border initially
              ),
            ),
            controller: textEditingController,
            onChanged: (value) {
              // Trigger rebuild to update errorText based on input
              (context as Element).markNeedsBuild();
            },
            style: Theme.of(context).textTheme.titleLarge, // Text color
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
      ],
    );
  }
}
