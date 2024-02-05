
import 'package:economics_app/custom_widgets/images/display_image.dart';
import 'package:economics_app/models/topic_model.dart';
import 'package:economics_app/utils/helper_methods/string_extensions.dart';
import 'package:flutter/material.dart';

import '../../configs/constants.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.unit,
    required this.index,
    required this.unitsLength,
    required this.onTap,
    super.key,
  });

  final TopicModel unit;
  final int index;
  final int unitsLength;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final verticalPadding = size.height * 0.022;
    return Column(
      children: [
        if (index == 0) // Add padding only before the first tile
          Padding(padding: EdgeInsets.only(top: verticalPadding)),
        if (index > 0) // Add a condition to avoid divider above the first tile
          Divider(
            height: verticalPadding * 2,
            indent: size.width * kDividerIndent,
            endIndent: size.width * kDividerIndent,
          ),
        ListTile(
          onTap: onTap,
          leading: SizedBox(
            width: size.width * 0.22,
            child: DisplayImage(unit.title ?? ""),
          ),
          title: Text(
            '${unit.unit} ${unit.title!.capitalizeFirstLetter()}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        if (index == unitsLength - 1) // Add padding only after the last tile
          Padding(padding: EdgeInsets.only(bottom: verticalPadding)),
      ],
    );
  }
}
