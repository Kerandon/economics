import 'package:economics_app/home_page/data/get_slides.dart';
import 'package:flutter/material.dart';
import '../../diagrams/data/all_diagrams.dart';
import '../../diagrams/enums/unit_type.dart';
import '../models/custom_slide.dart';

List<CustomSlide> getSlides({
  required Size size,
  required ThemeData theme,
  dynamic key,
}) {
  final List<CustomSlide> allSlides = slides.toList();
  final List<CustomSlide> allSlidesPopulated = [];

  for (var slide in allSlides) {
    if (slide.contents?.isNotEmpty ?? false) {
      // Map over contents and add diagramBundles where needed
      final updatedContents = slide.contents!.map((content) {
        if (content.diagramBundleEnums?.isNotEmpty ?? false) {
          final diagramBundles = AllDiagrams(
            size: size,
            colorScheme: theme.colorScheme,
          ).getDiagramBundles(diagramBundleEnums: content.diagramBundleEnums);
          return content.copyWith(diagramBundles: diagramBundles.toList());
        }
        return content;
      }).toList();

      allSlidesPopulated.add(slide.copyWith(contents: updatedContents));
    } else {
      // If slide has no contents, just add as-is
      allSlidesPopulated.add(slide);
    }
  }

  if (key is UnitType) {
    return allSlidesPopulated.where((slide) => slide.section == key).toList();
  } else if (key is Subunit) {
    return allSlidesPopulated.where((slide) => slide.section == key).toList();
  }

  return [];
}
