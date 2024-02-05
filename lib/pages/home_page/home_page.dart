import 'package:economics_app/custom_widgets/tiles/custom_subheading_tile.dart';
import 'package:economics_app/custom_widgets/tiles/custom_title_tile.dart';
import 'package:economics_app/pages/home_page/custom_navigation_bar.dart';
import 'package:economics_app/pages/home_page/articles_page/units_page.dart';
import 'package:economics_app/pages/settings_page/settings_page.dart';
import 'package:economics_app/configs/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../custom_widgets/loading_error/custom_error_widget.dart';
import '../../custom_widgets/loading_error/custom_progress_indicator.dart';
import '../../utils/helper_methods/firebase_methods.dart';
import '../../models/topic_model.dart';
import '../../utils/helper_methods/sort_string_numbers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final Future<List<TopicModel>?> sectionsAndUnitsFuture;

  @override
  void initState() {
    sectionsAndUnitsFuture = getSectionsAndUnitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        centerTitle: true,
      ),
      body: FutureBuilder<List<TopicModel>?>(
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

              return ListView(
                shrinkWrap: true,
                children: [
                  ...topics.map((e) {
                    return Column(
                      children: [
                        ExpandablePanel(
                          header: CustomTitleTile(
                            leading: Icon(Icons.person_2_outlined),
                            e.title,
                          ),
                          collapsed: const SizedBox.shrink(),
                          expanded: ListView.builder(
                            shrinkWrap: true,
                            itemCount: e.units?.length ?? 0,
                            itemBuilder: (context, index) {
                              return CustomSubheadingTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          UnitsPage(topic: e.units![index])));
                                },
                                leading: e.units![index].unit.toString(),
                                title: e.units![index].title!,
                              );
                            },
                          ),
                        ),
                        Divider(),
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
      bottomNavigationBar: const CustomNavigationBar(),
      drawer: const SettingsPage(),
    );
  }
}
