// Combine them into one master list
import 'package:economics_app/home_page/pages/quick_notes/slides/global_slides.dart';
import 'package:economics_app/home_page/pages/quick_notes/slides/macro_slides.dart';
import 'package:economics_app/home_page/pages/quick_notes/slides/micro_slides.dart';

import '../../models/slide.dart';

final List<Slide> quickNotesSlides = [
  ...microSlides,
  ...macroSlides,
  ...globalSlides,
];
