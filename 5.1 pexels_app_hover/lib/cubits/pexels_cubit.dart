import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pexels_app/models/photo.dart';
import 'package:pexels_app/repositories/pexels_repository.dart';

part 'pexels_state.dart';

class PexelsCubit extends Cubit<PexelsState> {
  final PexelsRepository pexelsRepository;

  PexelsCubit({required this.pexelsRepository}) : super(PexelsLoading());

  void search(String query) async {
    emit(PexelsLoading());

    try {
      final photos = await pexelsRepository.search(query);
      emit(PexelsLoaded(photos));
    } catch (e) {
      emit(PexelsError());
    }
  }
}
