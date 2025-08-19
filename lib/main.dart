import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/diagrams/data/all_diagrams.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'app/configs/theme_data.dart';
import 'app/state/app_state.dart';
import 'home_page/pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: EconApp()));
}

class EconApp extends ConsumerWidget {
  const EconApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      theme: CustomAppTheme(appState, context).appTheme,
      home: HomePage(),
    );
  }
}

class TestDiagram extends StatelessWidget {
  const TestDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...AllDiagrams(size: size, colorScheme: colorScheme)
                .getDiagramBundles(getAll: true)
                .map((e) {
                  return Column(children: [
                    ...e.basePainterDiagrams.map((d) => Container(
                        color: Colors.green,
                        width: 200,
                        height: 200,
                        child: CustomPaint(painter: d,)))
                  ],);

                }),
          ],
        ),
      ),
    );
  }
}
