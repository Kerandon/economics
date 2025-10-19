import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';

import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart';
import '../../models/term.dart';

List<Slide> get whatIsEconomicsSlides => [
  Slide(
    section: Subunit.whatIsEconomics,
    title: kKeyTerms,
    contents: [
      SlideContent.term(
        'Social Science',
        'employs the scientific method to study human behavior and human society.',
      ),
      SlideContent.term(
        'Economics',
        'is the study of how individuals and societies allocate scarce resources to meet unlimited wants and needs.',
      ),
      SlideContent.term(
        'Microeconomics',
        'is the study of individual behavior and markets. Including the topics of supply and demand, market failure and government intervention in markets.',
      ),
      SlideContent.term(
        'Macroeconomics',
        'is the study of the economy as a whole and the role of the government. Including the topics of inflation, economic growth and national employment.',
      ),
      SlideContent.term(
        'Scarcity',
        'refers to the fact that resources and goods and services are limited in supply.',
      ),

      SlideContent.term(
        'Efficiency',
        'refers to making the best use of resources to minimize waste and maximize social welfare.',
      ),

      SlideContent.term(
        'Equity',
        'is a normative concept concerning fairness and justice, particularly in the distribution of income and wealth in society.',
      ),

      SlideContent.term(
        'Sustainability',
        'refers to using scarce resources in a way which meets current wants and needs without degradation and depletion of resources for future generations.',
      ),

      SlideContent.term(
        'Economic well-being',
        'refers to the quality of life and economic satisfaction of individuals. Typical indicators include income, health, education and the environment.',
      ),

      SlideContent.term(
        'Intervention',
        'refers to government involvement in free markets to achieve certain objectives, such as correcting market failure and the redistribution of income.',
      ),

      SlideContent.term(
        'Interdependence',
        'refers to the mutual reliance of individuals, firms and governments, both within a society and between countries.',
      ),

      SlideContent.term(
        'Change',
        'refers to how societies must respond to evolving internal and external factors.',
      ),

      SlideContent.term(
        'Choice',
        'refers to how societies must make decisions to deal with the problem of scarcity.',
      ),
      SlideContent.term(
        'Economic Goods',
        'refer to goods which result in an opportunity cost to produce and consume. Due to their scarcity, they can command a price when sold.',
      ),
      SlideContent.term(
        'Free Goods',
        'refer to goods which have zero opportunity cost in their consumption. These goods are abundant and typically naturally occurring. Examples include, wind from the sea and sunlight.',
      ),
      SlideContent.term(
        'Opportunity Cost',
        'refers to the cost of a decision in terms of the value of the best alternative which is forgone.',
      ),
      SlideContent.term(
        'Geographic Mobility',
        'refers to how easily resources can be relocated to another geographic location. For example, a worker moving to another region to change their job.',
      ),
      SlideContent.term(
        'Occupational Mobility',
        'refers to how easily resources can switch between different uses in production. For example, a worker retrains for a new occupation, or a machine produces a different product.',
      ),
      SlideContent.term(
        'Rationing',
        'Is the process of allocating (apportioning) scarce goods and services in society.',
      ),
      SlideContent.term(
        'Private Sector',
        'Refers to part of the economy that is made up by private individuals and firms.',
      ),
      SlideContent.term(
        'Public Sector',
        'Refers to part of the economy that is controlled by the state (government).',
      ),
      SlideContent.term(
        'The Production Possibilities Curve (PPC)',
        'Is a model which shows the maximum combination of any two goods an economy can produce at any point in time, given current fixed resources. It demonstrates the concepts of choice, opportunity costs and scarcity.',
      ),
      SlideContent.term(
        'The Circular Flow of Income Model',
        ' Is a visual representation of economic activity, which shows the interdependence of different sectors in an economy and the flows of money, output and resources.',
      ),
      SlideContent.term(
        'Injection',
        'Represents money entering the economy, that expands economic activity. The three main injections are investment, government spending and export revenue.',
      ),
      SlideContent.term(
        'Leakages',
        'Represents money that leaves the economy, reducing economic activity. The three main leakages are savings, taxes and import expenditure.',
      ),
      SlideContent.term(
        'The Circular Economy',
        'Is a model that aims to eliminate waste and pollution, keep products and materials in use, and regenerate natural systems to ensure sustainability.',
      ),
    ],
  ),
  Slide(
    section: Subunit.whatIsEconomics,
    title: kKeyTerms,
    contents: [
      SlideContent(
        diagramBundleEnums: [
          DiagramBundleEnum.globalAbsoluteAdvantageBothGoods,
        ],
      ),
    ],
  ),
];
