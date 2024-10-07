import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_chip_button.dart';
import '../../../app/custom_widgets/gap.dart';
import '../../../app/utils/models/course.dart';
import '../../quizzes/quiz_state/courses_state.dart';

class CourseSelectionWidget extends ConsumerWidget {
  const CourseSelectionWidget({
    super.key,
    required this.onChange,
    required this.courseTextEditingController,
  });

  final VoidCallback onChange;
  final TextEditingController courseTextEditingController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final courseState = ref.watch(coursesProvider);
    final courseNotifier = ref.read(coursesProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(),
        Stack(
          children: [
            Center(
              child: SizedBox(
                width: size.width * 0.60,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: size.width * kWrapSpacing,
                  runSpacing: size.height * kWrapSpacing,
                  children: [
                    ...courseState.courses.map(
                      (e) => CustomChipButton(
                        text: e.name,
                        onPressed: () async {
                          courseNotifier.setCourseSelected(e);
                          onChange.call();
                        },
                        isSelected: courseState.course.name == e.name,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomChipButton(
                isSelected: courseState.createCourseIsSelected,
                icon: Icon(
                  Icons.add,
                  color: courseState.course.name == ""
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary,
                ),
                textColor: courseState.createCourseIsSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
                text: 'Create new course',
                onPressed: () {
                  courseNotifier.setCourseSelected(Course(name: "", units: []));
                  onChange.call();
                },
              ),
            ),
          ],
        ),
        const Gap(),
        ...[
          if (courseState.createCourseIsSelected) ...[
            Text(
              'Create new course',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Gap(),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter course name',
                hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color:
                Colors.grey,), //
              ),
              controller: courseTextEditingController,
            )
          ],
        ],
      ],
    );
  }
}
