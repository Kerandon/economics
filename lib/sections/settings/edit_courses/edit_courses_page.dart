import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/utils/mixins/unit_mixin.dart';
import 'package:economics_app/sections/settings/edit_courses/action_buttons.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/gap.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../../app/utils/models/course.dart';
import '../../../app/utils/models/unit.dart';
import '../../quizzes/quiz_state/courses_state.dart';
import 'add_units_buttons.dart';
import 'contents_row.dart';
import 'course_selection_widget.dart';
import 'helper_methods/get_course_data_from_firebase.dart';

class EditCoursesPage extends ConsumerStatefulWidget {
  const EditCoursesPage({super.key});

  @override
  ConsumerState<EditCoursesPage> createState() => _UpdateCoursePageState();
}

class _UpdateCoursePageState extends ConsumerState<EditCoursesPage> {
  Future<QuerySnapshot<Map<String, dynamic>>?>? _courseDataFuture;
  final TextEditingController _courseTextController = TextEditingController();
  final List<ExpandableController> _expandableControllers = [];
  final Map<int, Map<String, dynamic>> addCourseMap = {};
  bool _haveSetCourseOnInit = false, _setUpUnits = false;

  @override
  void initState() {
    _fetchCourseData();
    super.initState();
  }

  void _fetchCourseData() => _courseDataFuture = getCourseData();

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
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>?>(
          future: _courseDataFuture,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>?> snapshot) {
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
                if (courseState.course.name == "") {
                  WidgetsBinding.instance.addPostFrameCallback((t) {
                    courseNotifier.setCourseSelected(courses.first);
                  });
                }
              }

              if (!_setUpUnits) {
                _setUpUnits =
                    setUpCoursesDataOnChange(courseState.course.units.toList());

                for (int i = 0; i < courseState.course.units.length; i++) {
                  _expandableControllers
                      .add(ExpandableController(initialExpanded: true));
                }
              }

              List<Unit> units = Unit.fromAddCourseMap(addCourseMap);
              bool unitsAreValidated = validateAllFields(
                  units: units,
                  createCoursesIsSelected: courseState.createCourseIsSelected);

              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * kPageIndentHorizontal),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CourseSelectionWidget(
                        courseTextEditingController: _courseTextController,
                        onChange: () {
                          addCourseMap.clear();
                          _setUpUnits = false;
                          onAdd();
                          setState(() {});
                        },
                      ),
                      const Gap(),
                      Column(
                        children: [
                          if (!courseState.createCourseIsSelected &&
                              courseState.course.units.isNotEmpty) ...[
                            Text(
                              'Course contents',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ],
                        ],
                      ),
                      const Gap(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                            addCourseMap.length,
                            (index) {
                              // Initialize a map to hold the subunits
                              Map<int, TextEditingController> subs = {};

                              // Populate the subs map from the current unit's subunits
                              Map<int, TextEditingController> subunits =
                                  addCourseMap.entries
                                          .elementAt(index)
                                          .value['subunits']
                                      as Map<int, TextEditingController>;

                              subunits.forEach((subIndex, controller) {
                                subs[subIndex] = controller;
                              });

                              return Column(
                                children: [
                                  ExpandablePanel(
                                    theme: const ExpandableThemeData(
                                      tapBodyToExpand: false,
                                      tapBodyToCollapse: false,
                                      tapHeaderToExpand: false,
                                    ),
                                    controller: _expandableControllers[index],
                                    collapsed: const SizedBox.shrink(),
                                    header: SizedBox(
                                      width: size.width,
                                      child: ContentsRow(
                                        textEditingController: addCourseMap
                                            .entries
                                            .elementAt(index)
                                            .value['controller'],
                                        unit: 'Unit ${index + 1} ',
                                      ),
                                    ),
                                    expanded: Column(
                                      children: [
                                        ...List.generate(
                                          subunits.length,
                                          (i) => Row(
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.06,
                                              ),
                                              Expanded(
                                                child: ContentsRow(
                                                  isSubunit: true,
                                                  unit:
                                                      '${(index + 1).toString()}.${(i + 1).toString()}',
                                                  textEditingController: subunits[
                                                          i]
                                                      as TextEditingController,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 158, top: 6, bottom: 6),
                                              child: AddUnitsButtons(
                                                label: 'Subunits',
                                                disableOnRemove:
                                                    subunits.isEmpty,
                                                onAdd: () {
                                                  setState(() {
                                                    // Get the next index for the new subunit
                                                    int subIndex =
                                                        subunits.length;

                                                    // Add a new subunit for the current main unit
                                                    subunits[subIndex] =
                                                        TextEditingController();
                                                  });
                                                },
                                                onRemove: () {
                                                  setState(() {
                                                    if (subunits.isNotEmpty) {
                                                      subunits.remove(
                                                          subunits.length - 1);
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(
                                    showDivider: true,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(),
                      AddUnitsButtons(
                        label: 'Units',
                        disableOnRemove: units.isEmpty,
                        onAdd: () {
                          onAdd();
                        },
                        onRemove: () {
                          setState(() {
                            // Remove the last entry if it exists
                            if (addCourseMap.isNotEmpty) {
                              addCourseMap.remove(addCourseMap.length - 1);
                              _expandableControllers.removeLast();
                            }
                          });
                        },
                      ),
                      const Gap(
                        showDivider: true,
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      CourseEditActionButtons(
                        textControllerText: _courseTextController.text,
                        unitsAreValidated: unitsAreValidated,
                        addCourseMap: addCourseMap,
                        onComplete: () {
                          _courseDataFuture = getCourseData();
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.15,
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  void onAdd() {
    int newIndex = addCourseMap.length;

    // Create a new entry for the main unit
    addCourseMap[newIndex] = {
      'controller': TextEditingController(),
      'subunits': <int, TextEditingController>{
        0: TextEditingController(text: ''),
      },
    };
    _expandableControllers.add(ExpandableController(initialExpanded: true));
  }

  bool validateAllFields(
      {required List<Unit> units, required bool createCoursesIsSelected}) {
    bool isCourseValid = true;
    if (!createCoursesIsSelected) {
      isCourseValid = _courseTextController.text.trim().isEmpty;
    }
    bool unitsAreValidated = isCourseValid &&
        units.every(
          (u) =>
              u.id?.trim().isNotEmpty == true &&
              u.name.trim().isNotEmpty &&
              u.subunits.every((e) =>
                  e.id?.trim().isNotEmpty == true && e.name.trim().isNotEmpty),
        );
    return unitsAreValidated;
  }

  bool setUpCoursesDataOnChange(List<UnitMixin> units) {
    int index = 0; // To keep track of the index for the main units
    for (var c in units) {
      addCourseMap[index] = {
        'controller': TextEditingController(text: c.name),
        'subunits': <int, TextEditingController>{},
      };
      int subIndex = 0; // To keep track of the index for subunits
      for (var d in c.subunits) {
        addCourseMap[index]!['subunits'][subIndex] =
            TextEditingController(text: d.name); // Set subunit name
        subIndex++; // Increment subIndex for the next subunit
      }

      index++; // Increment index for the next unit
    }
    return units.isNotEmpty;
  }
}
