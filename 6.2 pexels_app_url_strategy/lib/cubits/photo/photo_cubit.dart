import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pexels_app/models/photo.dart';
import 'package:pexels_app/repositories/pexels_repository.dart';

part 'photo_state.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final PexelsRepository pexelsRepository;

  PhotoCubit({required this.pexelsRepository}) : super(PhotoLoading());

  void photo(int id) async {
    emit(PhotoLoading());

    try {
      final photo = await pexelsRepository.photo(id);
      emit(PhotoLoaded(photo));
    } catch (e) {
      emit(PhotoError());
    }
  }
}
