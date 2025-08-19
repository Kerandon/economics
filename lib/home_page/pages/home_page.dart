import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../diagrams/enums/unit_type.dart';
import '../custom_widgets/custom_heading.dart';
import '../custom_widgets/custom_tile.dart';
import '../enums/tool_enum.dart';
import '../state_management/home_page_state.dart';
import 'notes_page_contents.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageNewState();
}

class _HomePageNewState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final homePageNotifier = ref.read(homePageProvider.notifier);
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: size.height * 0.15, // height when expanded
            pinned: true, // stays visible when collapsed
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black, // semi-transparent black
                  borderRadius: BorderRadius.circular(12), // rounded corners
                ),
                child: Text(
                  kAppName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              background: Image.asset(
                'assets/images/globe.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(child: CustomHeading('Key Concepts - Slides')),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final u = UnitType.values.elementAt(index);
                return CustomTile(
                  text: u.title,
                  imageURL: u.iconJpg,
                  onTap: () {
                    homePageNotifier.setUnit(u);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NotesPageContents(),
                      ),
                    );
                  },
                );
              }, childCount: 4),
            ),
          ),
          SliverToBoxAdapter(child: CustomHeading('Review Tools')),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => CustomTile(
                  text: Tool.values.elementAt(index).title,
                  imageURL: Tool.values.elementAt(index).imageUrl,
                  diagramBundleEnum: Tool.values.elementAt(index).diagram,
                  onTap: () {},
                ),
                childCount: 2,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
          ),
        ],
      ),
    );
  }
}
