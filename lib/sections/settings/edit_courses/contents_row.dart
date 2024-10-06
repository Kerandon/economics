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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            unit,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText:
                  isSubunit == true ? 'Enter subunit name' : 'Enter unit name',
            ),
            controller: textEditingController,
            //
          ),
        )
      ],
    );
  }
}
