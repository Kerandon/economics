import 'dart:io';
import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';
import '../../methods/pick_image.dart';

class AddImagesToQuestionDialog extends ConsumerStatefulWidget {
  const AddImagesToQuestionDialog({super.key});

  @override
  ConsumerState<AddImagesToQuestionDialog> createState() =>
      _AddImagesToQuestionDialogState();
}

class _AddImagesToQuestionDialogState
    extends ConsumerState<AddImagesToQuestionDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;

    XFile? pickedImage;
    return AlertDialog(
      content: SizedBox(
        width: size.width * 0.90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuestionImageBuilder(
              c.xFileImages?.toList() ?? [],
              showName: true,
              canRemoveImage: true,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      pickedImage = await pickImage();
                      if (pickedImage != null) {
                        editNotifier.updateCurrentQuestion(
                          c.copyWith(
                            xFileImages: [
                              ...?c.xFileImages, // existing list (null-safe)
                              pickedImage, // new item
                            ],
                          ),
                        );
                      }

                      setState(() {});
                    },
                    icon: const Icon(Icons.add_outlined),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    (c.xFileImages?.isNotEmpty ?? false)
                        ? c.xFileImages!.last!.name
                        : 'Pick image',
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class QuestionImageBuilder extends StatelessWidget {
  const QuestionImageBuilder(
    this.images, {
    this.canRemoveImage = false,
    this.showName = false,
    super.key,
  });

  final List<XFile?> images;
  final bool canRemoveImage;
  final bool showName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Row(
        children: [
          Wrap(
            spacing: size.width * kWrapSpacing,
            children: [
              if (images.isNotEmpty) ...[
                ...List.generate(
                  images.length,
                  (index) => QuestionImageTile(
                    imageFile: images[index]!,
                    canRemoveImage: canRemoveImage,
                    showName: showName,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class QuestionImageTile extends ConsumerWidget {
  final XFile imageFile;
  final double dimensions;
  final bool canRemoveImage;
  final bool showName;

  const QuestionImageTile({
    super.key,
    required this.imageFile,
    this.dimensions = 0.10,
    this.canRemoveImage = false,
    this.showName = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final dim = size.width * dimensions;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    final imageWidget = kIsWeb
        ? Image.network(
            imageFile.path,
            width: dim,
            height: dim,
            fit: BoxFit.cover,
          )
        : Image.file(
            File(imageFile.path),
            width: dim,
            height: dim,
            fit: BoxFit.cover,
          );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Theme.of(context).colorScheme.surfaceTint,
            child: imageWidget,
          ),
        ),
        if (showName) ...[
          Text(imageFile.name),
        ],
        if (canRemoveImage) ...[
          IconButton(
              icon: Icon(Icons.close_outlined),
              onPressed: () {
                List<XFile?> images = c.xFileImages?.toList() ?? [];
                images.remove(imageFile);
                editNotifier.updateCurrentQuestion(
                    c.copyWith(xFileImages: images.toList()));
              }),
        ],
      ],
    );
  }
}
