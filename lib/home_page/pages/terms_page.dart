import 'package:economics_app/diagrams/enums/unit_type.dart';
import 'package:economics_app/home_page/data/get_slides_by_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/configs/constants.dart';
import '../models/term.dart';

class TermsPage extends ConsumerWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final slides = getSlides(size: size, theme: theme);

    // Collect terms by subunit
    final Map<Subunit, List<Term>> termsBySubunit = {};
    for (var s in slides) {
      if (s.contents?.isNotEmpty ?? false) {
        for (var c in s.contents!.toList()) {
          if (c.term != null && s.section is Subunit) {
            final subunit = s.section as Subunit;
            termsBySubunit.putIfAbsent(subunit, () => []).add(c.term!);
          }
        }
      }
    }

    // Group subunits by unit
    final Map<UnitType, List<Subunit>> units = {};
    for (var subunit in Subunit.values) {
      units.putIfAbsent(subunit.unit, () => []).add(subunit);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Key Terms')),
      body: ListView(
        children: [
          for (var unit in UnitType.values)
            ExpansionTile(
              title: Text(unit.title, style: theme.textTheme.titleLarge),
              children: [
                for (var subunit in units[unit]!)
                  if (termsBySubunit[subunit]?.isNotEmpty ?? false)
                    ExpansionTile(
                      title: Text(subunit.title),
                      children: [
                        for (var term in termsBySubunit[subunit]!)
                          Container(
                            color: term.hl == true
                                ? theme.primaryColorDark
                                : theme.primaryColor,
                            child: ExpansionTile(
                              textColor: Colors.white,
                              title: HtmlWidget(
                                '${term.term} ${term.hl == true ? '<strong>(HL)</strong>' : ''}',
                              ),
                              children: [
                                Container(
                                  color: theme.colorScheme.surface,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        size.width * kPageIndentHorizontal,
                                    vertical: size.height * kPageIndentVertical,
                                  ),
                                  child: Text(term.explanation),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
              ],
            ),
        ],
      ),
    );
  }
}
