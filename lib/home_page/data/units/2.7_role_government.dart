import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart' show SlideContent;

List<Slide> get roleOfGovernmentSlides => [
  Slide(
    subunit: Subunit.roleOfGovernment,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Ad Valorem Tax',
        'A percentage tax based on the value of the good.',
      ),
      SlideContent.term(
        'Agricultural price floor',
        'A minimum price set above the equilibrium price to support farmers’ incomes.',
      ),
      SlideContent.term(
        'Allocative Inefficiency',
        'Market failure that results in a socially undesirable level of output (MSB > MSC or MSB < MSC).',
      ),
      SlideContent.term(
        'Command and Control',
        'Government laws and regulations that must be followed.',
      ),
      SlideContent.term(
        'Deadweight Loss (Welfare Loss)',
        'The loss of total social welfare due to an inefficient allocation of resources.',
      ),
      SlideContent.term(
        'Direct Provision',
        'When the government directly supplies a good or service.',
      ),
      SlideContent.term(
        'Direct Tax',
        'A tax paid directly to the government by the taxpayer. The taxpayer cannot shift the tax burden, e.g., personal income tax, corporation tax.',
      ),
      SlideContent.term(
        'Governance',
        'The laws, processes, institutions, and exercise of authority used to manage resources.',
      ),
      SlideContent.term(
        'Indirect Tax',
        'A tax on spending on goods and services. The tax burden can be shifted, e.g., sales tax or excise tax.',
      ),
      SlideContent.term(
        'Market-based approach',
        'Policies to correct market failure by internalizing the costs or benefits of an externality into the market price, e.g., taxes, subsidies, tradable permits.',
      ),
      SlideContent.term(
        'Market failure',
        'An inefficient allocation of resources in a free market. Causes include externalities, common pool resources, public goods, and market power.',
      ),
      SlideContent.term(
        'National Minimum Wage',
        'A legally set minimum wage above the equilibrium level to increase earnings of low-income workers.',
      ),
      SlideContent.term(
        'Overallocation of resources',
        'When too many resources are allocated to the production of a good, causing allocative inefficiency (MSB < MSC).',
      ),
      SlideContent.term(
        'Parallel Markets',
        'Economic transactions that are unrecorded, unregulated, and often illegal.',
      ),
      SlideContent.term(
        'Price Ceiling',
        'A legal maximum price set below equilibrium to make essential goods more affordable for low-income consumers.',
      ),
      SlideContent.term(
        'Price Controls',
        'Government intervention in markets by imposing a minimum (price floor) or maximum (price ceiling) price.',
      ),
      SlideContent.term(
        'Price Floor',
        'A legally set minimum price above the market equilibrium, e.g., minimum wage, agricultural price floor.',
      ),
      SlideContent.term(
        'Rent Control',
        'A maximum price (price ceiling) on rent intended to make housing more affordable for low-income groups.',
      ),
      SlideContent.term(
        'Specific Tax',
        'A fixed amount of tax added per unit of a good sold.',
      ),
      SlideContent.term(
        'Subsidy',
        'Financial incentive from the government to producers to lower production costs and increase supply.',
      ),
      SlideContent.term(
        'Tax Incidence',
        'How the burden of a tax is shared between consumers and producers.',
      ),
      SlideContent.term(
        'Underallocation of resources',
        'When too few resources are allocated to the production of a good, causing allocative inefficiency (MSB > MSC).',
      ),
    ],
  ),
];
