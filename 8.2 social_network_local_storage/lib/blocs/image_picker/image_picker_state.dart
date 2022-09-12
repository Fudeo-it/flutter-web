part of 'image_picker_bloc.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();
}

class NoImagePickedState extends ImagePickerState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'NoImagePickedState{}';
}

class LoadingImageState extends ImagePickerState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoadingImageState{}';
}

class PickedImageState extends ImagePickerState {
  final File imageFile;

  const PickedImageState({required this.imageFile});

  @override
  List<Object> get props => [imageFile];

  @override
  String toString() => 'PickedImageState{imageFile: $imageFile}';
}
