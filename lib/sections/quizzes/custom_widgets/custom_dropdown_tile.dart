
import 'package:flutter/material.dart';

class CustomDropdownTile extends StatelessWidget {
  const CustomDropdownTile({
    super.key,
    required this.text,
    this.isSelected,

    this.leading,
  });
  final String text;
  final bool? isSelected;
  final String? leading;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: isSelected == true ? Theme.of(context).colorScheme.primary.withAlpha(155) : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            if (leading != null) ...[
              Expanded(
                flex: 1,
                child: Text(
                  leading!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            Expanded(
              flex:5,
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
           if(isSelected != null)...[ if (isSelected!) ...[
              const Icon(Icons.check_box_outlined)
            ] else ...[
              const Icon(Icons.check_box_outline_blank),
            ]
          ],],
        ),
      ),
    );
  }
}
