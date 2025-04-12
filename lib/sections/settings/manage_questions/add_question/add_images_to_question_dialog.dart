import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../quizzes/quiz_state/edit_question_state.dart';
import '../../methods/pick_image.dart';

class AddImagesToQuestionDialog extends ConsumerWidget {
  const AddImagesToQuestionDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    XFile? selectedImage;
    return AlertDialog(
      content: SizedBox(
        width: size.width * 0.80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                c.images?.length ?? 0,
                (index) => Column(
                  children: [
                    Container(
                      width: size.width * 0.15,
                      height: size.width * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: FileImage(
                            File(c.images![index]!.path),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(c.images?[index]?.name ?? ''),
                    IconButton(
                        onPressed: () {
                          List<XFile?> images = c.images?.toList() ?? [];
                          images.remove(c.images![index]);

                          editNotifier.updateCurrentQuestion(
                              c.copyWith(images: images.toList()));
                        },
                        icon: Icon(Icons.close_outlined))
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceTint,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      selectedImage = await pickImage();
                      if (selectedImage != null) {

                        editNotifier.updateCurrentQuestion(
                          c.copyWith(
                            images: [
                              if (c.images != null) ...c.images!,
                              // existing images
                              selectedImage,
                            ],
                          ),
                        );
                      }
                    },
                    icon: Icon(Icons.add_outlined),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  if (c.images?.isNotEmpty ?? false) ...[
                    Text('${c.images?.first?.name}')
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [OutlinedButton(onPressed: (){

        Navigator.of(context).pop();

      }, child: Text('Close'),),],
    );
  }
}
