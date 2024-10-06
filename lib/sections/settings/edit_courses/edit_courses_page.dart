import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/utils/mixins/unit_mixin.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/custom_widgets/gap.dart';
import '../../../app/utils/mixins/course_mixin.dart';
import '../../../app/utils/models/course.dart';
import '../../../app/utils/models/unit.dart';
import '../../quizzes/quiz_state/courses_state.dart';
import 'add_courses_to_firebase.dart';
import 'add_units_buttons.dart';
import 'contents_row.dart';
import 'course_selection_widget.dart';

class EditCoursesPage extends ConsumerStatefulWidget {
  const EditCoursesPage({super.key});

  @override
  ConsumerState<EditCoursesPage> createState() => _UpdateCoursePageState();
}

class _UpdateCoursePageState extends ConsumerState<EditCoursesPage> {
  final TextEditingController _courseTextController = TextEditingController();
  final Map<int, Map<String, dynamic>> newMap = {};
  bool _haveSetCourseOnInit = false;
  bool _setUpUnits = false;

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
                if (courseState.course.name == "") {
                  WidgetsBinding.instance.addPostFrameCallback((t) {
                    courseNotifier.setCourseSelected(courses.first);
                  });
                }
              }
            }

            if (!_setUpUnits) {
              _setUpUnits =
                  setUpCoursesDataOnInit(courseState.course.units.toList());
            }

            return SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CourseSelectionWidget(
                  courseTextEditingController: _courseTextController,
                  onChange: () {
                    newMap.clear();
                    _setUpUnits = false;

                    setState(() {});
                  },
                ),
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
                    ],
                  ],
                ),
                const Gap(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      newMap.length,
                      (index) {
                        // Initialize a map to hold the subunits
                        Map<int, TextEditingController> subs = {};

                        // Populate the subs map from the current unit's subunits
                        Map<int, TextEditingController> subunits =
                            newMap.entries.elementAt(index).value['subunits']
                                as Map<int, TextEditingController>;

                        subunits.forEach((subIndex, controller) {
                          subs[subIndex] = controller;
                        });

                        return ExpandablePanel(
                          collapsed: const SizedBox.shrink(),
                          header: SizedBox(
                            width: size.width,
                            child: ContentsRow(
                              textEditingController: newMap.entries
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
                                        textEditingController: subunits[i]
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
                                      onAdd: () {
                                        setState(() {
                                          // Get the next index for the new subunit
                                          int subIndex = subunits.length;

                                          // Add a new subunit for the current main unit
                                          subunits[subIndex] =
                                              TextEditingController();
                                        });
                                      },
                                      onRemove: () {
                                        setState(() {
                                          // Remove the last subunit if it exists
                                          if (subunits.isNotEmpty) {
                                            subunits
                                                .remove(subunits.length - 1);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Gap(),
                AddUnitsButtons(
                  onAdd: () {
                    setState(() {
                      // Get the next index for the new main entry
                      int newIndex = newMap.length;

                      // Create a new entry for the main unit
                      newMap[newIndex] = {
                        'controller': TextEditingController(),
                        'subunits': <int, TextEditingController>{
                          0: TextEditingController(text: ''),
                        },
                      };
                    });
                  },
                  onRemove: () {
                    setState(() {
                      // Remove the last entry if it exists
                      if (newMap.isNotEmpty) {
                        newMap.remove(newMap.length - 1);
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
                Center(
                  child: CustomChipButton(
                      text: 'Save changes',
                      onPressed: () {
                        List<Unit> units = [];

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

  bool setUpCoursesDataOnInit(List<UnitMixin> units) {
    // if(courseState.course.units.isEmpty){
    // Populate newMap
    int index = 0; // To keep track of the index for the main units
    for (var c in units) {
      // Create a new entry for each unit
      newMap[index] = {
        'controller': TextEditingController(text: c.name),
        // Set the unit name
        'subunits': <int, TextEditingController>{},
        // Initialize subunits map
      };

      // Populate the subunits
      int subIndex = 0; // To keep track of the index for subunits
      for (var d in c.subunits) {
        newMap[index]!['subunits'][subIndex] =
            TextEditingController(text: d.name); // Set subunit name
        subIndex++; // Increment subIndex for the next subunit
      }

      index++; // Increment index for the next unit
    }
    return units.isNotEmpty;
  }
}
