import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DiagramStartPage extends ConsumerWidget {
  const DiagramStartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          GridTile(
            child: Text(
              'Practice diagrams',
            ),
          ),
          GridTile(
            child: Text(
              'All diagrams',
            ),
          )
        ],
      ),
    );
  }
}
