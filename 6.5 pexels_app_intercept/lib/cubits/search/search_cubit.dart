import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pexels_app/models/photo.dart';
import 'package:pexels_app/repositories/pexels_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final PexelsRepository pexelsRepository;

  SearchCubit({required this.pexelsRepository}) : super(SearchLoading());

  void search(String query) async {
    emit(SearchLoading());

    try {
      final photos = await pexelsRepository.search(query);
      emit(SearchLoaded(photos));
    } catch (e) {
      emit(SearchError());
    }
  }
}
