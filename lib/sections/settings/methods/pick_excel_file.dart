import 'package:file_picker/file_picker.dart';

Future<FilePickerResult?> pickExcelFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx', 'xls'],
    allowMultiple: false,
    withData: true,
  );

  if (result != null && result.files.single.path != null) {

    return result;
  }
  return null;
}