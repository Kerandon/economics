import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../diagrams/diagram_widgets/diagram_bundle_widget.dart';
import '../data/get_slides_by_key.dart';
import '../state_management/home_page_state.dart';

class NotesExpansionTilePage extends ConsumerWidget {
  const NotesExpansionTilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final homePageState = ref.watch(homePageProvider);
    final slides = getSlides(
      size: size,
      theme: theme,
      key: homePageState.selectedSubunit,
    );
    return Scaffold(
      appBar: AppBar(title: Text(homePageState.selectedSubunit?.title ?? '')),
      body: ListView(
        children: slides.map((s) {
          return ExpansionTile(
            title: Text(s.title ?? 'No title'),
            children: [
              Container(
                color: Colors.green,
                child: Column(
                  children: [
                    if (s.contents?.isNotEmpty ?? false)
                      ...s.contents!.map((c) {
                        return Column(
                          children: [
                            if (c.alert?.isNotEmpty ?? false)
                              Container(
                                color: Colors.red,
                                child: Text(c.alert ?? 'No alert'),
                              ),
                            if (c.tip?.isNotEmpty ?? false)
                              Container(
                                color: Colors.blue,
                                child: Text(c.tip ?? 'no tip'),
                              ),
                            if (c.content?.isNotEmpty ?? false)
                              Container(
                                color: Colors.purpleAccent,
                                child: Text(c.content ?? 'no content'),
                              ),
                            if (c.diagramBundles?.isNotEmpty ?? false)
                              Container(
                                height: 500,
                                width: 500,
                                color: Colors.orange,
                                child: Row(
                                  children: [
                                    ...c.diagramBundles!.map(
                                      (b) =>
                                          DiagramBundleWidget(diagramBundle: b),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      }),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
