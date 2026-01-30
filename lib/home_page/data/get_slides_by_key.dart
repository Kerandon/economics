import 'package:flutter/material.dart';
import '../../diagrams/data/all_diagrams.dart';
import '../../diagrams/enums/unit_type.dart';
import '../models/slide.dart';
import 'get_all_slides.dart';

List<Slide> getSlides({
  required Size size,
  required ThemeData theme,
  dynamic key,
}) {
  final List<Slide> all = allSlides.toList();
  final List<Slide> allSlidesPopulated = [];

  for (var slide in all) {
    if (slide.contents?.isNotEmpty ?? false) {
      // Map over contents and add diagramBundles where needed
      final updatedContents = slide.contents!.map((content) {
        if (content.diagramEnums?.isNotEmpty ?? false) {
          final diagramWidgets = AllDiagrams(
            size: size,
            colorScheme: theme.colorScheme,
          ).getDiagramWidgets(diagrams: content.diagramEnums);
          //  return content.copyWith(diagramWidgets: diagramWidgets.toList());
        }

        return content;
      }).toList();

      allSlidesPopulated.add(slide.copyWith(contents: updatedContents));
    } else {
      allSlidesPopulated.add(slide);
    }
  }

  if (key is UnitType || key is Subunit) {
    return allSlidesPopulated.where((slide) => slide.subunit == key).toList();
  }

  // If no key is provided, return all slides
  return allSlidesPopulated;
}
