import 'package:economics_app/models/topic_model.dart';
import 'package:economics_app/pages/home_page/unit_page/unit_page.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../custom_widgets/loading_error/custom_error_widget.dart';
import '../../custom_widgets/loading_error/custom_progress_indicator.dart';
import '../../custom_widgets/tiles/custom_banner.dart';
import '../../custom_widgets/tiles/custom_tile.dart';
import '../../custom_widgets/tiles/custom_title_tile.dart';
import '../../utils/helper_methods/firebase_methods.dart';
import '../../utils/helper_methods/sort_string_numbers.dart';

class StudyNotesPage extends StatefulWidget {
  const StudyNotesPage({super.key});

  @override
  State<StudyNotesPage> createState() => _StudyNotesPageState();
}

class _StudyNotesPageState extends State<StudyNotesPage> {
  late final Future<List<TopicModel>?> sectionsAndUnitsFuture;

  @override
  void initState() {
    sectionsAndUnitsFuture = getSectionsAndUnitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<TopicModel>?>(
        future: sectionsAndUnitsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const CustomErrorWidget();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<TopicModel> topics = [];
              topics = snapshot.data!.toList();
              topics.sort((a, b) => sortStringNumbers(a.unit, b.unit));

              int i = 0;
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  const CustomBanner('Study notes'),
                  ...topics.map((e) {
                    i++;
                    IconData icon = getSectionIcon(i);

                    return Column(
                      children: [
                        ExpansionTile(
                          title: CustomTitleTile(
                            leading: Icon(icon),
                            e.title,
                          ),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: e.units?.length ?? 0,
                              itemBuilder: (context, index) {
                                return CustomListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => UnitPage(
                                          topic: e.units![index],
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
              );
            } else {
              return const CustomErrorWidget();
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
