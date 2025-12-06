import 'package:economics_app/home_page/pages/diagrams_display_web/all_diagrams_page_web.dart';
import 'package:economics_app/home_page/pages/terms_page.dart';
import 'package:flutter/material.dart';

import '../../diagrams/enums/diagram_bundle_enum.dart';

enum Resource { diagrams, terms }

extension ResourceExtension on Resource {
  String get title {
    switch (this) {
      case Resource.diagrams:
        return 'Diagrams';
      case Resource.terms:
        return 'Terms';
    }
  }

  String? get imageUrl {
    switch (this) {
      case Resource.diagrams:
        return null; // replace with your actual image path/ replace with your actual image path
      case Resource.terms:
        return 'assets/images/terms.jpg';
    }
  }

  DiagramEnum? get diagram {
    switch (this) {
      case Resource.diagrams:
        return DiagramEnum
            .microDemandExtension; // replace with your actual image path
      case Resource.terms:
        return null; // replace with your actual image path
    }
  }

  Widget get page {
    switch (this) {
      case Resource.diagrams:
        return AllDiagramsPageWeb();
      case Resource.terms:
        return TermsPage();
    }
  }
}
