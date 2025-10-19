import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get exchangeRateSlides => [
  /// 'Definition & Types of Protection',
  Slide(
    section: Subunit.exchangeRates,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Currency',
        'A standardized form of money used as a medium of exchange.',
      ),

      SlideContent.term(
        'Fiat Currency',
        'Legal tender not backed by any tangible asset.',
      ),

      SlideContent.term(
        'Foreign Exchange Rate',
        'The value of one currency in terms of another currency.',
      ),

      SlideContent.term(
        'Foreign Exchange Market (Forex)',
        'A decentralized global marketplace where currencies are traded.',
      ),

      SlideContent.term(
        'Floating Exchange Rate',
        'A system in which a currency’s value is determined by market supply and demand without central bank intervention.',
      ),

      SlideContent.term(
        'Currency Appreciation',
        'An increase in the value of a currency relative to other currencies in a floating exchange rate system.',
      ),

      SlideContent.term(
        'Currency Depreciation',
        'A decrease in the value of a currency relative to other currencies in a floating exchange rate system.',
      ),

      SlideContent.term(
        'Fixed Exchange Rate',
        'An exchange rate pegged to another currency or basket of currencies, maintained by central bank intervention.',
      ),

      SlideContent.term(
        'Devaluation',
        'A reduction in a fixed exchange rate set by the government.',
      ),

      SlideContent.term(
        'Revaluation',
        'An increase in a fixed exchange rate set by the government.',
      ),

      SlideContent.term(
        'Speculators',
        'Investors who buy and sell currencies to profit from changes in exchange rates.',
      ),

      SlideContent.term(
        'Safe Haven Currencies',
        'Currencies trusted in times of crisis due to stability, e.g., USD \$, Pound £, Euro €.',
      ),

      SlideContent.term(
        'Official Foreign Reserves',
        'Foreign currencies, gold, and other assets held by a central bank to stabilize the exchange rate or support international payments.',
      ),

      SlideContent.term(
        'Managed Exchange Rate',
        'A system where the central bank intervenes in the foreign exchange market to maintain exchange rate stability, usually allowing a floating range.',
      ),

      SlideContent.term(
        'Undervalued Currency',
        'When a currency’s exchange rate is below its free-market equilibrium value.',
      ),

      SlideContent.term(
        'Overvalued Currency',
        'When a currency’s exchange rate is above its free-market equilibrium value.',
      ),

      SlideContent.term(
        'Dirty Float',
        'When a currency is deliberately undervalued through government intervention to improve export competitiveness.',
      ),
    ],
  ),
];
