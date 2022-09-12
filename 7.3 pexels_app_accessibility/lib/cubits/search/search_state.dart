part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final List<Photo> photos;

  const SearchLoaded(this.photos);

  @override
  List<Object> get props => [photos];
}

class SearchError extends SearchState {
  @override
  List<Object> get props => [];
}
