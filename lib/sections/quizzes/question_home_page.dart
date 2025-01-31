import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/flip_card_tag.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:economics_app/sections/quizzes/start_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/audio_manager/audio_manager.dart';
import '../../main.dart';

class QuestionHomePage extends ConsumerStatefulWidget {
  const QuestionHomePage({super.key});

  @override
  ConsumerState<QuestionHomePage> createState() => _QuestionHomePageState();
}

class _QuestionHomePageState extends ConsumerState<QuestionHomePage> {
  @override
  void initState() {
    getIt<AudioManager>().stopSoundTrack();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final startNotifier = ref.read(startQuizProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * kPageIndentVertical,
        left: size.width * kPageIndentHorizontal,
        right: size.width * kPageIndentHorizontal,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          crossAxisCount: 4, // Number of columns
          childAspectRatio: 1.0, // Ensures tiles are square
        ),
        itemBuilder: (context, index) {
          return GridTile(
            child: InkWell(
              onTap: () {
                startNotifier.setFlipCardTag(FlipCardTag.values[index]);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StartPage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(kRadius),
              // Match the tile's border radius
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(150), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Shadow position
                    ),
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.all(8.0), // Spacing around the tile
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      // Inner spacing for the text
                      child: Text(
                        FlipCardTag.values[index].toText(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: FlipCardTag.values.length, // Number of grid tiles
      ),
    );
  }
}
