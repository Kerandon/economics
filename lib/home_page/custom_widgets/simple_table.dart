import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

/// A reusable Flutter widget to build a styled table with an optional title and caption.
class SimpleTable extends StatelessWidget {
  /// A list of strings for the table headers.
  final List<String> headers;

  /// A list of lists of strings for the table data.
  /// Each inner list represents a row.
  final List<List<String>> data;

  /// An optional title for the table, aligned top-center.
  final String? title;

  /// An optional figure caption for the table, aligned bottom-left.
  final String? figCaption;

  /// Optional list of text styles for each header cell.
  /// If null or shorter than headers, defaults will be used.
  final List<TextStyle?>? headerStyles;

  /// Optional matrix of text styles for each data cell.
  /// Each row should match the data row in length.
  final List<List<TextStyle?>>? cellStyles;

  /// Default style for headers if headerStyles is not provided.
  final TextStyle defaultHeaderStyle;

  /// Default style for data cells if cellStyles is not provided.
  final TextStyle defaultCellStyle;

  const SimpleTable({
    super.key,
    required this.headers,
    required this.data,
    this.title,
    this.figCaption,
    this.headerStyles,
    this.cellStyles,
    this.defaultHeaderStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    this.defaultCellStyle = const TextStyle(fontSize: 14),
  });

  @override
  Widget build(BuildContext context) {
    // Header Row
    final headerRow = TableRow(
      decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
      children: List.generate(headers.length, (i) {
        final style = (headerStyles != null && i < headerStyles!.length)
            ? (headerStyles![i] ?? defaultHeaderStyle)
            : defaultHeaderStyle;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: HtmlWidget(headers[i], textStyle: style),
        );
      }),
    );

    // Data Rows
    final dataRows = List<TableRow>.generate(data.length, (rowIndex) {
      return TableRow(
        children: List.generate(data[rowIndex].length, (colIndex) {
          final style =
              (cellStyles != null &&
                  rowIndex < cellStyles!.length &&
                  colIndex < cellStyles![rowIndex].length)
              ? (cellStyles![rowIndex][colIndex] ?? defaultCellStyle)
              : defaultCellStyle;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data[rowIndex][colIndex],
              textAlign: TextAlign.center,
              style: style,
            ),
          );
        }),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Text(
            title!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        const SizedBox(height: 10),
        Center(
          child: Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            border: TableBorder.all(color: Colors.black, width: 2.0),
            children: [headerRow, ...dataRows],
          ),
        ),
        const SizedBox(height: 5),
        if (figCaption != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: HtmlWidget(figCaption ?? ''),
            ),
          ),
      ],
    );
  }
}
