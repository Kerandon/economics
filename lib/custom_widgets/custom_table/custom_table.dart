import 'package:economics_app/utils/helper_methods/string_extensions.dart';
import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  const CustomTable(this.data,
      {this.useBulletPoints = false, super.key, required});

  final Map<String, String> data;
  final bool useBulletPoints;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Table(
        border:
            TableBorder.all(color: Theme.of(context).colorScheme.surfaceTint),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          0: FractionColumnWidth(useBulletPoints ? 0.10 : 0.40),
          1: const FlexColumnWidth()
        },
        children: data.entries
            .map(
              (e) => buildTableRow(context, size, MapEntry(e.key, e.value),
                  useBulletPoints: useBulletPoints),
            )
            .toList());
  }

  TableRow buildTableRow(
      BuildContext context, Size size, MapEntry<String, String> row,
      {bool useBulletPoints = false}) {
    final verticalPadding = size.height * 0.01;
    final horizontalPadding = size.width * 0.02;
    final edgeInsets = EdgeInsets.symmetric(
        vertical: verticalPadding, horizontal: horizontalPadding);

    return TableRow(
      children: [
        TableCell(
          verticalAlignment: useBulletPoints
              ? TableCellVerticalAlignment.middle
              : TableCellVerticalAlignment.top,
          child: Padding(
            padding: edgeInsets,
            child: useBulletPoints
                ? Icon(
                    Icons.fiber_manual_record,
                    size: size.height * 0.008,
                  )
                : Text(
                    row.key.capitalizeFirstLetter(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.top,
          child: Padding(
            padding: edgeInsets,
            child: Text(row.value.capitalizeFirstLetter()),
          ),
        ),
      ],
    );
  }
}
