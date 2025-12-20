import 'package:economics_app/app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';

List<Slide> get benefitsOfInternationalTradeSlides => [
  Slide(
    subunit: Subunit.benefitsTrade,
    title: kTermsGlossary,
    contents: [
      SlideContent.term(
        'Autarky',
        'A country which is self-sufficient and does not engage in international trade (also known as a closed economy).',
      ),

      SlideContent.term(
        'International Trade',
        'The exchange of goods and services between countries across national borders.',
      ),

      SlideContent.term(
        'Free Trade',
        'International trade without government-imposed restrictions such as tariffs, quotas, or subsidies.',
      ),

      SlideContent.term(
        'International Specialization',
        'When a country concentrates its production on one or a few industries, often where it has a comparative advantage.',
      ),

      SlideContent.term(
        'Gains from Trade',
        'The economic benefits countries gain from engaging in international trade, including higher consumption possibilities, increased production efficiency, and greater social surplus.',
      ),

      SlideContent.term(
        'Balance of Payments (BOP)',
        'A financial record of a country’s transactions with the rest of the world over a year.',
      ),

      SlideContent.term(
        'Credit',
        'A payment received from other countries (inflow of funds), which increases demand for the domestic currency.',
      ),

      SlideContent.term(
        'Debit',
        'A payment made to other countries (outflow of funds), which increases the supply of the domestic currency.',
      ),

      SlideContent.term(
        'Trade Balance in Goods (Visible Trade)',
        'The trade in physical goods, such as commodities and merchandise.',
      ),

      SlideContent.term(
        'Trade Balance in Services (Invisible Trade)',
        'The trade in intangible services, including tourism, education, and insurance.',
      ),

      SlideContent.term(
        'Primary Income',
        'Net Factor Income earned from abroad (income earned abroad - income send abroad)',
      ),
      SlideContent.term(
        'Secondary Income (Current Transfers)',
        'Unilateral transfers with no exchange of goods or services, including foreign aid and remittances from migrant workers based overseas (12 months or more).',
      ),

      SlideContent.term(
        'Balance of Trade',
        'The value of net exports (X-M) in goods and services.',
      ),

      SlideContent.term(
        'Current Account Deficit',
        'Occurs when total debits exceed total credits, resulting in a net outflow of funds.',
      ),

      SlideContent.term(
        'Current Account Surplus',
        'Occurs when total credits exceed total debits, resulting in a net inflow of funds.',
      ),

      SlideContent.term(
        'Debtor Nation',
        'A country that borrows more from abroad than it lends or invests abroad.',
      ),

      SlideContent.term(
        'Creditor Nation',
        'A country that lends or invests more abroad than it borrows.',
      ),

      SlideContent.term(
        'Capital Flight',
        'Large-scale outflow of money and financial assets from a country, usually due to political or economic instability.',
      ),

      SlideContent.term(
        'Expenditure-Switching Policies',
        'Policies aimed at reducing a current account deficit by encouraging consumption of domestic goods over imports, through export promotion, trade protection, or currency devaluation.',
      ),

      SlideContent.term(
        'Expenditure-Reducing Policies',
        'Policies aimed at reducing a current account deficit by lowering national income and import demand through contractionary fiscal or monetary measures.',
      ),

      SlideContent.term(
        'Marshall-Lerner Condition',
        'A condition that determines whether currency depreciation or devaluation will improve the trade balance, depending on the price elasticities of exports and imports. If PEDx + PEDm > 1, depreciation improves the trade balance.',
      ),

      SlideContent.term(
        'J-Curve Effect',
        'The short-term effect of currency depreciation on the trade balance, where it initially worsens before improving over time as export and import volumes adjust, forming a "J" shape.',
      ),
    ],
  ),
];
