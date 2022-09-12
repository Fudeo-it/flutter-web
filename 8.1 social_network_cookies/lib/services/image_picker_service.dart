import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImagePickerService {
  Future<File?> pickImageFromCamera();

  Future<File?> pickImageFromLibrary();
}

class ImagePickerServiceImpl extends ImagePickerService {
  @override
  Future<File?> pickImageFromCamera() => _pickImage(ImageSource.camera);

  @override
  Future<File?> pickImageFromLibrary() => _pickImage(ImageSource.gallery);

  Future<File?> _pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}
