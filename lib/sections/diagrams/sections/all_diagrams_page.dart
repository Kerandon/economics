import 'package:economics_app/sections/diagrams/diagram_widgets/diagram_builder.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllDiagramsPage extends ConsumerStatefulWidget {
  const AllDiagramsPage({
    super.key,
  });

  @override
  ConsumerState<AllDiagramsPage> createState() => _AllDiagramsPageState();
}

class _AllDiagramsPageState extends ConsumerState<AllDiagramsPage> {
  @override
  Widget build(BuildContext context) {
    return DiagramBuilder(
      doubleCrossAxis: false,
    );
  }
}
