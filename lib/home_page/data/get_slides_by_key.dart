import 'package:economics_app/home_page/data/get_slides.dart';
import '../../diagrams/enums/unit_type.dart';
import '../models/custom_slide.dart';

List<CustomSlide> getSlidesByKey(dynamic key) {
  final allSlides = slides.toList();
  if (key is UnitType) {
    return allSlides.where((slide) => slide.section == key).toList();
  }
  // If key is a Subunit, filter by that subunit
  else if (key is Subunit) {
    return allSlides.where((slide) => slide.section == key).toList();
  }

  // Add more type checks for UnitType or String if you want, e.g.:

  // If key type is not handled, return all slides or empty list
  return [];
}
