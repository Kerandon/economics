import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/filter_contents.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizFilterButton extends ConsumerWidget {
  const QuizFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
final size = MediaQuery.of(context).size;

    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomChipButton(
          outlinedStyle: true,
            icon: Icons.filter_alt_outlined,
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  builder: (context) => const FilterContents());
            }),
      );


  }
}
