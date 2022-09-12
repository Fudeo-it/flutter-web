import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:social_network/services/image_picker_service.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerService imagePickerService;

  ImagePickerBloc({
    required this.imagePickerService,
  }) : super(NoImagePickedState()) {
    on<PickCameraImageEvent>(_pickCameraImage);
    on<PickLibraryImageEvent>(_pickLibraryImage);
    on<ResetImageEvent>(_resetImage);
  }

  void pickCameraImage() => add(PickCameraImageEvent());

  void pickLibraryImage() => add(PickLibraryImageEvent());

  void reset() => add(ResetImageEvent());

  FutureOr<void> _pickCameraImage(
    _,
    Emitter<ImagePickerState> emit,
  ) async {
    emit(LoadingImageState());

    final sourceFile = await imagePickerService.pickImageFromCamera();

    if (sourceFile != null) {
      final destinationFile = await _resizeAndWriteImageFile(sourceFile);

      emit(PickedImageState(imageFile: destinationFile));
    } else {
      emit(NoImagePickedState());
    }
  }

  FutureOr<void> _pickLibraryImage(
    _,
    Emitter<ImagePickerState> emit,
  ) async {
    emit(LoadingImageState());

    final sourceFile = await imagePickerService.pickImageFromLibrary();

    if (sourceFile != null) {
      final destinationFile = await _resizeAndWriteImageFile(sourceFile);

      emit(PickedImageState(imageFile: destinationFile));
    } else {
      emit(NoImagePickedState());
    }
  }

  void _resetImage(_, Emitter<ImagePickerState> emit) =>
      emit(NoImagePickedState());

  Future<File> _resizeAndWriteImageFile(File sourceFile) async {
    final imageFolder = await getTemporaryDirectory();
    final destinationFile = File(p.join(imageFolder.path, 'thumbnail.png'));

    final image = decodeImage(sourceFile.readAsBytesSync())!;
    final thumbnail = copyResize(image, width: 300);
    await destinationFile.writeAsBytes(encodePng(thumbnail));

    return destinationFile;
  }
}
