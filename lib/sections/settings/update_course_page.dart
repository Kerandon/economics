import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_big_button.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/utils/mixins/unit_mixin.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/add_question/custom_text_field.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/custom_widgets/gap.dart';
import '../../app/utils/mixins/course_mixin.dart';
import '../../app/utils/models/course.dart';
import '../../app/utils/models/unit.dart';
import '../quizzes/quiz_state/courses_state.dart';

const List<String> list = ['intro', 'micro', 'macro', 'global'];

class UpdateCoursePage extends ConsumerStatefulWidget {
  const UpdateCoursePage({super.key});

  @override
  ConsumerState<UpdateCoursePage> createState() => _UpdateCoursePageState();
}

class _UpdateCoursePageState extends ConsumerState<UpdateCoursePage> {
  final TextEditingController _courseTextController = TextEditingController();
  final List<TextEditingModel> _unitTextEditingModels = [];
  final List<TextEditingModel> _subunitTextEditingModels = [];
  bool _haveSetCourseOnInit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final courseState = ref.watch(coursesProvider);
    final courseNotifier = ref.read(coursesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Update course units'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('courses').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            List<CourseMixin> courses = [];
            if (snapshot.data != null) {
              for (var e in snapshot.data!.docs) {
                courses.add(
                  Course.fromMap({
                    e.id: e.data(),
                  }),
                );
              }
              WidgetsBinding.instance.addPostFrameCallback((t) {
                courseNotifier.setAllCourses(courses);
              });

              if (!_haveSetCourseOnInit) {
                _haveSetCourseOnInit = true;
                if (courseState.courses.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((t) {
                    courseNotifier.setCourseSelected(courses.first);
                  });
                }
              }
            }

            return SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CourseSelectionWidget(
                  courseTextEditingController: _courseTextController,
                  onChange: () {
                    _unitTextEditingModels.clear();
                    _subunitTextEditingModels.clear();
                  },
                ),
                if (!courseState.createCourseIsSelected) ...[
                  const Gap(
                    showDivider: true,
                  ),
                ],
                Column(
                  children: [
                    if (!courseState.createCourseIsSelected &&
                        courseState.course.units.isNotEmpty) ...[
                      Text(
                        'Course contents',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      ...List.generate(
                        courseState.course.units.length,
                        (index) {
                          final c = courseState.course.units[index];

                          return Column(
                            children: [
                              ExpandablePanel(
                                header: SizedBox(
                                  child: Container(
                                    height: size.height * 0.06,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text('Unit ${c.id.toString()}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary)),
                                        ),
                                        Text(
                                          c.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                collapsed: const SizedBox.shrink(),
                                expanded: Container(
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                        c.subunits.length,
                                        (index) => Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(38, 6, 6, 6),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                child: Icon(
                                                  Icons
                                                      .subdirectory_arrow_right_outlined,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 12),
                                                child: Text(
                                                  c.subunits[index].id ?? "",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary),
                                                ),
                                              ),
                                              Text(c.subunits[index].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const Gap(
                        showDivider: true,
                      ),
                    ],
                  ],
                ),
                const Gap(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add new units',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    ...List.generate(
                      _unitTextEditingModels.length,
                      (index) {
                        int newUnitIndex =
                            courseState.course.units.length + index;

                        return ExpandablePanel(
                          collapsed: SizedBox.shrink(),
                          header: Container(
                            width: size.width,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'Unit ${newUnitIndex + 1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: CustomTextField(
                                      controller: _unitTextEditingModels[index]
                                          .controller),
                                ),
                              ],
                            ),
                          ),
                          expanded: Container(
                            width: size.width,
                            height: 30,
                            color: Colors.red,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Gap(),
                Wrap(
                  spacing: size.width * kWrapSpacing,
                  alignment: WrapAlignment.start,
                  children: [
                    CustomChipButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        text: "Add unit",
                        onPressed: () {
                          _unitTextEditingModels.add(
                            TextEditingModel(
                              _unitTextEditingModels.length + 1,
                              TextEditingController(),
                            ),
                          );
                          setState(() {});
                        }),
                    CustomChipButton(
                      isDisabled: _unitTextEditingModels.isEmpty,
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      text: "Remove last",
                      onPressed: _unitTextEditingModels.isNotEmpty
                          ? () {
                              _unitTextEditingModels.removeLast();
                              setState(() {});
                            }
                          : null,
                    ),
                  ],
                ),
                const Gap(
                  showDivider: true,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Center(
                  child: CustomBigButton(
                      text: 'Confirm',
                      onPressed: () {
                        List<Unit> units = [];
                        for (var u in _unitTextEditingModels) {
                          units.add(
                            Unit(
                              name: u.controller.text,
                              id: u.index.toString(),
                            ),
                          );
                        }
                        final testUnits = [
                          Unit(
                            name: "Car",
                            id: '1',
                            subunits: [
                              Unit(name: 'Ferrari', id: '1.1'),
                              Unit(name: 'Porsche', id: '1.2'),
                            ],
                          ),
                          Unit(
                            name: 'Trucks',
                            id: '2',
                            subunits: [
                              Unit(name: 'Monster truck', id: '2.1'),
                              Unit(name: 'Truck', id: '2.2'),
                            ],
                          )
                        ];

                        addCourseToFirebase(
                          course: _courseTextController.text,
                          units: units,
                        );

                        courseNotifier.setCourseSelected(
                          Course(
                            name: _courseTextController.text,
                            units: testUnits,
                          ),
                        );
                      }),
                ),
              ],
            ));
          }),
    );
  }
}

Future<void> addCourseToFirebase(
    {required String course, required List<Unit> units}) async {
  Map<String, dynamic> unitsMap = {};

  for (var u in units) {
    unitsMap.addAll(u.toMap());
  }

  final ref = FirebaseFirestore.instance;
  try {
    await ref.collection('courses').doc(course).set(unitsMap);
  } catch (e) {
    print('ERROR $e');

    /// Todo error catching here
  }
}

class UnitTextControllerModel {
  final TextEditingModel idController;
  final TextEditingModel nameController;

  UnitTextControllerModel(this.idController, this.nameController);
}

class TextEditingModel {
  final int index;
  final TextEditingController controller;

  TextEditingModel(this.index, this.controller);
}

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
        Gap(),
        Stack(
          children: [
            Center(
              child: Container(
                width: size.width * 0.60,
                color: Colors.red,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: size.width * kWrapSpacing,
                  children: [
                    ...courseState.courses.map(
                      (e) => CustomChipButton(
                        text: e.name,
                        onPressed: () async {
                          onChange.call();
                          courseNotifier.setCourseSelected(e);
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
                },
              ),
            ),
          ],
        ),
        Gap(),
        ...[
          if (courseState.createCourseIsSelected) ...[
            Text(
              'Type course name',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            CustomTextField(
              controller: courseTextEditingController,
            ),
          ],
        ],
      ],
    );
  }
}
