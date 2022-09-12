part of 'photo_cubit.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();
}

class PhotoLoading extends PhotoState {
  @override
  List<Object> get props => [];
}

class PhotoLoaded extends PhotoState {
  final Photo photo;

  const PhotoLoaded(this.photo);

  @override
  List<Object> get props => [photo];
}

class PhotoError extends PhotoState {
  @override
  List<Object> get props => [];
}
