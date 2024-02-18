import 'package:economics_app/custom_widgets/nested_scroll_custom/custon_button_overlay_appbar.dart';
import 'package:economics_app/pages/study_notes/unit_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../configs/app_colors.dart';
import '../../custom_widgets/loading_error/custom_error_widget.dart';
import '../../custom_widgets/loading_error/custom_progress_indicator.dart';
import '../../custom_widgets/tiles/custom_heading_tile.dart';
import '../../custom_widgets/tiles/custom_sub_tile.dart';
import '../../models/unit_model.dart';
import '../../utils/helper_methods/firebase_methods.dart';
import '../../utils/helper_methods/sort_string_numbers.dart';

class StudyNotes extends StatefulWidget {
  const StudyNotes({super.key});

  @override
  State<StudyNotes> createState() => _StudyNotesState();
}

class _StudyNotesState extends State<StudyNotes> {
  final List<ExpansionTileController> _expansionControllers = [];
  late final Future<List<UnitModel>?> sectionsAndUnitsFuture;

  @override
  void initState() {
    sectionsAndUnitsFuture = getSectionsAndUnitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: AppColors.defaultAppColorDarker,
            automaticallyImplyLeading: false,
            pinned: false,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            actions: [
              CustomButtonOverlayAppBar(
                  title: 'Study notes',
                  expansionControllers: _expansionControllers)
            ],
          ),
        ];
      },
      body: FutureBuilder<List<UnitModel>?>(
        future: sectionsAndUnitsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const CustomErrorWidget();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<UnitModel> topics = [];
              topics = snapshot.data!.toList();
              topics.sort((a, b) => sortStringNumbers(a.unit, b.unit));

              int i = 0;
              return SingleChildScrollView(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ...topics.map((e) {
                      i++;
                      IconData icon = getSectionIcon(i);
                      _expansionControllers.add(ExpansionTileController());
                      return Column(
                        children: [
                          ExpansionTile(
                            controller: _expansionControllers[i - 1],
                            initiallyExpanded: true,
                            title: CustomHeadingTile(
                              leading: Icon(icon),
                              e.title,
                            ),
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: e.units?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return CustomSubTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => UnitPage(
                                            unit: e.units![index],
                                          ),
                                        ),
                                      );
                                    },
                                    unit: e.units![index],
                                    index: index,
                                    unitsLength: e.units!.length,
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      );
                    }).toList(),
                  ],
                ),
              );
            }
          }
          return const CustomProgressIndicator();
        },
      ),
    );
  }

  IconData getSectionIcon(int i) {
    IconData icon = FontAwesomeIcons.bookOpenReader;
    switch (i) {
      case 2:
        icon = FontAwesomeIcons.cartShopping;
      case 3:
        icon = FontAwesomeIcons.chartLine;
      case 4:
        icon = FontAwesomeIcons.globe;
    }
    return icon;
  }
}
