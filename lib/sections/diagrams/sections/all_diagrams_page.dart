import 'package:economics_app/app/custom_widgets/custom_page_heading.dart';
import 'package:economics_app/app/utils/helper_methods/string_extensions.dart';
import 'package:economics_app/sections/diagrams/utils/extensions.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/enums/sections_replace_me.dart';
import '../custom_paint/painter_constants.dart';
import 'diagram_contents.dart';
import '../enums/diagram_type.dart';

class AllDiagramsPage extends ConsumerStatefulWidget {
  const AllDiagramsPage({super.key});

  @override
  ConsumerState<AllDiagramsPage> createState() => _AllDiagramsPageState();
}

class _AllDiagramsPageState extends ConsumerState<AllDiagramsPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<ExpandableController> _expandableControllers = [];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    for (int i = 0; i < 4; i++) {
      _expandableControllers.add(ExpandableController(initialExpanded: true));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// To-do can this code be optimized?
    List<List<DiagramType>> subDiagrams = [[], [], [], []];

    for (var d in DiagramType.values) {
      if (d.name.getFirstWord() == IBSectionOld.intro.name &&
          d.name.contains(kDefault)) {
        subDiagrams[0].add(d);
      } else if (d.name.getFirstWord() == IBSectionOld.micro.name &&
          d.name.contains(kDefault)) {
        subDiagrams[1].add(d);
      } else if (d.name.getFirstWord() == IBSectionOld.macro.name &&
          d.name.contains(kDefault)) {
        subDiagrams[2].add(d);
      } else if (d.name.getFirstWord() == IBSectionOld.global.name &&
          d.name.contains(kDefault)) {
        subDiagrams[3].add(d);
      }
    }
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          CustomPageHeading(
            expandableControllers: _expandableControllers,
            icon: const Icon(
              Icons.ssid_chart,
            ),
            title: 'Diagrams',
          ),
        ];
      },
      body: Scaffold(
        appBar: TabBar(
          dividerColor: Theme.of(context).colorScheme.scrim,
          controller: _tabController,
          tabs: [
            ...IBSectionOld.values.map(
              (s) => Tab(
                text: s.name.capitalizeFirstLetter(),
              ),
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ...List.generate(
              4,
              (index) => DiagramContents(
                subDiagrams: subDiagrams[index],
                index: index,
                controller: _expandableControllers[index],
              ),
            )
          ],
        ),
      ),
    );
  }
}
