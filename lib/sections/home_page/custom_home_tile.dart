
import 'package:economics_app/sections/quizzes/methods/get_tile_decoration.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/configs/constants.dart';

class CustomHomeTile extends ConsumerWidget {
  const CustomHomeTile({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);



    return GridTile(
      child: InkWell(
        onTap: () {
          onPressed.call();
        },
        borderRadius: BorderRadius.circular(kRadius),
        // Match the tile's border radius
        child: Ink(
          decoration: getTileDecoration(context),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            // Inner spacing for the text
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 12,
                  child: Center(
                    child: Text(
                      title,
                      // QuestionType.values.elementAt(index).name,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Divider(
                  color: theme.colorScheme.shadow,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


