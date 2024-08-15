import 'package:economics_app/sections/notes/models/unit_model.dart';

import '../../../app/enums/sections.dart';

Map<Section, Map<UnitModel, List<UnitModel>>> unitsContents = {
  Section.intro: {
    UnitModel(
      id: '1.1',
      unit: 'What is economics?',
    ): [
      UnitModel(
        id: '01',
        unit: 'Factors of production',
      ),
      UnitModel(
        id: '02',
        unit: 'Opportunity cost',
      ),
      UnitModel(
        id: '03',
        unit: 'Nine economic concepts',
      ),
      UnitModel(
        id: '04',
        unit: 'Three basic economic questions',
      ),
      UnitModel(
        id: '05',
        unit: 'Production possibilities curve (PPC)',
      ),
      UnitModel(
        id: '06',
        unit: 'Circular flow of income model',
      ),
      UnitModel(
        id: '07',
        unit: 'Nine economic concepts',
      ),
    ],
    UnitModel(
      id: '1.2',
      unit: 'How do economists approach the world?',
    ): [
      UnitModel(
        id: '01',
        unit: 'Economic methodology',
      ),
      UnitModel(
        id: '02',
        unit: 'History of economic thought',
      ),
    ]
  },
  Section.micro: {},
  Section.macro: {
    UnitModel(
      id: '3.1',
      unit: 'Measuring economic activity and illustrating its variations',
    ): [
      UnitModel(
        id: '3.1a',
        unit: 'Measuring national income: GDP & GNI',
      ),
      UnitModel(
        id: '3.1b',
        unit: 'Purchasing power parities (PPP)',
      ),
      UnitModel(
        id: '3.1c',
        unit: 'The business cycle',
      ),
      UnitModel(
        id: '04',
        unit: 'Alternative measures of well-being',
      ),
    ],
    UnitModel(
        id: '3.2',
        unit:
            'Variations in economic activity—aggregate demand and aggregate supply'): [
      UnitModel(
        id: '01',
        unit: 'Aggregate demand',
      ),
      UnitModel(
        id: '02',
        unit: 'Aggregate supply',
      ),
      UnitModel(
        id: '03',
        unit: 'Alternative view: Keynesian view',
      ),
      UnitModel(
        id: '04',
        unit: 'Inflationary & deflationary gaps',
      ),
      UnitModel(
        id: '05',
        unit: 'Increases in long-run aggregate supply (LRAS)',
      ),
    ],
    UnitModel(
      id: '3.3',
      unit: 'Macroeconomic objectives',
    ): [
      UnitModel(
        id: '01',
        unit: 'Economic growth',
      ),
      UnitModel(
        id: '02',
        unit: 'Low unemployment',
      ),
      UnitModel(
        id: '03',
        unit: 'Low and stable rate of inflation',
      ),
      UnitModel(id: '04', unit: 'The Phillips curve', hlOnly: true),
    ],
    UnitModel(
      id: '3.4',
      unit: 'Economics of inequality and poverty',
    ): [
      UnitModel(
        id: '01',
        unit: 'Equality and equity',
      ),
      UnitModel(
        id: '02',
        unit: 'Economic inequality',
      ),
      UnitModel(
        id: '03',
        unit: 'Lorenz curve and Gini coefficient (index)',
      ),
      UnitModel(
        id: '04',
        unit: 'Measuring poverty',
      ),
      UnitModel(
        id: '05',
        unit: 'Policies to reduce poverty, income and wealth inequality',
      ),
    ],
    UnitModel(
      id: '3.5',
      unit: 'Demand-side policies—monetary policy',
    ): [
      UnitModel(
        id: '01',
        unit: 'Goals of monetary policy',
      ),
      UnitModel(
        id: '02',
        unit: 'Fractional reserve banking / credit creation',
        hlOnly: true,
      ),
      UnitModel(
        id: '03',
        unit: 'Tools of monetary policy',
        hlOnly: true,
      ),
      UnitModel(
        id: '04',
        unit: 'Determination of equilibrium interest rates',
      ),
      UnitModel(
        id: '05',
        unit: 'Effectiveness of monetary policy',
      ),
    ],
    UnitModel(
      id: '3.6',
      unit: 'Demand-side policies—fiscal policy',
    ): [
      UnitModel(
        id: '01',
        unit: 'Goals of fiscal policy',
      ),
      UnitModel(
        id: '02',
        unit: 'Expansionary & contractionary fiscal policies',
      ),
      UnitModel(
        id: '03',
        unit: 'Keynesian multiplier',
        hlOnly: true,
      ),
      UnitModel(
        id: '04',
        unit: 'Automatic stabilizers',
      ),
    ],
    UnitModel(
      id: '3.7',
      unit: 'Supply-side policies',
    ): [
      UnitModel(
        id: '01',
        unit: 'Goals of supply-side policies',
      ),
      UnitModel(
        id: '02',
        unit: 'Market-based & interventionist supply-side policies',
      ),
      UnitModel(
        id: '03',
        unit: 'Effectiveness of supply-side policies',
      ),
    ]
  },
  Section.global: {
    UnitModel(
      id: '4.1',
      unit: 'Benefits of international trade',
    ): [
      UnitModel(
        id: '4.1a',
        unit: 'Benefits of international trade',
      ),
      UnitModel(
        id: '4.1b',
        unit: 'Absolute and comparative advantage',
        hlOnly: true,
      ),
    ],
    UnitModel(
      id: '4.2',
      unit: 'Types of trade protection',
    ): [
      UnitModel(
        id: '4.2a',
        unit: 'Tariffs',
      ),
      UnitModel(
        id: '4.2b',
        unit: 'Import quotas',
      ),
      UnitModel(
        id: '4.2c',
        unit: 'Production subsidies',
      ),
      UnitModel(
        id: '4.2d',
        unit: 'Export subsidies',
      ),
      UnitModel(
        id: '4.2e',
        unit: 'Administrative barriers',
      ),
    ],
    UnitModel(
      id: '4.3',
      unit: 'Arguments for and against trade control/protection',
    ): [
      UnitModel(
        id: '4.3a',
        unit: 'Arguments for and against trade protection',
      ),
    ],
    UnitModel(
      id: '4.4',
      unit: 'Economic integration',
    ): [
      UnitModel(
        id: '4.4a',
        unit: 'Preferential trade agreements',
      ),
      UnitModel(
        id: '4.4b',
        unit: 'Trading blocs',
      ),
      UnitModel(
        id: '4.4c',
        unit: 'Advantages and disadvantages of trading blocs',
      ),
      UnitModel(
        id: '4.4d',
        unit: 'Advantages and disadvantages of monetary union',
        hlOnly: true,
      ),
    ],
    UnitModel(
      id: '4.5',
      unit: 'Exchange rates',
    ): [
      UnitModel(
        id: '4.5a',
        unit: 'Floating exchange rates',
      ),
      UnitModel(
        id: '4.5b',
        unit: 'Fixed & managed exchange rates',
      ),
      UnitModel(
        id: '4.5c',
        unit: 'Fixed versus floating exchange rate systems',
        hlOnly: true,
      ),
    ],
    UnitModel(
      id: '4.6',
      unit: 'Balance of payments',
    ): [
      UnitModel(
        id: '4.6a',
        unit: 'Balance of payments',
      ),
      UnitModel(
        id: '4.6b',
        unit: 'Balance of payments & exchange rates',
        hlOnly: true,
      ),
      UnitModel(
        id: '4.6c',
        unit: 'The Marshall-Lerner condition and the J-curve effect',
        hlOnly: true,
      ),
    ],
    UnitModel(
      id: '4.7',
      unit: 'Sustainable development',
    ): [
      UnitModel(
        id: '4.7a',
        unit: 'Sustainable Development Goals (SDGs)',
      ),
    ],
    UnitModel(
      id: '4.8',
      unit: 'Measuring development',
    ): [
      UnitModel(
        id: '4.8a',
        unit: 'Single & composite indicators',
      )
    ],
    UnitModel(
      id: '4.9',
      unit: 'Barriers to economic growth and/or economic development',
    ): [
      UnitModel(
        id: '4.9a',
        unit: 'Barriers to economic growth and/or economic development',
      ),
    ],
    UnitModel(
      id: '4.10',
      unit: 'Economic growth and/or economic development strategies',
    ): [
      UnitModel(
        id: '4.10a',
        unit:
            'Strategies to promote economic growth and/or economic development',
      ),
    ]
  },
};
