import 'package:economics_app/diagrams/enums/unit_type.dart';
import 'package:economics_app/home_page/pages/notes_page/subunit_notes_page.dart';
import 'package:flutter/material.dart';
import '../../data/get_slides_by_key.dart';
import '../../models/slide.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = ThemeData();
    // 1. Group slides by Subunit
    final Map<Subunit, List<Slide>> slidesBySubunit = {};
    for (var slide in getSlides(size: size, theme: theme)) {
      slidesBySubunit.putIfAbsent(slide.subunit, () => []).add(slide);
    }

    // 2. Get the unique subunits that actually have slides
    final availableSubunits = slidesBySubunit.keys.toList();

   final s = slidesBySubunit.entries.first;
   print('s1 is ${s.value.elementAt(0).contents?.first.content?.text}');
    print('s2 is ${s.value.elementAt(0).contents?.elementAt(1).diagramWidgets?.first.painters.first}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('IB Economics Notes'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: availableSubunits.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // You can change this if the titles get too squished
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final subunit = availableSubunits[index];

          return Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                // Navigate to the detail page when clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubunitNotesPage(
                      subunit: subunit,
                      slides: slidesBySubunit[subunit]!,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    subunit.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}