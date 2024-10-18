import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../quiz_state/quiz_state.dart';

class UnitBannerTitle extends ConsumerWidget {
  const UnitBannerTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    return Padding(
      padding: EdgeInsets.only(left: size.width * kPageIndentHorizontal),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.05,
        child: Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
                text: '${quizState.unit.index}.${quizState.subunit.index} ',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: '${quizState.unit.name}, '
                        ' '
                        '${quizState.subunit.name}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
