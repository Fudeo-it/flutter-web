part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

abstract class PickImageEvent extends ImagePickerEvent {}

class PickCameraImageEvent extends PickImageEvent {}

class PickLibraryImageEvent extends PickImageEvent {}

class ResetImageEvent extends ImagePickerEvent {}
