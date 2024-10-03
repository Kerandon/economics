import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_big_button.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/utils/mixins/unit_mixin.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/add_question/custom_text_field.dart';
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
  // late final Stream<List<CourseMixin>> _getCoursesStream;
  final TextEditingController _courseTextController = TextEditingController();
  final List<UnitTextControllerModel> _unitTextControllerModels = [];
  final List<UnitTextControllerModel> _subunitTextControllerModels = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final courseState = ref.watch(coursesProvider);
    final courseNotifier = ref.read(coursesProvider.notifier);
    bool createCourseSelected = false;
    if (courseState.course.name == "") {
      createCourseSelected = true;
    }

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
            List<UnitMixin> units = [];
            if (snapshot.data != null) {
              for (var e in snapshot.data!.docs) {
                // Get the data as Map<String, dynamic> using the data() method

                courses.add(Course.fromMap({e.id: e.data()}));
              }
            }
            for (var c in courses) {
              if (courseState.course == c) {
                units.addAll(c.units.toList());
              }
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(),
                  Stack(
                    children: [
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: size.width * kWrapSpacing,
                          children: [
                            ...courses.map((e) => CustomChipButton(
                                  text: e.name,
                                  onPressed: () async {
                                    _unitTextControllerModels.clear();
                                    _subunitTextControllerModels.clear();
                                    courseNotifier.setCourseSelected(e);
                                  },
                                  isSelected: courseState.course.name == e.name,
                                )),
                            ...[],
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomChipButton(
                          isSelected: createCourseSelected,
                          icon: Icon(
                            Icons.add,
                            color: courseState.course.name == ""
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                          ),
                          textColor: createCourseSelected
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                          text: 'Create new course',
                          onPressed: () {
                            courseNotifier
                                .setCourseSelected(Course(name: "", units: []));
                          },
                        ),
                      ),
                    ],
                  ),
                  if (createCourseSelected)
                    CustomTextField(
                        controller: _courseTextController,
                        label: 'Type new course name'),
                  const Gap(
                    showDivider: true,
                  ),
                  if (courses.isNotEmpty) ...[
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courseState.course.units.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(kBackgroundOpacity),
                            borderRadius: BorderRadius.circular(kRadius),
                          ),
                          child: ListTile(
                            leading: Text(
                              courseState.course.units[index].id.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            title: Text(
                              courseState.course.units[index].name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _unitTextControllerModels.length,
                    itemBuilder: (context, index) => Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.15,
                          child: CustomTextField(
                            label: 'Add unit section',
                            controller:
                                _unitTextControllerModels[index].idController,
                            hintText: 'Unit id',
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomTextField(
                            label: "",
                            controller:
                                _unitTextControllerModels[index].nameController,
                            hintText: 'Unit name',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _subunitTextControllerModels.length,
                    itemBuilder: (context, index) => Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Icon(
                          Icons.subdirectory_arrow_right_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 35,
                        ),
                        SizedBox(
                          width: size.width * 0.15,
                          child: CustomTextField(
                            label: 'Add subunits',
                            hintText: 'Subunit id',
                            controller: _subunitTextControllerModels[index]
                                .idController,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Expanded(
                          child: CustomTextField(
                            label: "",
                            hintText: 'Subunit name',
                            controller: _subunitTextControllerModels[index]
                                .nameController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: size.width * kWrapSpacing,
                      children: [
                        SizedBox(
                          width: size.width * 0.08,
                        ),
                        CustomChipButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            text: 'Add new subunit',
                            onPressed: () {
                              _subunitTextControllerModels.add(
                                  UnitTextControllerModel(
                                      TextEditingController(),
                                      TextEditingController()));
                              setState(() {});
                            }),
                        CustomChipButton(
                            isDisabled: _unitTextControllerModels.isEmpty,
                            icon: Icon(
                              Icons.remove,
                              color: _subunitTextControllerModels.isNotEmpty
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.scrim,
                            ),
                            isSelected: _unitTextControllerModels.isNotEmpty,
                            text: 'Remove last',
                            onPressed: () {
                              _unitTextControllerModels.removeLast();
                              setState(() {});
                            }),
                      ],
                    ),
                  ),
                  const Gap(
                    showDivider: true,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: size.width * kWrapSpacing,
                      children: [
                        CustomChipButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            text: 'Add new unit',
                            onPressed: () {
                              _unitTextControllerModels.add(
                                  UnitTextControllerModel(
                                      TextEditingController(),
                                      TextEditingController()));
                              setState(() {});
                            }),
                        CustomChipButton(
                            isDisabled: _unitTextControllerModels.isEmpty,
                            icon: Icon(
                              Icons.remove,
                              color: _unitTextControllerModels.isNotEmpty
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.scrim,
                            ),
                            isSelected: _unitTextControllerModels.isNotEmpty,
                            text: 'Remove last',
                            onPressed: () {
                              _unitTextControllerModels.removeLast();
                              setState(() {});
                            }),
                      ],
                    ),
                  ),
                  const Gap(
                    showDivider: true,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  CustomBigButton(
                      text: courseState.course.name == ""
                          ? 'Confirm new course'
                          : "Confirm changes",
                      onPressed: () {
                        addCourseToFirebase(
                            course: _courseTextController.text,
                            unitTextModels: _unitTextControllerModels);
                      }),
                ],
              ),
            );
          }),
    );
  }
}

Future<void> addCourseToFirebase(
    {required String course,
    required List<UnitTextControllerModel> unitTextModels}) async {
  List<UnitMixin> units = [];
  for (var m in unitTextModels) {
    units.add(Unit(id: m.idController.text, name: m.nameController.text));
  }

  Map<String, dynamic> unitsMap = {};

  for (var u in units) {
    unitsMap.addAll({
      u.id!: {'name': u.name}
    });
  }

  final ref = FirebaseFirestore.instance;
  try {
    await ref.collection('courses').doc(course).set(unitsMap);
  } catch (e) {
    /// Todo error catching here
  }
}

class UnitTextControllerModel {
  final TextEditingController idController;
  final TextEditingController nameController;

  UnitTextControllerModel(this.idController, this.nameController);
}
