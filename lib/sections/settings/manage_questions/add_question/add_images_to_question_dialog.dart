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
    final editNotifier = ref.read(editQuestionProvider.notifier);
    XFile? selectedImage;
    return AlertDialog(
      content: SizedBox(width: size.width * 0.60,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  // image: DecorationImage(image: AssetImage(selectedImage))
                ),
              ),
              OutlinedButton(onPressed: ()async{
                selectedImage = await pickImage();
                if(selectedImage != null){
                  print('got image ${selectedImage?.name}');
                }
              }, child: Text('Pick local image',),),
            ],
          )
      ),
    );
  }
}
