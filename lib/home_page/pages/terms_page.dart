import 'package:economics_app/diagrams/enums/unit_type.dart';
import 'package:economics_app/home_page/data/get_slides_by_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../methods/generate_pdf_and_save.dart';
import '../models/term.dart';
import '../../app/configs/constants.dart';

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
          if (c.term != null && s.subunit is Subunit) {
            final subunit = s.subunit as Subunit;
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
      appBar: AppBar(title: const Text('IB Economics Key Terms')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900), // ✅ limit width
          child: ListView(
            children: [
              // 🚀 PDF Download Button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () async {
                    await generatePdfAndSave(context, units, termsBySubunit);
                  },
                  icon: const Icon(
                    Icons.picture_as_pdf_outlined,
                    size: 30,
                    color: Colors.red,
                  ),
                  tooltip: 'Download Terms as PDF',
                ),
              ),
              // ------------------------------------------------------------------
              // Terms Display
              // ------------------------------------------------------------------
              // Terms Display (Updated)
              for (var unit in UnitType.values)
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(unit.title, style: theme.textTheme.titleLarge),
                  children: [
                    for (var subunit in units[unit]!)
                      if (termsBySubunit[subunit]?.isNotEmpty ?? false)
                        ExpansionTile(
                          initiallyExpanded: true,
                          title: Text('${subunit.id} ${subunit.title}'),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var term in termsBySubunit[subunit]!)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4.0,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "• ",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                style:
                                                    theme.textTheme.bodyMedium,
                                                children: [
                                                  TextSpan(
                                                    text: term.term,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  if (term.tag == Tag.hl)
                                                    const TextSpan(
                                                      text: ' (HL)',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  if (term.tag ==
                                                      Tag.supplement)
                                                    const TextSpan(
                                                      text: ' (Supplement)',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  const TextSpan(text: '\n'),
                                                  TextSpan(
                                                    text: term.explanation,
                                                    style: theme
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
        ),
      ),
    );
  }
}
