import 'package:file_picker/file_picker.dart';
import 'package:flutter_clean_arch/app/interactor/services/choose_directory_service.dart';

class FilePickerChooseDirectoryService implements ChooseDirectoryService {
  @override
  Future<String?> select() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    return selectedDirectory;
  }
}
