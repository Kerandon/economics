import 'package:economics_app/sections/settings/edit_courses/helper_methods/add_courses_to_firebase.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/configs/constants.dart';
import '../../../app/custom_widgets/custom_chip_button.dart';
import '../../../app/custom_widgets/custom_pop_up.dart';
import '../../../app/custom_widgets/mini_building_helper.dart';
import '../../../app/enums/firebase_status.dart';
import '../../../app/utils/models/course.dart';
import '../../../app/utils/models/unit.dart';
import '../../quizzes/quiz_state/courses_state.dart';
import 'helper_methods/delete_course_data.dart';

class CourseEditActionButtons extends ConsumerWidget {
  const CourseEditActionButtons(
      {required this.textControllerText,
      required this.unitsAreValidated,
      required this.addCourseMap,
      required this.onComplete,
      super.key});

  final Map<int, Map<String, dynamic>> addCourseMap;
  final String textControllerText;
  final bool unitsAreValidated;
  final Function onComplete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseState = ref.watch(coursesProvider);
    final courseNotifier = ref.read(coursesProvider.notifier);
    final size = MediaQuery.of(context).size;
    String c = textControllerText;
    if (c.isEmpty) {
      c = courseState.course.name;
    }
    return SizedBox(
      width: size.width,
      child: Wrap(
        spacing: size.width * kWrapSpacing,
        alignment: WrapAlignment.spaceBetween,
        children: [
          CustomChipButton(
            isDisabled: !unitsAreValidated,
            text: 'Save changes',
            onPressed: unitsAreValidated
                ? () async {
                    List<Unit> units = Unit.fromAddCourseMap(addCourseMap);

                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => MiniBuilderHelper(
                        future: addCourseToFirebase(
                            course: textControllerText, units: units),
                        onComplete: (status) {
                          WidgetsBinding.instance.addPostFrameCallback((t) {
                            if (status == FirebaseStatus.success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Changes saved'),
                                ),
                              );
                            }
                            if (status == FirebaseStatus.error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Changes not saved - check your internet connection and try again'),
                                ),
                              );
                            }
                          });
                        },
                      ),
                    );

                    // _setUpUnits = false;

                    courseNotifier.setCourseSelected(
                      Course(
                        name: textControllerText,
                        units: units,
                      ),
                    );
                  }
                : null,
          ),
          CustomChipButton(
            isDisabled: courseState.course.name == "",
            textAndIconColor: Colors.red,
            outlinedStyle: true,
            icon: Icons.delete_outlined,
            text: 'Delete course',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CustomPopup(
                  title: 'Delete course',
                  content: Text.rich(
                    TextSpan(
                      text: 'Are you sure you want to delete ',
                      style: const TextStyle(
                          fontSize: 18), // Adjust the font size as needed
                      children: [
                        TextSpan(
                          text: c, // The variable you want to bold
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
                          text: ' and all its units?\n\n',
                          style: TextStyle(fontSize: 18),
                        ),
                        const TextSpan(
                          text: 'WARNING: this action cannot be undone.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red, // Red color for the warning
                            fontWeight: FontWeight.bold, // Bold for emphasis
                          ),
                        ),
                      ],
                    ),
                  ),
                  actionButtons: [
                    CustomChipButton(
                      textAndIconColor: Colors.red,
                      outlinedStyle: true,
                      text: 'Confirm delete',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => MiniBuilderHelper(
                            future: deleteCourseData(c),
                            onComplete: (status) {
                              Navigator.of(context).pop();
                              String message = "";
                              if (status == FirebaseStatus.success) {
                                message = 'Course $c deleted successfully';
                              }
                              if (status == FirebaseStatus.error) {
                                message =
                                    'Course $c was not deleted - check your internet connection & try again';
                              }
                              WidgetsBinding.instance.addPostFrameCallback(
                                (t) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        message,
                                      ),
                                    ),
                                  );
                                  onComplete.call();
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                    CustomChipButton(
                        text: 'Cancel',
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
