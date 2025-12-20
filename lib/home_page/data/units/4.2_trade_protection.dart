import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';

import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get typesOfTradeProtectionSlides => [
  /// 'Definition & Types of Protection',
  Slide(
    subunit: Subunit.typesTradeProtection,
    title: kTermsGlossary,
    contents: [
      SlideContent.term(
        'Trade Protectionism',
        'Government policies that restrict international trade to protect domestic industries from foreign competition.',
      ),

      SlideContent.term(
        'World Supply',
        'The sum of all countries’ supply of a particular good or service.',
      ),

      SlideContent.term(
        'World Demand',
        'The sum of all countries’ demand for a particular good or service.',
      ),

      SlideContent.term(
        'Absolute Advantage',
        'When a country can produce more of a good using the same quantity of resources as another country.',
      ),

      SlideContent.term(
        'Comparative Advantage',
        'When a country can produce a good at a lower opportunity cost than its trading partner, allowing all countries to gain from trade if they specialize accordingly.',
      ),

      SlideContent.term(
        'Overspecialization',
        'When a country becomes too dependent on producing a single commodity or good, increasing its vulnerability to shocks.',
      ),

      SlideContent.term(
        'Factor Endowments',
        'The resources a country possesses, such as land, labor, capital, and natural resources, which determine its production capacity.',
      ),

      SlideContent.term(
        'Tariff',
        'A tax on imported goods imposed by a government, aimed at protecting domestic industries and/or raising revenue.',
      ),

      SlideContent.term(
        'Import Quota',
        'A legal limit on the quantity of a good that can be imported, usually over a year.',
      ),

      SlideContent.term(
        'Production Subsidy',
        'A government payment made to domestic producers per unit of output to help them compete with imported goods.',
      ),

      SlideContent.term(
        'Export Subsidy',
        'A government payment to domestic producers per unit of exported goods to improve international competitiveness.',
      ),

      SlideContent.term(
        'Administrative Barriers',
        'Non-tariff measures that make it harder for foreign firms to export goods, e.g., strict health and safety checks, product testing, or slow customs processing.',
      ),

      SlideContent.term(
        'Embargo',
        'A government-imposed official ban on trade, either for specific goods or with an entire country, usually for economic, political, or security reasons.',
      ),
    ],
  ),
];
