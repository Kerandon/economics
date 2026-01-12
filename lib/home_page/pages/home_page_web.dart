import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/configs/constants.dart';
import '../../diagrams/enums/unit_type.dart';
import '../custom_widgets/custom_tile.dart';
import '../enums/resources_enum.dart';
import '../state_management/home_page_state.dart';
import 'notes_page_contents.dart';

class HomePageWeb extends ConsumerStatefulWidget {
  const HomePageWeb({super.key});

  @override
  ConsumerState<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends ConsumerState<HomePageWeb>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homePageNotifier = ref.read(homePageProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Key Concepts'),
            Tab(text: 'Review Tools'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // -------- Key Concepts Tab --------
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: UnitType.values.length,
              itemBuilder: (context, index) {
                final u = UnitType.values[index];
                return CustomTile(
                  text: u.title,
                  imageURL: u.iconJpg,
                  onTap: () {
                    homePageNotifier.setUnit(u);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotesPageContents(),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // -------- Review Tools Tab --------
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: Resource.values.length,
              itemBuilder: (context, index) {
                final tool = Resource.values[index];
                return CustomTile(
                  text: tool.title,
                  imageURL: tool.imageUrl,
                  diagramBundleEnum: tool.diagram,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => tool.page),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
