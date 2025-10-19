import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart' show SlideContent;

List<Slide> get roleOfGovernmentSlides => [
  Slide(
    section: Subunit.roleOfGovernment,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Command and Control',
        'refers to government laws and regulations which must be followed.',
      ),
      SlideContent.term(
        'Direct Provision',
        'is when the government supplies a good directly.',
      ),
      SlideContent.term(
        'Agricultural price floor',
        'is a minimum price (price floor) implemented to support farmer’s incomes.',
      ),
      SlideContent.term(
        'Deadweight Loss (Welfare Loss)',
        'represents social welfare lost to society due to the inefficient allocation of resources.',
      ),
      SlideContent.term(
        'Parallel Markets',
        'involve economic transactions which are unrecorded and unregulated and are usually illegal.',
      ),
      SlideContent.term(
        'Rent Control',
        'is a maximum price (price ceiling) on rent which aim to make housing more affordable for low income groups.',
      ),
      SlideContent.term(
        'Direct Tax',
        'is when taxpayers cannot shift the tax burden and must pay directly to the government. Examples include personal income tax and corporation tax.',
      ),
      SlideContent.term(
        'Indirect Tax',
        'is a tax on the spending on goods and services. The seller must pay the tax, but it usually passes part of the tax burden to consumers by raising prices. Examples include general sales taxes (value added taxes) and excise taxes.',
      ),
      SlideContent.term(
        'Specific Tax',
        'is a fixed amount added to each unit of a good sold.',
      ),
      SlideContent.term(
        'Ad Valorem Tax',
        'is a percentage tax based on the value of a good.',
      ),
      SlideContent.term(
        'Tax Incidence',
        'is the manner in which the tax burden is divided between consumers and producers.',
      ),
      SlideContent.term(
        'Subsidy',
        'is financial assistance from the government paid to producers to lower the cost of production and increase the supply of a good.',
      ),
    ],
  ),
];
