import 'package:economics_app/app/utils/helper_methods/string_extensions.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../../../app/custom_widgets/custom_page_heading.dart';
import '../../../app/enums/get_custom_icon.dart';
import '../../../app/enums/sections.dart';
import '../data/units_contents.dart';
import '../models/unit_model.dart';
import 'notes_tab_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<List<ExpandableController>> _expandableControllers = [
    [],
    [],
    [],
    [],
  ];

  final List<Map<UnitModel, List<UnitModel>>> _notes = [{}, {}, {}, {}];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);

    for (var d in unitsContents.entries) {
      if (d.key == Section.intro) {
        for (var e in d.value.entries) {
          _notes[0].addAll({e.key: e.value});
        }
      } else if (d.key == Section.micro) {
        for (var e in d.value.entries) {
          _notes[1].addAll({e.key: e.value});
        }
      } else if (d.key == Section.macro) {
        for (var e in d.value.entries) {
          _notes[2].addAll({e.key: e.value});
        }
      } else if (d.key == Section.global) {
        for (var e in d.value.entries) {
          _notes[3].addAll({e.key: e.value});
        }
      }
    }

    for (var s in Section.values) {
      if (s == Section.intro) {
        final numberOfControllers = _notes[0].length;
        for (int j = 0; j < numberOfControllers; j++) {
          _expandableControllers[0]
              .add(ExpandableController(initialExpanded: true));
        }
      }
      if (s == Section.micro) {
        final numberOfControllers = _notes[1].length;
        for (int j = 0; j < numberOfControllers; j++) {
          _expandableControllers[1]
              .add(ExpandableController(initialExpanded: true));
        }
      }
      if (s == Section.macro) {
        final numberOfControllers = _notes[2].length;
        for (int j = 0; j < numberOfControllers; j++) {
          _expandableControllers[2]
              .add(ExpandableController(initialExpanded: true));
        }
      }
      if (s == Section.global) {
        final numberOfControllers = _notes[3].length;
        for (int j = 0; j < numberOfControllers; j++) {
          _expandableControllers[3]
              .add(ExpandableController(initialExpanded: true));
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentControllers = _expandableControllers[_tabController.index];

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          CustomPageHeading(
            expandableControllers: currentControllers,
            icon: getCustomIcon(CustomIcon.notes),
            title: 'Notes',
          ),
        ];
      },
      body: Scaffold(
        appBar: TabBar(
          dividerColor: Theme.of(context).colorScheme.scrim,
          controller: _tabController,
          tabs: [
            ...Section.values.map(
              (s) => Tab(
                text: s.name.capitalizeFirstLetter(),
              ),
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ..._notes.map(
              (e) => NotesTabPage(
                controllers: _expandableControllers[_notes.indexOf(e)],
                sectionNotes: e,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
