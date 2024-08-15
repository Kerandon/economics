import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/notes/data/article_data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/custom_widgets/custom_page_heading.dart';
import '../../../app/state/app_state.dart';

class NotesContents extends ConsumerStatefulWidget {
  const NotesContents({super.key});

  @override
  ConsumerState<NotesContents> createState() => _NotesContentsState();
}

class _NotesContentsState extends ConsumerState<NotesContents> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appState = ref.watch(appProvider);
    final contents =
        articleData.firstWhere((e) => e.key == appState.selectedUnit.id);

    return Scaffold(
      appBar: AppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CustomPageHeading(
              icon: const Icon(
                Icons.ssid_chart,
              ),
              title: appState.selectedUnit.unit.toString(),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(size.width * kPageIndentHorizontal),
            child: Container(
              child: contents.value,
            ),
          ),
        ),
      ),
    );
  }
}
