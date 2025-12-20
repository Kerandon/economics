import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get economicIntegrationSlides => [
  /// 'Definition & Types of Protection',
  Slide(
    subunit: Subunit.economicIntegration,
    title: kTermsGlossary,
    contents: [
      SlideContent.term(
        'Infant (Sunrise) Industry',
        'An industry in its early stages of development, less able to compete against established firms with greater economies of scale.',
      ),

      SlideContent.term(
        'Sunset Industry',
        'An industry that is past its peak and in long-term decline.',
      ),

      SlideContent.term(
        'Economic Diversification',
        'Developing a range of industries instead of relying on one or a few industries.',
      ),

      SlideContent.term(
        'Dumping',
        'Selling goods in a domestic market at a price below production cost, often to gain market share.',
      ),

      SlideContent.term(
        'Unfair Competition',
        'Policies or practices that give a country or firm an unfair advantage, e.g., dumping, subsidies, or artificial currency devaluation.',
      ),

      SlideContent.term(
        'Trading Bloc',
        'A group of countries that agree to reduce trade barriers between members and integrate economically.',
      ),

      SlideContent.term(
        'Free Trade Area (FTA)',
        'Member countries remove trade barriers among themselves but maintain independent external trade policies with non-members. Example: USMCA.',
      ),

      SlideContent.term(
        'Customs Union',
        'A free trade area with a common external tariff on non-members. Example: South African Customs Union (SACU).',
      ),

      SlideContent.term(
        'Common Market',
        'A customs union that also allows free movement of factors of production (labor and capital) between member countries. Example: European Union (EU).',
      ),

      SlideContent.term(
        'Monetary Union',
        'A common market that adopts a single currency, representing the highest level of economic integration. Example: The Eurozone.',
      ),

      SlideContent.term(
        'Trade Creation',
        'When trade shifts from less efficient producers to more efficient producers, leading to increased economic welfare.',
      ),

      SlideContent.term(
        'Trade Diversion',
        'When trade shifts from more efficient external producers to less efficient producers within a trade bloc due to the formation of a free trade area or customs union.',
      ),
      SlideContent.term(
        'European Union (EU)',
        'A membership of twenty-seven European countries representing the largest common market in the world.',
      ),

      SlideContent.term(
        'Eurozone',
        'Twenty EU countries that have adopted a single currency (euro €) and follow a common monetary policy.',
      ),

      SlideContent.term(
        'Convergence Costs',
        'The costs a country incurs to join a monetary union, including meeting strict entry criteria and updating systems and prices.',
      ),

      SlideContent.term(
        'Sovereignty',
        'The independence and freedom of a country to decide its own affairs.',
      ),

      SlideContent.term(
        'Monetary Sovereignty',
        'A country’s ability to control its own monetary policy.',
      ),

      SlideContent.term(
        'World Trade Organization (WTO)',
        'An intergovernmental organization that regulates and facilitates international trade.',
      ),
    ],
  ),
];
