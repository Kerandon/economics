import 'package:economics_app/diagrams/enums/unit_type.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state_management/home_page_state.dart';
import 'notes_page.dart';

class NotesPageContents extends ConsumerWidget {
  const NotesPageContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePageState = ref.watch(homePageProvider);
    final homePageNotifier = ref.read(homePageProvider.notifier);

    final unit = homePageState.selectedUnit; // This should be a UnitType
    final subunits = unit?.subunits; // Uses the extension getter

    return Scaffold(
      appBar: AppBar(title: Text(unit?.title ?? '')),
      body: ListView(
        children: [
          if (subunits?.isNotEmpty ?? false)
            ...subunits!.map(
              ((e) => ListTile(
                leading: Text(e.id),
                title: Text(e.title),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
                onTap: () {
                  homePageNotifier.setSubunit(e);
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => NotesPage()));
                },
              )),
            ),
        ],
      ),
    );
  }
}
