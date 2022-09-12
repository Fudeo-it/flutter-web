part of 'pexels_cubit.dart';

abstract class PexelsState extends Equatable {
  const PexelsState();
}

class PexelsLoading extends PexelsState {
  @override
  List<Object> get props => [];
}

class PexelsLoaded extends PexelsState {
  final List<Photo> photos;

  const PexelsLoaded(this.photos);

  @override
  List<Object> get props => [photos];
}

class PexelsError extends PexelsState {
  @override
  List<Object> get props => [];
}
