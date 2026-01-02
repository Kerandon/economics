import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SimpleTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> data;
  final String? title;
  final String? figCaption;
  final List<TextStyle?>? headerStyles;
  final TextStyle defaultHeaderStyle;
  final TextStyle defaultCellStyle;

  final String? topLabel;
  final String? bottomLabel;
  final String? leftLabel;
  final String? rightLabel;
  final double cellPadding;

  final Color labelBackgroundColor;
  final Color labelTextColor;

  const SimpleTable({
    super.key,
    required this.headers,
    required this.data,
    this.title,
    this.figCaption,
    this.headerStyles,
    this.topLabel,
    this.bottomLabel,
    this.leftLabel,
    this.rightLabel,
    this.cellPadding = 18.0,
    this.labelBackgroundColor = Colors.transparent,
    this.labelTextColor = Colors.black,
    this.defaultHeaderStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    this.defaultCellStyle = const TextStyle(fontSize: 14),
  });

  Widget _buildOuterLabel(String text, {bool isGhost = false}) {
    return Visibility(
      visible: !isGhost,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: labelBackgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: HtmlWidget(
          '<div style="text-align: center; color: #${labelTextColor.value.toRadixString(16).substring(2).padLeft(6, '0')};">'
              '<strong>${text.toUpperCase()}</strong></div>',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final headerRow = TableRow(
      decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
      children: headers.map((h) => Padding(
        padding: EdgeInsets.all(cellPadding),
        child: Center(child: HtmlWidget(h, textStyle: defaultHeaderStyle)),
      )).toList(),
    );

    final dataRows = data.map((row) => TableRow(
      children: row.map((cell) => Padding(
        padding: EdgeInsets.all(cellPadding),
        child: Center(child: HtmlWidget(cell, textStyle: defaultCellStyle)),
      )).toList(),
    )).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

        Center(
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // TOP LABEL
                if (topLabel != null)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (leftLabel != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          // FIX: Use "I" instead of leftLabel! to prevent vertical height blowout
                          child: RotatedBox(quarterTurns: 3, child: _buildOuterLabel("I", isGhost: true)),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: _buildOuterLabel(topLabel!),
                        ),
                      ),
                      if (rightLabel != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          // FIX: Use "I" here as well
                          child: RotatedBox(quarterTurns: 1, child: _buildOuterLabel("I", isGhost: true)),
                        ),
                    ],
                  ),

                IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (leftLabel != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Center(child: RotatedBox(quarterTurns: 3, child: _buildOuterLabel(leftLabel!))),
                        ),

                      Table(
                        defaultColumnWidth: const IntrinsicColumnWidth(),
                        border: TableBorder.all(color: Colors.black, width: 2.0),
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [headerRow, ...dataRows],
                      ),

                      if (rightLabel != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Center(child: RotatedBox(quarterTurns: 1, child: _buildOuterLabel(rightLabel!))),
                        ),
                    ],
                  ),
                ),

                // BOTTOM LABEL
                if (bottomLabel != null)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (leftLabel != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          // FIX: Use "I" for ghost
                          child: RotatedBox(quarterTurns: 3, child: _buildOuterLabel("I", isGhost: true)),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: _buildOuterLabel(bottomLabel!),
                        ),
                      ),
                      if (rightLabel != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          // FIX: Use "I" for ghost
                          child: RotatedBox(quarterTurns: 1, child: _buildOuterLabel("I", isGhost: true)),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),

        if (figCaption != null)
          Padding(padding: const EdgeInsets.only(top: 15, left: 8), child: HtmlWidget(figCaption!)),
      ],
    );
  }
}