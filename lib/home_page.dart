import 'package:economics_app/state/app_state.dart';
import 'package:economics_app/topic_contents.dart';
import 'package:economics_app/topic_tiles.dart';
import 'package:economics_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'utils/helper_methods/firebase_methods.dart';
import 'models/topic_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final Future<List<TopicModel>> contentsFuture;

  @override
  void initState() {
    contentsFuture = getContentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(appProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        centerTitle: true,
      ),
      body: FutureBuilder<List<TopicModel>>(
        future: contentsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              notifier.setContents(snapshot.data as List<TopicModel>);
            });

            return SingleChildScrollView(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: const [
                  ...[
                    TopicTiles(),
                  ],
                  ...[
                    TopicContents(),
                  ]
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
